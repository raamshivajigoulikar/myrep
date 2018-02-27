/****************************************
Remote Sign-on to WRDS Server
****************************************/
%let wrds = wrds.wharton.upenn.edu 4016;
options comamid=TCP;
signon wrds username=_prompt_;
 
/***********************************/
/* MAIN BODY OF THE PROGRAM        */
/***********************************/
 
RSUBMIT;

 
options errors=1 noovp;
options nocenter ps=max ls=78;
options mprint source nodate symbolgen macrogen;
options msglevel=i;
 
libname tmp '~'; *define a home directory on WRDS;

data msf;
		set crsp.msf;
		where date ge '31DEC1995'd and hexcd in (1,2,3);
		date=intnx('month',date,0,'end');
		vol=abs(vol);
		svol=abs(vol/(shrout*1000));
		dvol=abs(vol*prc);
		keep permno cusip date hexcd prc vol svol dvol;
	run;
	
proc sort nodupkey; by permno date; run;


/* This macro will take in several parameters like
 * the input dataset, the output dataset, the id variable, the date variable
 * and the actual variable to be lagged or led (e.g. FOO) and the number of lead/lags
 * It creates output dataset with all the original dataset variables and
 * the requested number of lead/lag variables, labeled as below
 * lFOO1 - lFOO12 for 12 lags
 *  FOO1 -  FOO12 for 12 leads

 * Caveat: need to provide a dataset that has at least some assets for every date to be covered
 * If some dates are completely missing for all assets, then some lagged variables will be
 * farther than one period apart ;
 * Date var has to be sortable, so yymm string would not do, need a yyyymm string, or sas date

 * parameters
 * id - identifier to sort by (e.g. cusip, keyid)
 * date_var - date variable (e.g. yyyymm, monthend_dt, sasdate)
 * var - variable to lead/lag
 * in_ds - input dataset
 * out_ds - output dataset
 * NLAGS  - number of lags  desired
 * NLEADS - number of leads desired
 * Example:


  %lagit(id=cusip,date_var=yyyymm,var=stw,in_ds=nb.kmv_mer,out_ds=test,NLAGS=1,NLEADS=1);

  the output dataset test will contain the original variables from nb.kmv_mer,
      including stw, stw1 and lstw1, corresponding to the
      original value, the 1-month lead and the one-month lag value

*/

%macro lagit(id=,date_var=,var=,in_ds=,out_ds=,NLAGS=,NLEADS=);
* keep just what we need;
   data ret;
       set &in_ds (keep = &date_var &id &var);
   run;


   proc sort data = work.ret force nodups;
       by &id &date_var;
   run;

* now make sure there are no gaps;

*first create list of all dates;
   proc sql;
       create table dates
           as select distinct &date_var
           from ret
           order by &date_var
           ;

* for each asset find the first and last date of its occurrence;
   proc sql;
       create table id_date
           as
           select &id, min(&date_var) as min_&date_var, max(&date_var) as max_&date_var
           from ret
           group by &id
           order by &id
           ;

* select all possible combinations of dates and ids such that there are no gaps;
   proc sql;
       create table ret_no_gap
           as
           select distinct a.&id, b.&date_var
           from
           id_date a,
           dates b
           where b.&date_var between a.min_&date_var and a.max_&date_var
           ;
* now perform a merge of  ret_no_gap and ret;
   proc sort data = ret;
       by &id &date_var;
   proc sort data = ret_no_gap;
       by &id &date_var;
   data ret;
       merge ret_no_gap ret;
       by &id &date_var;
   run;

   proc sort data = work.ret;
       by &id &date_var;
   run;

   %IF &NLAGS > 0 %THEN %DO;

       %macro lagrets;
           data work.lagrets;
               set work.ret;
               by &id;

               array lagrets {*} l&var.1-l&var.&NLAGS;

               %do i = 1 %to &NLAGS;
                   lagrets{&i} = lag&i.(&var);
                   IF lag&i.(&id) ^= &id THEN lagrets{&i} = .;
                   %end;

           run;
           %mend lagrets;

       %lagrets;
       proc sort data = lagrets;
           by &id &date_var;
           %END;


       %IF &NLEADS > 0 %THEN %DO;
* now reverse date sort order to get the leading returns;
       proc sort data = work.ret;
           by &id descending &date_var;
       run;

       %macro leadrets;
           data work.leadrets;
               set work.ret;
               by &id;

               array leadrets {*} &var.1-&var.&NLEADS;

               %do i = 1 %to &NLEADS;
                   leadrets{&i} = lag&i.(&var);
                   IF lag&i.(&id) ^= &id THEN leadrets{&i} = .;
                   %end;

           run;
           %mend leadrets;

       %leadrets;
       proc sort data = leadrets;
           by &id &date_var;
           %END;

* merge to the main dataset;
   proc sort data = &in_ds force;
       by &id &date_var;
   data &out_ds;
       merge &in_ds (in = main)
           %IF &NLEADS > 0 %THEN %DO; leadrets %END;
           %IF &NLAGS  > 0 %THEN %DO; lagrets  %END;
               ;
       by &id &date_var;
       if main;
   run;
   %mend lagit;

*%lagit(id=cusip,date_var=yyyymm,var=stw,in_ds=nb.kmv_mer,out_ds=test,NLAGS=1,NLEADS=1);


*%winsor(dsetin=cstat, byvar=none, vars=cfo wcd1 earn cfom1 cfop1, type=delete, pctl=0.5 99.5);

%macro winsor(dsetin=, dsetout=, byvar=none, vars=, type=winsor, pctl=1 99);

%if &dsetout = %then %let dsetout = &dsetin;

%let varL=;
%let varH=;
%let xn=1;

%do %until ( %scan(&vars,&xn)= );
%let token = %scan(&vars,&xn);
%let varL = &varL &token.L;
%let varH = &varH &token.H;
%let xn=%EVAL(&xn + 1);
%end;

%let xn=%eval(&xn-1);

data xtemp;
set &dsetin;
run;

%let dropvar = ;
%if &byvar = none %then %do;

data xtemp;
set xtemp;
xbyvar = 1;
run;

%let byvar = xbyvar;
%let dropvar = xbyvar;

%end;

proc sort data = xtemp;
by &byvar;
run;

proc univariate data = xtemp noprint;
by &byvar;
var &vars;
output out = xtemp_pctl PCTLPTS = &pctl PCTLPRE = &vars PCTLNAME = L H;
run;

data &dsetout;
merge xtemp xtemp_pctl;
by &byvar;
array trimvars{&xn} &vars;
array trimvarl{&xn} &varL;
array trimvarh{&xn} &varH;

do xi = 1 to dim(trimvars);

%if &type = winsor %then %do;
if trimvars{xi} ne . then do;
if (trimvars{xi} < trimvarl{xi}) then trimvars{xi} = trimvarl{xi};
if (trimvars{xi} > trimvarh{xi}) then trimvars{xi} = trimvarh{xi};
end;
%end;

%else %do;
if trimvars{xi} ne . then do;
if (trimvars{xi} < trimvarl{xi}) then trimvars{xi}=.;
if (trimvars{xi} > trimvarh{xi}) then trimvars{xi}=.;
end;
%end;

end;
drop &varL &varH &dropvar xi;
run;

%mend winsor; 


%lagit(id=permno,date_var=date,var=vol,in_ds=msf,out_ds=msf,NLAGS=12);

%lagit(id=permno,date_var=date,var=dvol,in_ds=msf,out_ds=msf,NLAGS=12);

%lagit(id=permno,date_var=date,var=svol,in_ds=msf,out_ds=msf,NLAGS=12);

data tmp.volume;
		set msf;
		if nmiss(of lvol1-lvol12)=0 then rvolume=sum(of lvol1-lvol12);
		if nmiss(of lsvol1-lsvol12)=0 then svolume=sum(of lsvol1-lsvol12);
		if nmiss(of lvol1-lvol12)=0 then dvolume=sum(of ldvol1-ldvol12);
		keep permno date hexcd rvolume svolume dvolume;
		if rvolume ne .;
	run;

*GET evol;

proc sql;
	create table compann as
	select GVKEY, FYEAR, DATADATE as FYENDDT,
	AT,SALE, IB, EMP, OANCF
	from comp.funda
	where GVKEY ne '' and  curcd = 'USD' and indfmt='INDL' and datafmt='STD' 
	and consol='C' and DATADATE >= '31DEC1985'd and ib ne . and AT ge 10 and SALE ge 10;
quit;
proc sort nodupkey; by gvkey fyear; run;

proc sql;
		create table compann as
		select a.*,a.ib*2/(a.at+b.at) as roa,a.at/b.at-1 as agr, a.sale/b.sale-1 as sgr,a.emp/b.emp-1 as egr
		from compann a, compann b
		where a.gvkey=b.gvkey and a.fyear=b.fyear+1;
		quit;
		
proc sort nodupkey; by gvkey fyear; run;

%winsor(dsetin=compann, byvar=fyear, vars=roa agr sgr egr, type=winsor, pctl=1 99);

%lagit(id=gvkey,date_var=fyear,var=roa,in_ds=compann,out_ds=compann,NLAGS=4);

%lagit(id=gvkey,date_var=fyear,var=agr,in_ds=compann,out_ds=compann,NLAGS=4);

%lagit(id=gvkey,date_var=fyear,var=sgr,in_ds=compann,out_ds=compann,NLAGS=4);

%lagit(id=gvkey,date_var=fyear,var=egr,in_ds=compann,out_ds=compann,NLAGS=4);

data tmp.evol;
		set compann;
		if nmiss(of agr lagr1-lagr4)=0 then aagr=mean(of agr lagr1-lagr4);
		if nmiss(of sgr lsgr1-lsgr4)=0 then asgr=mean(of sgr lsgr1-lsgr4);
		if nmiss(of egr legr1-legr4)=0 then aegr=mean(of egr legr1-legr4);
		if nmiss(of roa lroa1-lroa4)=0 then evol=std(of roa lroa1-lroa4);
		
		keep gvkey fyear fyenddt at evol agr aagr sgr asgr egr aegr;
	run;
	
	
	
*GET exfin;
proc sql;
	create table compann as
	select GVKEY, FYEAR, DATADATE as FYENDDT,IB, OANCF,SALE,XIDOC,
	AT,SSTK, ACT, PRSTKC,DV, DLTIS, DLTR,DLCCH, abs(PRCC_F*CSHO) as capt, OANCF,IVNCF,
	(max(0,ACT)-max(0,CHE))-(max(0,LCT)-max(0,DLC)) as WC, (AT-ACT-max(0,IVAO))-(LT-LCT-max(0,DLTT)) as NCO,
	(max(0,IVST)+max(IVAO,0))-(max(0,DLTT)+max(0,DLC)+max(0,PSTK)) as FIN,CAPX,DP, DPC
	
	from comp.funda
	where GVKEY ne '' and  curcd = 'USD' and indfmt='INDL' and datafmt='STD' 
	and consol='C' and DATADATE >= '31DEC1985'd;
quit;

proc sort nodupkey; by gvkey fyear; run;

data compann;
		set compann;
		if xidoc=. then xidoc=0;
		if DP=. then DP=DPC;
		if DP=. then DP=0;
	run;



proc sql;
	create table compann as
	select a.*,b.AT as LAT1,b.capt as LCAPT1,2*(a.IB)/(a.AT+b.AT) as ROA, 
	2*(a.IB-a.OANCF+a.XIDOC)/(a.AT+b.AT) as ACC, 2*(a.oancf-a.XIDOC)/(a.AT+b.AT) as CFO,2*a.oancf/(a.AT+b.AT) as CROA,
	2*a.SALE/(a.AT+b.AT) as ATO,a.IB/a.SALE as MG,(a.IB <0 and a.IB ne .) as LOSS,2*(a.oancf+a.ivncf)/(a.AT+b.AT) as FCF,2*(a.ivncf)/(a.AT+b.AT) as CFI,
	2*(a.WC-b.WC)/(a.AT+b.AT) as dWC,2*(a.NCO-b.NCO)/(a.AT+b.AT) as dNCO,2*(a.FIN-b.FIN)/(a.AT+b.AT) as dFIN,2*a.CAPX/(a.AT+b.AT) as CAPEX,
	2*a.DP/(a.AT+b.AT) as DPA
	from compann a, compann b
	where a.gvkey=b.gvkey and a.fyear=b.fyear+1;
quit;

data compann;
	set compann;
	array avar SSTK  PRSTKC DV  DLTIS  DLTR DLCCH;
	do over avar;
	if avar =. Then avar=0;
	end;
	EXFA=2*( SSTK -PRSTKC- DV + DLTIS-  DLTR+ DLCCH)/(AT+LAT1);
	EXFB=2*( SSTK -PRSTKC- DV + DLTIS-  DLTR+ DLCCH)/(CAPT+LCAPT1);
	ISSA=2*SSTK/(AT+LAT1);
	ISSB=2*SSTK/(CAPT+LCAPT1);	
	FCFA=2*sum(of OANCF IVNCF)/(AT+LAT1);	
	FCFb=2*sum(of OANCF IVNCF)/(CAPT+LCAPT1);	
	if dWC ne . then TACC=sum(of dWC dNCO dFIN);
	Keep gvkey fyear fyenddt act exfa exfb issa issb fcfa fcfb ROA ACC CFO ROA ATO MG dWC dNCO dFIN TACC FCF CFI LOSS CROA CAPEX DPA;
run;

%winsor(dsetin=compann, byvar=fyear, vars=exfa exfb issa issb fcfa fcfb ACC CFO ROA ATO MG dWC dNCO dFIN TACC FCF CROA CAPEX DPA, type=winsor, pctl=1 99);

data tmp.exfin;
		set compann;
	run;
	

	
	
	

proc sql;
	create table tmp.fdisp as
	select ticker, statpers, meanest, numest, stdev, fpedats
	from ibes.statsum_epsus
	where usfirm=1 and ticker ne '' and measure='EPS' and fiscalp='ANN' and fpi='1';
	quit;
	

data tmp.prc;
		set ibes.actpsum_epsus;
		keep ticker statpers prdays price shout;
		where usfirm=1 and statpers ge '31DEC1980'd;
	run;
	
proc sort nodupkey; by ticker statpers; run;

%master;



**get ihold;

*GET NCUSIP and PERMNO MAPPING;

proc sql;
create table names as 
select distinct
permno, ncusip, min(date) as st_date, max(date) as lastdate
from crsp.dseall(keep=ncusip permno date where=(ncusip ne ''))
group by permno, ncusip order by permno, st_date desc; 
quit;

data tmp.names;
set names;
lagst_date = lag(st_date) - 1;
if permno = lag(permno) then end_date = lagst_date; else end_date = lastdate;
format st_date end_date yymmddn8.;
drop lastdate lagst_date;
run; 

	
data names;
 set tmp.names;
 run;
 


%macro ihold;

data ihold;
		set _null_;
	run;
	
%do year=1998 %to 2017 %by 1;
	
%let lyear=%eval(&year-1);

data ihold&year;
	set tfn.s34;
	
	where rdate ge "01jan&lyear"d and rdate le "31dec&year"d  and shares >0 and cusip ne '';
	rdate=intnx('month',rdate,0,'end');
	fyymm=year(fdate)*100+month(fdate);
	ryymm=year(rdate)*100+month(rdate);
	if shrout2 ne . then shrout=shrout2*1000;
	else shrout=shrout1*1000000;
	ioa=shares/shrout;
		
keep cusip fdate mgrno rdate shares ioa fyymm ryymm;
run;



proc sort data=ihold&year nodupkey; by cusip mgrno rdate; run;


proc sort data=ihold&year out=nmgr&year nodupkey;
		by mgrno rdate;
	run;

proc sql;
		create table nmgr&year as
		select rdate,freq(mgrno) as nmgr
		from nmgr&year
		group by rdate;
		quit;

proc sort nodupkey; by rdate; run;	
	
	
proc sql;
		create table ihold&year as
		select cusip,rdate,freq(shares) as nh,sum(ioa) as pcth
		from ihold&year
		where rdate ge "01jan&year"d
		group by rdate,cusip
		order by rdate,cusip;


		create table ihold&year as
		select a.*,b.nmgr
		from ihold&year a, nmgr&year b
		where a.rdate=b.rdate;
		quit;

proc sort nodupkey; by cusip rdate; run;	

proc sql;
 create table ihold&year as
 select a.*,b.permno 
 from ihold&year a, names b
 where a.cusip=b.ncusip and a.rdate ge b.st_date and a.rdate le b.end_date;
 quit;

proc sort nodupkey; by permno rdate; run;


data ihold;
		set ihold ihold&year;
	run;
		
proc datasets;
	delete ihold&year nmgr&year;
run;

%end;

data tmp.ihold;
		set ihold;
	run;
	
%mend;

		
%ihold;






	
*Get beta and idvol;

data dsf;
		set crsp.dsf;
		where date > '31DEC1997'd and ret ge -1;
		year=year(date);
		keep permno date ret year;
	run;
	
proc sql;
		create table samp as
		select permno,date as mdate
		from crsp.msf
		where date > '31DEC1998'd;
		quit;
		
proc sort nodupkey; by permno mdate; run;

data samp;
		set samp;
		format mdate bgdate yymmdd10.;		
		bgdate=intnx('month',mdate,-6,'end');
		mdate=intnx('month',mdate,0,'end');
		year=year(mdate);
	run;
	
	
%macro getbeta;
	
data beta;
		set _null_;
	run;
	
		%do yr=1998 %to 2017 %by 1;
		
		data samp&yr;
				set samp;
				where year=&yr;
				drop year;
			run;
		data dsf&yr;
				set dsf;
				if year le &yr and year ge (&yr.-1);
run;
		
proc sql;
		create table samp&yr as
		select a.*,b.date,b.ret
		from samp&yr a, dsf&yr b
		where a.permno=b.permno and b.date >a.bgdate and b.date le a.mdate;
		quit;
		


proc sql;
		create table dsf&yr as
		select a.*,b.mktrf+b.rf as mkt
		from samp&yr a, ff.factors_daily b
		where a.date=b.date;
		quit;
		
proc sort nodupkey; by permno mdate date; run;

proc sql;
		create table dsf&yr as
		select *
		from dsf&yr 
		group by permno,mdate
		having count(*) ge 50;
		quit;
		
	
				
proc sort; by permno mdate; run;

proc means data=dsf&yr noprint;
		by permno mdate;
		var ret;
		output out=sk&yr skewness=skew kurtosis=kurt;
	run;
	

proc reg noprint data=dsf&yr outest=beta&yr edf;
	by permno mdate;
	model ret=mkt;
run;

data beta&yr;
		set beta&yr;
		where _TYPE_='PARMS';
		n=_EDF_+1;
		idvol=_rmse_;
		beta=mkt;
		
		yymm=year(mdate)*100+month(mdate);
		date=mdate;
		
		
		keep permno date n beta idvol;
	run;
		
proc sql;
		create table beta&yr as 
		select a.*,b.skew,b.kurt
		from beta&yr a, sk&yr b
		where a.permno=b.permno and a.date=b.mdate;
	quit;
	
	
data beta;
		set beta beta&yr;
	run;
	
proc datasets;
		delete beta&yr samp&yr dsf&yr;
	run;
		
%end;

data tmp.betaivol;
		set beta;
	run;
	
%mend;

%getbeta;

data detu;
	set ibes.ptgdetu;
	format date yymmdd10.;
	where usfirm=1 and ticker ne '' and value ne .;
	date=intnx('month',anndats,0,'end');
	keep ticker actdats horizon value amaskcd anndats date;
	run;

proc sort nodupkey; by ticker amaskcd anndats; run;
proc sql;
		create table detu as
		select a.*,b.permno 
		from detu a, home.iclink b
		where a.ticker=b.ticker;
		quit;
		
proc sort nodupkey; by permno amaskcd anndats; run;

data tmp.dsf;
		set crsp.dsf;
		prc=abs(prc);
		WHERE DATE GE '31DEC1998'D;
		mdate=intnx('month',date,0,'end');
		keep permno date prc ret cfacpr shrout mdate;
	run;

proc sql;
		create table tmp.tpu as
		select a.*,b.cfacpr
		from detu a, tmp.dsf b
		where a.permno=b.permno and a.anndats-b.date ge 0 and  a.anndats-b.date le 5
		group by a.permno,a.amaskcd,a.anndats
		having b.date=max(b.date);
		quit;
		
proc sort nodupkey; by ticker amaskcd anndats; run;	
	
data tmp.ccmxpf_linktable;	
	set crsp.ccmxpf_linktable;	
run;	
	
	
	
	
	
*local computer;


data samp;
		set tmp.dsf;
		date=intnx('month',date,0,'end');
		if date  >'31DEC1998'd;
		keep permno date;
	run;
	
		
proc sort data=samp out=samp nodupkey;
		by permno date;
	run;

	

proc sort data=samp nodupkey;
		by permno date;
	run;
	
	
proc sql;
		create table samp as
		select a.*,b.ticker
		from samp a, home.iclink b
		where a.permno=b.permno;
		quit;
		
		
	/*
proc sql;
		create table samp as
		select ticker,permno,date,freq(value) as freq
		from tmp.tpu
		group by ticker,date;
		quit;
		*/;
proc sort nodupkey; by ticker date; run;
	
data tpu;
		set tmp.tpu;
		avalue=value/cfacpr;
		zff=((value-int(value/10)*10) in (0,5));
	run;
	
proc sql;
		create table tpcon as
		select a.ticker,a.date,a.permno,b.amaskcd,b.anndats,b.avalue,b.zff
		from samp a, tpu b
		where a.ticker=b.ticker and intck('day',b.anndats,a.date) ge 0 and intck('day',b.anndats,a.date) le 90
		group by a.ticker,b.amaskcd,a.date
		having b.anndats=max(b.anndats);
		quit;
		
	
proc sql;
		create table prc as
		select permno,mdate as date,prc,prc/cfacpr as aprc
		from tmp.dsf
		group by permno,mdate
		having date=max(date);
		quit;
		
proc sort nodupkey; by permno date; run;

data tmp.mprc;
		set prc;
		keep permno date aprc;
	run;


proc sql;
		create table tpcon as 
		select ticker,permno,date,avg(avalue) as adjtp,avg(zff) as pctrd, 
		freq(avalue) as nana, max(avalue)-min(avalue) as rang
		from tpcon
		group by ticker,permno,date;
		
		create table tmp.impret as
		select a.*,b.prc,a.adjtp/b.aprc-1 as impret,b.aprc
		from tpcon a, prc b
		where a.permno=b.permno and a.date=b.date;
		quit;
		
	data tmp.tprc;
			set tmp.impret;
			keep permno date adjtp;
		run;
proc sql;
		create table tpcon1m as
		select a.ticker,a.date,a.permno,b.amaskcd,b.anndats,b.avalue,b.zff
		from samp a, tpu b
		where a.ticker=b.ticker and intck('day',b.anndats,a.date) ge 0 and intck('day',b.anndats,a.date) le 30
		group by a.ticker,b.amaskcd,a.date
		having b.anndats=max(b.anndats);

		create table tpcon1m as 
		select ticker,permno,date,avg(avalue) as adjtp1m,avg(zff) as pctrd1m
		from tpcon1m
		group by ticker,permno,date;
		
		create table tmp.impret as
		select a.*,b.adjtp1m/a.aprc-1 as impret1m
		from tmp.impret a left join tpcon1m b
		on a.ticker=b.ticker and a.permno=b.permno and a.date=b.date;
		quit;
				
				
	
data impret;
		set tmp.impret;
		yymm=year(date)*100+month(date);
		date1=intnx('month',date,1,'end');
		yymm1=year(date1)*100+month(date1);
		drop prc;
	run;
		
proc sql;
		create table tpm as
		select a.*,b.bm,b.size,b.mom,b.rvol,b.turn, b.sic,b.hexcd
		from impret a, tmp.master b
		where a.permno=b.permno and a.yymm=b.yymm;
		quit;
		
proc sql;
		create table tpm as
		select a.*,b.cret12m,b.ret1,b.ret2,b.ret3,b.ret4,b.ret5,b.ret6,b.ret,b.sar1,b.capt,b.prc
		from tpm a, tmp.master b
		where a.permno=b.permno and a.yymm=b.yymm;
		quit;
		
		
		
proc sort data=tmp.exfin out=exfin nodupkey; 
	by gvkey fyenddt;
	run;

proc sort data=tmp.evol out=evol nodupkey; 
	by gvkey fyenddt;
	run;

data exfin;
	merge exfin (in=a) evol (in=b);
	by gvkey fyenddt;
	if a or b;
	run;

proc sql;
  create table exfin as 
  select a.*,b.lpermno as permno
  from exfin as a, tmp.ccmxpf_linktable as b
  where a.gvkey = b.gvkey and
  b.LINKTYPE in ("LU","LC","LD","LN","LS","LX") and
  b.usedflag=1 and
  (b.LINKDT <= a.fyenddt or b.LINKDT = .B) and (a.fyenddt <= b.LINKENDDT or b.LINKENDDT = .E);
 quit;
	
proc sort nodupkey; by permno fyenddt; run;

proc sql;
		create table tpm as
		select a.*,b.at, b.exfa as exfa,b.exfb as exfb,b.fcfa as fcfa,b.fcfb as fcfb,
		b.cfo,b.acc,b.roa,b.ato,b.mg,b.loss, b.evol,b.dwc,b.tacc,b.agr,b.sgr,b.egr,
		b.aagr,b.asgr,b.aegr,b.dWC,b.FCF,b.CFI,b.CROA,b.capex
		from tpm a left join exfin b
		on a.permno=b.permno and intck('month',b.fyenddt,a.date) ge 4 and intck('month',b.fyenddt,a.date) le 15
		group by a.ticker,a.date
		having b.fyenddt=max(b.fyenddt);
		quit; 


proc sql;
		create table tpm as
		select a.*,b.exfa as exfa1,b.exfb as exfb1,b.fcfa as fcfa1,b.fcfb as fcfb1
		from tpm a left join exfin b
		on a.permno=b.permno and intck('month',b.fyenddt,a.date) ge -8 and intck('month',b.fyenddt,a.date) le 3
		group by a.ticker,a.date
		having b.fyenddt=max(b.fyenddt);
		quit; 


proc sql;
		create table tpm as
		select a.*,b.pcth as ihold,b.nh/b.nmgr as brth
		from tpm a left join tmp.ihold b
		on a.permno=b.permno and a.date ge b.rdate+45 and a.date le b.rdate+365
		group by a.permno,a.date
		having b.rdate=max(b.rdate);
		
		create table tpm as
		select a.*,b.beta,b.idvol
		from tpm a, tmp.betaivol b
		where a.permno=b.permno and a.date=b.date;
		
		
		create table tmp.tpm as
		select a.*,b.dvolume,b.svolume
		from tpm a, tmp.volume b
		where a.permno=b.permno and a.date=b.date;
		
		
		quit;
		
proc sort nodupkey; by date permno; run;




*GET leverage;

proc sql;
	create table compann as
	select GVKEY, FYEAR, DATADATE as FYENDDT,SICH as SIC,
	AT,CHE,LSE,DLTT,DP, IB, SSTK, DVC, DVP, DLC, CEQ, NI, TEQ,SALE, PPENT,DV, abs(PRCC_C*CSHO) as capt,TXDB,OANCF,OPTOSEY,OPTEX,CSHO
	from comp.funda
	where GVKEY ne '' and  curcd = 'USD' and indfmt='INDL' and datafmt='STD' 
	and consol='C' and DATADATE >= '31DEC1987'd;
quit;

proc sort nodupkey; by gvkey fyear; run;

proc sql;
	create table compann as
	select a.*,b.AT as LAT1
	from compann a, compann b
	where a.gvkey=b.gvkey and a.fyear=b.fyear+1;
quit;

data tmp.lev;
	set compann;
	DILA=OPTOSEY/CSHO;
	DILB=OPTEX/CSHO;
	LEV=sum(of DLTT DLC)/AT;
	DIVY=max(0,sum(of DVC DVP))/CAPT;
	ROA=IB*2/(AT+LAT1);
	keep gvkey fyear fyenddt DILA DILB LEV DIVY ROA;
	run;
	
	
%winsor(dsetin=tmp.lev, byvar=fyear, vars=DILA DILB LEV DIVY ROA, type=winsor, pctl=1 99);



proc sql;
  create table tmp.lev as 
  select a.*,b.lpermno as permno
  from tmp.lev as a, tmp.ccmxpf_linktable as b
  where a.gvkey = b.gvkey and
  b.LINKTYPE in ("LU","LC","LD","LN","LS","LX") and
  b.usedflag=1 and
  (b.LINKDT <= a.fyenddt or b.LINKDT = .B) and (a.fyenddt <= b.LINKENDDT or b.LINKENDDT = .E);
 quit;
	
proc sort nodupkey; by permno fyenddt; run;


*GET MAXPREt;

data detu;
	set ibes.ptgdetu;
	format date yymmdd10.;
	where usfirm=1 and ticker ne '' and value ne .;
	date=intnx('month',anndats,0,'end');
	keep ticker actdats horizon value amaskcd anndats date;
	run;

proc sort nodupkey; by ticker amaskcd anndats; run;
proc sql;
		create table detu as
		select a.*,b.permno 
		from detu a, home.iclink b
		where a.ticker=b.ticker;
		quit;
		
proc sort nodupkey; by permno amaskcd anndats; run;

proc sql;
	create table samp as
	select distinct permno 
	from detu;
	quit;
	
proc sort nodupkey; by permno; run;


data mret;
	set crsp.msf;
	where date ge '31DEC1998'd;
	format mdate edate yymmdd10.;
	mdate=intnx('month',date,0,'end');
	edate=intnx('month',mdate,12,'end');
	prc=abs(prc);
	yymm=year(mdate)*100+month(mdate);
	
	keep permno mdate edate yymm prc cfacpr;
	run;
	
proc sql;
	create table mret as
	select a.*
	from mret a, samp b
	where a.permno=b.permno;
	quit;
	
	

data tmp.dsfx;
		set crsp.dsf;
		prc=abs(prc);
		WHERE DATE GE '31DEC1998'D;
		keep permno date prc ret cfacpr ;
	run;

%macro getmaxp;
data mydata;
	set _null_;
	run;
	
%do yr=1998 %to 2017;
%do mon=1 %to 12;
%let myymm=%eval(&yr*100+&mon);

data temp&myymm;
	set mret;
	where yymm=&myymm;
	run;
	
proc sql;
	create table temp&myymm as
	select a.permno,a.mdate,a.yymm,a.prc as bgprc,a.cfacpr as bgcfacpr,b.date,b.prc,log(1+b.ret) as logret,b.cfacpr
	from temp&myymm a, tmp.dsfx b
	where a.permno=b.permno and b.date>a.mdate and b.date le a.edate;
	quit;
	
data temp&myymm;
	set temp&myymm;
	pret=(prc/cfacpr)/(bgprc/bgcfacpr)-1;
	fm=permno||yymm;
run;

proc sort; by fm; run;

data temp&myymm;
	set temp&myymm;
	by fm;
	retain clogret 0;
	clogret+logret;
	if first.fm then clogret=logret;
	run;
	
proc sql;
	create table temp&myymm as
	select permno,mdate,max(pret) as maxpret,exp(max(clogret))-1 as maxtret,
	min(pret) as minpret,exp(min(clogret))-1 as mintret
	from temp&myymm 
	group by permno,mdate;
	quit;
	
data mydata;
	set mydata temp&myymm;
	run;
	
%end;
%end;

data tmp.maxret;
	set mydata;
	run;
%mend;


%getmaxp;








	
%let bgdt='31DEC1998'd;
%let eddt='31DEC2016'd;



data monthlyreturns;
	set crsp.msf;
	where date > &bgdt and date le &eddt;
	ret=retx;
	keep permno date ret;
run;

* The monthly delisting dataset;
data delist;
    set crsp.mse;
    where dlstcd > 199;
    keep permno date dlstcd dlpdt dlret;
run;

proc sql;
    create table rvtemp as
	select * from crsp.dse
	where dlstcd > 199 and 1975 le year(DATE) le 2020
	order by dlstcd;

proc univariate data=rvtemp noprint;
    var dlret;
    output out=rv mean=mean_dlret probt=mean_pvalue;
    by dlstcd;
run;

* require replacement values to be statistically significant;
data rv;
    set rv;
    if mean_pvalue le 0.05 then rv = mean_dlret; * adjust p-value as desired;
    else rv = 0; * adjust as desired;
    keep dlstcd rv;
run;

* Merge replacement values with delisting returns;

proc sql;
    create table delist as
	select a.*, b.rv
	from delist a left join rv b
	on a.dlstcd = b.dlstcd;

proc sql;
    create table monthlyreturns as
	select a.*, b.dlret, b.dlstcd, b.rv, b.date as dldate, b.dlpdt
	from monthlyreturns a left join delist b
	on (a.permno = b.permno)
	and (month(a.date)= month(b.date))
	and (year(a.date) = year(b.date));
    quit;
    

data monthlyreturns;
    set monthlyreturns;
    ret_orig = ret;
    
    ** First, use replacement values where necessary;
    if not missing(dlstcd) and missing(dlret) then dlret=rv;
    * note, this will happen when the delisting occurs on the last day of the month;
    * and ret is not missing, but the delisting return is unknown;

    else if not missing(dlstcd) and dlpdt le dldate and not missing(dlret) then dlret=(1+dlret)*(1+rv)-1;
    * If delisting return is a partial month return, it is identified;
    * by CRSP by the dlpdt being set to a date less than or equal to;
    * the delisting date;
    * Could use a single replacement value as in Shumway, like -0.35. (Sloan, 1996, used -1.0);
    * would only do single replacement value for a subset of delisting codes > 499;

    ** Second, incorporate delistings into monthly return measure;
    if not missing(dlstcd) and missing(ret) then ret=dlret;
    else if not missing(dlstcd) and not missing(ret) then ret=(1+ret)*(1+dlret)-1;
    
    drop dlret dlstcd rv dldate dlpdt;
run;

	
data mret;
	set monthlyreturns;
	if ret=-1 then ret=ret+0.000000001;
	logret=log(1+ret);
	yymm=year(date)*100+month(date);
	keep permno date yymm ret logret;
	run;



%lagit(id=permno,date_var=date,var=logret,in_ds=mret,out_ds=mret,NLEADS=12);


data tmp.cxret;
		set mret;
				if yymm le 201512;
			cxret12m=exp(sum(of logret1-logret12))-1;
		
		keep permno date  cxret12m;
 	run;
 	
	
	
	data tpm;
		set tmp.tpm;
		logvol=log(dvolume);
	run;
	
%winsor(dsetin=tpm, byvar=yymm, vars=brth logvol, type=winsor, pctl=3 97);

proc sort; by date; run;
proc rank data=tpm out=tpm groups=10;
		by date;
		var at;
		ranks rat;
	run;
	
proc sql;
		create table tpmx as
		select *,brth-avg(brth) as irec, logvol-avg(logvol) as dvol
		from tpm
		group by date,rat;
	quit;
ods html file='try.html';
proc freq data=tpmx; table date; run;
	
	/*
proc sql;
	create table tpmx as
	select a.*,b.skew,b.kurt
	from tpmx a left join tmp.betaivol b
	on a.permno=b.permno and a.date=b.date;
	quit;
*/;

proc sql;
		create table tpmx as
		select a.*,b.DILA,b.DILB,b.LEV,b.DIVY
		from tpmx a left join tmp.lev b
		on a.permno=b.permno and intck('month',b.fyenddt,a.date) ge -8 and intck('month',b.fyenddt,a.date) le 3
		group by a.ticker,a.date
		having b.fyenddt=max(b.fyenddt);
		quit; 
		

proc sql;
	create table tmp.tpmx as
	select a.*,b.cxret12m
	from tpmx a left join tmp.cxret b
	on a.permno=b.permno and intck('month',a.date,b.date)=0;
	quit;
proc freq data=tmp.tpmx; table yymm; run;

proc corr data=tmp.tpmx; var cret12m cxret12m; run;
	
	
proc sql;
	create table tmp.tpmx as
	select a.*,b.maxpret,b.maxtret,b.minpret,b.mintret
	from tmp.tpmx a left join tmp.maxret b
	on a.permno=b.permno and a.date=b.mdate;
	quit;



*GET Forecast errors;


  
data act;
    set ibes.actu_epsus;
    where usfirm=1 and measure="EPS" and pdicity='ANN' and value ne . and anndats ne . and pends ne .;
    act=value;
    fpedats=pends;
    keep ticker anndats act fpedats;
  run;
  


proc sql;
    create table fy1 as
    select ticker,statpers,meanest as fy1,numest as acov,fpedats
    from ibes.statsumu_epsus
    where fpi='1' and fiscalp='ANN' and usfirm=1;
    *group by ticker,fpedats
    *having statpers=max(statpers);
  quit;
  


proc sql; 
  create table ferr as
  select a.*,b.fy1,b.acov
  from act a, fy1 b
  where a.ticker=b.ticker and a.fpedats=b.fpedats and intck('month',b.statpers,a.fpedats)=9;
quit;

proc sort nodupkey; by ticker fpedats; run;


data tmp.prc;
		set ibes.actpsum_epsus;
		keep ticker statpers prdays price shout;
		where usfirm=1 and statpers ge '31DEC1990'd;
	run;
	
proc sort nodupkey; by ticker statpers; run;

proc sql;
		create table tmp.ferrb as
		select a.*,b.price
		from ferr a, tmp.prc b
		where a.ticker=b.ticker and intck('month',b.statpers,a.fpedats)=9;
quit;

*Get monthly eps bias;

*GET Forecast errors;


  
data act;
    set ibes.act_epsus;
    where usfirm=1 and measure="EPS" and pdicity='ANN' and value ne . and anndats ne . and pends ne .;
    act=value;
    fpedats=pends;
    keep ticker anndats act fpedats;
  run;
  


proc sql;
    create table fy1 as
    select ticker,statpers,meanest as fy1,numest as acov,fpedats
    from ibes.statsum_epsus
    where fpi='1' and fiscalp='ANN' and usfirm=1;
    *group by ticker,fpedats
    *having statpers=max(statpers);
  quit;
  proc sort nodupkey; by ticker statpers; run;	
 
proc sql;
    create table fy2 as
    select ticker,statpers,meanest as fy2,numest as acov,fpedats
    from ibes.statsum_epsus
    where fpi='2' and fiscalp='ANN' and usfirm=1;
    *group by ticker,fpedats
    *having statpers=max(statpers);
  quit;
  
  
proc sort nodupkey; by ticker statpers; run;	

proc sql;
		create table fy2 as
		select a.*,a.fy2-b.fy1 as dfy2
		from fy2 a, fy1 b
		where a.ticker=b.ticker and intck('month',a.statpers,b.statpers)=12;
	quit;
	
	
 data tmp.prc;
		set ibes.actpsum_epsus;
		keep ticker statpers prdays price shout;
		where usfirm=1 and statpers ge '31DEC1990'd;
	run;


proc sort nodupkey; by ticker statpers; run;	 
proc sql;	
	create table fy1 as
	select a.*,b.act 
	from fy1 a, act b
	where a.ticker=b.ticker and a.fpedats=b.fpedats;
quit;

proc sql;
		create table fy1 as
		select a.*,b.dfy2,b.fy2
		from fy1 a left join fy2 b
		on a.ticker=b.ticker and a.statpers=b.statpers;
	quit;


proc sql;
		create table fy1 as
		select a.*,b.price
		from fy1 a, tmp.prc b
		where a.ticker=b.ticker and a.statpers=b.statpers;
quit;

data tmp.epserr;
		set fy1;
		epsbias=(fy1-act)/price;
		fy2rev=(dfy2)/price;
		if epsbias ne .;
		keep ticker statpers epsbias fy2rev fy1 fy2 price;
	run;
	
proc sort nodupkey; by ticker statpers; run;



*GET monthly acov;


proc sql;
    create table tmp.acovmon as
    select ticker,statpers,numest as acov
    from ibes.statsumu_epsus
    where fpi='1' and fiscalp='ANN' and usfirm=1;
  quit;
  
 proc sort nodupkey; by ticker statpers; run;
 
 
*GET Special items;

proc sql;
	create table compann as
	select GVKEY, FYEAR, DATADATE as FYENDDT,IB, SPI, AT, PI, NOPI,TXT,MII
	from comp.funda
	where GVKEY ne '' and  curcd = 'USD' and indfmt='INDL' and datafmt='STD' 
	and consol='C' and DATADATE >= '31DEC1985'd;
quit;

proc sort nodupkey; by gvkey fyear; run;




proc sql;
	create table compann as
	select a.*,2*(a.IB)/(a.AT+b.AT) as ROA, 2*a.SPI/(a.AT+b.AT) as Special,
	2*a.PI/(a.AT+b.AT) as PIOA,2*a.NOPI/(a.AT+b.AT) as NOPI2AT,
	2*a.TXT/(a.AT+b.AT) as tax,2*a.mii/(a.AT+b.AT) as mint
	from compann a, compann b
	where a.gvkey=b.gvkey and a.fyear=b.fyear+1;
quit;

data tmp.spi;
		set compann;
		keep gvkey fyear fyenddt special roa pioa nopi2at tax mint;
	run;
	





	
	*GET EXFIN;

proc sql;
	create table tmp.compann as
	select GVKEY, FYEAR, DATADATE as FYENDDT, IB, SPI, CSHO, AT, CEQ, DVC, 
	ADJEX_F, ACT, DLC, CHE, LCT, SICH as SIC,PRCC_F as PRICE
	from comp.funda
	where GVKEY ne '' and  curcd = 'USD' and indfmt='INDL' and datafmt='STD' 
	and consol='C' and DATADATE >= '31DEC1985'd;
quit;

proc sort nodupkey; by fyear gvkey ; run;


data csann;
		set tmp.compann;
		*CSHO=CSHO*ADJEX_F;
		if SPI=. then SPI=0;
		EPS=(IB-SPI*0.65)/CSHO;
		WC=(ACT-max(0,CHE))-(LCT-max(0,DLC));
		BTM=CEQ/(CSHO*PRICE);
		DIV=max(0,DVC)/CSHO;
		DD=(DVC le 0);
	run;
	
proc sql;
		create table csann as
		select a.*,(a.WC-b.WC)/b.CSHO as ACC,a.AT/b.AT-1 as AG
		from csann a, csann b
		where a.gvkey=b.gvkey and a.fyear=b.fyear+1;
	quit;
	
proc sql;
		create table csann as
		select a.*,b.EPS*a.ADJEX_F/b.ADJEX_F as AEPS1,b.EPS as EPS1
		from csann a, csann b
		where a.gvkey=b.gvkey and a.fyear=b.fyear-1;
	quit;

%winsor(dsetin=csann, byvar=fyear, vars=EPS1 AEPS1 EPS ACC AG DIV BTM PRICE, type=winsor, pctl=1 99);


data csann;	
	set csann;
	if int(sic/1000) ne 6 and price ge 5;
	EPLUS=max(0,EPS);
	NEGE=(EPS <0);
	ACCP=max(0,ACC);
	ACCN=min(0,ACC);
run;


%let dsetin=csann;

%let myind=EPLUS NEGE ACCN ACCP AG DD DIV BTM PRICE;


%let mywtvar=fyear;
%let mydep=EPS1;
%fmnw(&dsetin,&mydep,&myind,fyear,0, &mywtvar,test1);

%let mydep=AEPS1;
%fmnw(&dsetin,&mydep,&myind,fyear,0, &mywtvar,test2);


ods html file="/scratch/hkust/hyou/pred.html";
title "Prediction models";
proc print data=test1 noobs label;
	format coeff 8.3
		t_stat 8.2;
run;


title "Prediction models, adjusted";
proc print data=test2 noobs label;
	format coeff 8.3
		t_stat 8.2;
run;
ods html close;


proc sort data=csann;
		by fyear;
	run;
	
proc reg data=csann tableout outest=est;
		by fyear;
		model AEPS1=EPLUS NEGE ACCN ACCP AG DD DIV BTM PRICE;
	run;
	

/*

ods html file="/scratch/hkust/hyou/pred.html";
title "Prediction models";
proc print data=test1 noobs label;
	format coeff 8.3
		t_stat 8.2;
run;


title "Prediction models, adjusted";
proc print data=test2 noobs label;
	format coeff 8.3
		t_stat 8.2;
run;

title "Annual coefficient";
proc print data=est noobs label;
	format coeff 8.3
		t_stat 8.2;
run;


proc means data=est;
	class _TYPE_;
	var EPLUS NEGE ACCN ACCP AG DD DIV BTM PRICE;
run;

proc print data=long; 
run;


ods html close;
*/;

data est;
		set est;
		where _TYPE_='PARMS';
		keep fyear Intercept EPLUS NEGE ACCN ACCP AG DD DIV BTM PRICE;
		fyear=fyear+1;
	run;
	
proc sort; by fyear; run;


proc transpose data=est out=long;
		by fyear;
		var Intercept EPLUS NEGE ACCN ACCP AG DD DIV BTM PRICE;
	run;
	

data pred;
		set csann;
		Intercept=1;
		keep gvkey fyear Intercept EPLUS NEGE ACCN ACCP AG DD DIV BTM PRICE;
	run;
	
proc sort nodupkey; by fyear gvkey; run;

proc transpose data=pred out=pred;
		by fyear gvkey;
		var Intercept EPLUS NEGE ACCN ACCP AG DD DIV BTM PRICE;
	run;
	
proc sql;
		create table pred as
		select a.*,b.col1 as coeff
		from pred a, long b
		where a.fyear=b.fyear and a._Name_=b._name_;
	quit;
	



proc sql;
		create table pred as
		select fyear,gvkey,sum(col1*coeff) as CF
		from pred
		group by fyear,gvkey;
	quit;
	
proc sql;
		create table tmp.cf as
		select a.*,b.cf
		from csann a, pred b
		where a.gvkey=b.gvkey and a.fyear=b.fyear;
	quit;
	
	
ods html file="/scratch/hkust/hyou/pred.html";

title "Merged files";

proc corr data=tmp.cf pearson spearman;
		var cf eps1 aeps1;
	run;
	
proc contents data=tmp.cf;
	run;
	
ods html close;


proc sql;
  create table tmp.cf as 
  select a.*,b.lpermno as permno
  from tmp.cf as a, crsp.ccmxpf_linktable as b
  where a.gvkey = b.gvkey and
  b.LINKTYPE in ("LU","LC","LD","LN","LS","LX") and
  b.usedflag=1 and
  (b.LINKDT <= a.fyenddt or b.LINKDT = .B) and (a.fyenddt <= b.LINKENDDT or b.LINKENDDT = .E);
 quit;
	
proc sort nodupkey; by permno fyenddt; run;


*GET forecasts;


data act;
    set ibes.actu_epsus;
    where usfirm=1 and measure="EPS" and pdicity='ANN' and value ne . and anndats ne . and pends ne .;
    act=value;
    fpedats=pends;
    keep ticker anndats act fpedats;
  run;
  

data tmp.prc;
		set ibes.actpsumu_epsus;
		keep ticker statpers prdays price shout;
		where usfirm=1 and statpers ge '31DEC1980'd;
	run;
	
proc sort nodupkey; by ticker statpers; run;

proc sql;
    create table fy1 as
    select ticker,statpers,meanest as fy1,numest as acov,fpedats
    from ibes.statsumu_epsus
    where fpi='1' and fiscalp='ANN' and usfirm=1;
    *group by ticker,fpedats
    *having statpers=max(statpers);
  
  	create table fy1 as
  	select a.*,b.act
  	from fy1 a left join act b
  	on a.ticker=b.ticker and a.fpedats=b.fpedats;
 
 		create table tmp.af as
 		select a.*,b.price,b.shout
 		from fy1 a left join tmp.prc b
 		on a.ticker=b.ticker and intck('month',a.statpers,b.statpers)=0;
 		
 
  quit;
  
proc sort nodupkey; by ticker statpers; run;


proc sql;
		create table af as
		select a.*,b.permno 
		from tmp.af a, home.iclink b
		where a.ticker=b.ticker;
		quit;
		
proc sort nodupkey; by permno statpers; run;

proc sql;
		create table tmp.caf as
		select a.*,b.fy1,b.act as actual,b.price as iprc,b.shout
		from tmp.cf a, af b
		where a.permno=b.permno and intck('month',a.fyenddt,b.statpers)=5;
	quit;
	
data caf;
		set tmp.caf;
		co=(CF*CSHO/shout-FY1)/(AT/shout);
		ferr=(actual-fy1)/(at/shout);
		ferr2=(actual-fy1)/iprc;
	run;
	
	
%winsor(dsetin=caf, byvar=fyear, vars=co ferr ferr2, type=winsor, pctl=1 99);

ods html file="/scratch/hkust/hyou/pred.html";

title "Merged files";
	
proc corr data=caf pearson spearman;
		var co ferr ferr2;
	run;
	
ods html close;




*********************	
*** Get Disparity ***
*********************;

*Get actual;

data tmp.act;
	set ibes.act_epsus;
	where usfirm=1 and pdicity='ANN' and measure='EPS' and value ne .;
	act=value;
	fpedats=pends;
	keep ticker fpedats act anndats;
run;

proc sort nodupkey; by ticker fpedats; run;

data tmp.prc;
		set ibes.actpsum_epsus;
		keep ticker statpers prdays price shout;
		where usfirm=1 and statpers ge '31DEC1980'd;
	run;
	
proc sort nodupkey; by ticker statpers; run;


proc freq data=ibes.statsum_epsus; 
	table measure fiscalp fpi;
run;


proc sql;
	create table ltg as
	select ticker, statpers, meanest, medest, numest, stdev as fstd, highest-lowest as frange, actual, fpi
	from ibes.statsum_epsus
	where usfirm=1 and ticker ne '' and measure='EPS' and fiscalp='LTG' and fpi='0';
	quit;
	
%let sumv=meanest;

data ltg;
	set ltg;
	where fpi='0';
	ltg=&sumv.;
	keep ticker statpers ltg;
	run;
	
proc sort nodupkey; by ticker statpers; run; 


proc sql;
	create table feps as
	select ticker, statpers, meanest, medest, numest, stdev as fstd, highest-lowest as frange, fpedats,actual,anndats_act as repdats, fpi
	from ibes.statsum_epsus
	where usfirm=1 and ticker ne '' and measure='EPS' and fiscalp='ANN' and fpi in ('1','2','3');
	quit;
	
%let sumv=meanest;

data feps1;
	set feps;
	where fpi='1';	
	feps1=&sumv.;
	eps1=actual;
	rpdeps1=repdats;
	fpeeps1=fpedats;
	keep ticker statpers feps1 eps1 rpdeps1 fpeeps1 fstd frange numest;
	run;
	
proc sort nodupkey; by ticker statpers; run;

 data feps2;
	set feps;
	where fpi='2';
	feps2=&sumv.;
	eps2=actual;
	rpdeps2=repdats;
	fpeeps2=fpedats;
	keep ticker statpers feps2 eps2 rpdeps2 fpeeps2 fstd2;
	run;
	
proc sort nodupkey; by ticker statpers; run;

data feps3;
	set feps;
	where fpi='3';	
	feps3=&sumv.;
	eps3=actual;
	rpdeps3=repdats;
	fpeeps3=fpedats;
	keep ticker statpers feps3 eps3 rpdeps3 fpeeps3;
	run;
	
proc sort nodupkey; by ticker statpers; run;	

data tmp.afeps;
	merge feps1 (in=a) feps2 feps3 ltg tmp.prc;
	by ticker statpers;
	if a;
	run;


		
proc sql;
		create table tmp.afeps1 as
		select a.*,b.act as eps0
		from tmp.afeps a left join tmp.act b
		on a.ticker=b.ticker and intck('month',a.fpeeps1,b.fpedats)=-12;
		quit;
		
proc sql;
		create table tmp.afeps1 as
		select a.*,b.act as epsn1
		from tmp.afeps1 a left join tmp.act b
		on a.ticker=b.ticker and intck('month',a.fpeeps1,b.fpedats)=-24;
		quit;


%let sumv=meanest;

	


proc sql;
		create table disp as
		select a.ticker,a.statpers,(feps1-eps0)*100/abs(eps0) as istg,b.ltg 
		from tmp.afeps1 a, ltg b
		where a.ticker=b.ticker and a.statpers=b.statpers;
		quit;
		
proc sort nodupkey; by ticker statpers; run;	



proc sort data=home.iclink out=iclink nodupkey; 
by ticker;
run;

proc sort nodupkey; by permno; run;	

proc sql;
		create table master as
		select a.*,b.ticker
		from tmp.master a, iclink b
		where a.permno=b.permno; 
	quit;
	

proc sql;
		create table tmp.disp as
		select a.*,b.sic
		from disp a, master b
		where a.ticker=b.ticker and intck('month',a.statpers,b.date)=0;
	quit;
	

proc sort nodupkey; by ticker statpers; run;	

data disp;
		set tmp.disp;
		secnam=int(sic/1000);
	run;

proc sort; by statpers secnam; run;

proc rank data=disp out=disp groups=10;
	by statpers secnam;
	var istg ltg;
	ranks ristg rltg;
run;

data tmp.disp;
		set disp;
		disparity=ristg-rltg;
	run;
	
		
*GET illiquidity;

data dsf;
		set crsp.dsf;
		where ret ge -1 and date ge "01JAN1990"d;
		yymm=year(date)*100+month(date);
		imp=abs(ret)*1000000/abs(vol*prc);
	run;
	
proc sql;
		create table dsf as
		select permno,yymm,date,avg(imp) as imp,freq(imp) as freq
		from dsf
		group by permno, yymm;
	quit;
	
data dsf;
	set dsf;
	where freq ge 11;
run;

	
proc sql;
		create table tmp.illiq as
		select permno,yymm,date,imp
		from dsf
		group by permno,yymm
		having date=max(date);
	quit;
	
%lagit(id=permno,date_var=yymm,var=imp,in_ds=tmp.illiq,out_ds=illiq,NLAGS=11);		

data illiq;
		set illiq;
		illiq=sum(of imp limp1-limp11);
		if nmiss(of imp limp1-limp11)=0;
	run;
	
proc sql;
		create table tmp.tpmy as
		select a.*,b.illiq
		from tmp.tpmx a left join illiq b
		on a.permno=b.permno and intck('month',a.date,b.date)=0;
	quit;
endrsubmit;
