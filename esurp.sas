libname es 'F:\Coding\Macros';
/* Macro IBES_SAMPLE extracts the estimates from the IBES Unadjusted file based on         */
/* the user-provided input, links them to actuals, puts estimates and actuals on the       */
/* same basis by adjusting for stock splits using CRSP adjustment factor and calculates    */
/* the median of analyst forecasts made in the 90 days prior to the earnings announcement  */
/* date.                                                                                   */
/*******************************************************************************************/
/*Select the last estimate for a firm within broker-analyst group*/ 
proc sql; create table ibes (drop=measure fpi)
        as select *
        from es.ibes
        order by ticker, fpedats, estimator, analys, anndats, revdats;
quit;

 data ibes; set ibes;
        by ticker fpedats estimator analys;
        if last.analys;
run;
/*How many estimates are reported on primary/diluted basis?*/
proc sql; 
        create table ibes 
                as select a.*, sum(pdf='P') as p_count, sum(pdf='D') as d_count
                from ibes as a
                group by ticker, fpedats;
%let ibes2_where=where=(missing(repdats)=0 and missing(anndats)=0 and 0<intck('day',anndats,repdats)<=90);

/* a. Link unadjusted estimates with unadjusted actuals and CRSP permnos                                */
/* b. Adjust report and estimate dates to be CRSP trading days                                          */
        create table ibes1 (&ibes2_where)
                as select a.*, b.anndats as repdats, b.value as act, c.permno,
                case when weekday(a.anndats)=1 then intnx('day',a.anndats,-2)                  /*if sunday move back by 2 days;*/
                     when weekday(a.anndats)=7 then intnx('day',a.anndats,-1) else a.anndats   /*if saturday move back by 1 day*/
                end as estdats1,
                case when weekday(b.anndats)=1 then intnx('day',b.anndats,1)                  /*if sunday move forward by 1 day  */
                     when weekday(b.anndats)=7 then intnx('day',b.anndats,2) else b.anndats   /*if saturday move forward by 2 days*/
               end as repdats1
                from ibes as a, es.ibes_actu as b, es.iclink as c
                where a.ticker=b.ticker and a.fpedats=b.pends and a.usfirm=b.usfirm and b.pdicity='QTR' 
                          and b.measure='EPS' and a.ticker=c.ticker and c.score in (0,1,2);

/*   Making sure that estimates and actuals are on the same basis */
/*   1. retrieve CRSP cumulative adjustment factor for IBES report and estimate dates */
        create table adjfactor
                as select distinct a.*
                from es.crsp (keep=permno date cfacshr) as a, ibes1 as b
                where a.permno=b.permno and (a.date=b.estdats1 or a.date=b.repdats1);
        
/*      2.if adjustment factors are not the same, adjust the estimate to be on the same basis with the actual   */
        create table ibes1
                as select distinct a.*, b.est_factor, c.rep_factor, 
                        case when (b.est_factor ne c.rep_factor) and missing(b.est_factor)=0 and missing(c.rep_factor)=0
                         then (rep_factor/est_factor)*value else value end as new_value
                from ibes1 as a, 
                        adjfactor (rename=(cfacshr=est_factor)) as b, 
                        adjfactor (rename=(cfacshr=rep_factor)) as c 
                        where (a.permno=b.permno and a.estdats1=b.date) and
                                  (a.permno=c.permno and a.repdats1=c.date);
quit;

/* Make sure the last observation per analyst is included
                        */
proc sort data=ibes1; 
        by ticker fpedats estimator analys anndats revdats;
run;

data ibes1; set ibes1;
by ticker fpedats estimator analys;
if last.analys;
run;

/* Compute the median forecast based on estimates in the 90 days prior to the report date/PROC MEANS with a NOPRINT option is the same as using PROC SUMMARY */
proc means data=ibes1 noprint;
        by ticker fpedats;
        var /*value*/ new_value;                         /* new_value is the estimate appropriately adjusted         */
        output out= medest (drop=_type_ _freq_)         /* to be on the same basis with the actual reported earnings */
        median=medest n=numest;
run;

/* Merge median estimates with ancillary information on permno, actuals and report dates                              */
/* Determine whether most analysts are reporting estimates on primary or diluted basis                                */
/* following the methodology outlined in Livnat and Mendenhall (2006)                                                 */
proc sql; create table medest 
        as select distinct a.*, b.repdats, b.act, b.permno,
        case when p_count>d_count then 'P' 
             when p_count<=d_count then 'D' 
        end as basis                                                                             
        from medest as a left join ibes1 as b
        on a.ticker=b.ticker and a.fpedats=b.fpedats;
quit;

proc sql; 
        drop table ibes, ibes1;
quit;

*COMPUSTAT EXTRACT;
*Create calendar date of fiscal period end in Compustat extract;
proc sql;
create table comp as select *, cshoq*prccq as mcap
from es.comp; quit;
data comp; set comp;
   if (1<=fyr<=5) then date_fyend=intnx('month',mdy(fyr,1,fyearq+1),0,'end');
   else if (6<=fyr<=12) then date_fyend=intnx('month',mdy(fyr,1,fyearq),0,'end');
   fqenddt=intnx('month',date_fyend,-3*(4-fqtr),'end');
   format fqenddt date9.;
   drop date_fyend;
run;

/* Create a linking table  between IBES ticker and Compustat GVKEY */
/* based on IBES ticker-CRSP permno (ICLINK) and CCM CRSP permno - Compustat GVKEY (CSTLINK2) link  */
%let begindate='01jan1980'd; * start calendar date of fiscal period end;
%let enddate='31dec2017'd; * end calendar date of fiscal period end;

proc sort data=es.lnkhist out=lnk;
        where linktype in ("LU", "LC" /*,"LD", "LF", "LN", "LO", "LS", "LX"*/)  and
        (year(&enddate)+1>=year(linkdt) or linkdt=.B) and
        (year(&begindate)-1<=year(linkenddt) or linkenddt=.E);
        by gvkey linkdt;
run;

/*Creating GVKEY-TICKER link for CRSP firms, call it CIBESLNK*/
proc sql; create table lnk1 (drop=permno score where=(missing(ticker)=0))
        as select *
        from lnk (keep=gvkey lpermno lpermco linkdt linkenddt) as a left join
        es.iclink (keep=ticker permno score where=(score in (0,1,2))) as b
        on a.lpermno=b.permno;
quit;
proc sort data=lnk1;
        by gvkey ticker linkdt;
run;
data fdate ldate; set lnk1;
        by gvkey ticker;
        if first.ticker then output fdate;
        if last.ticker then output ldate;
run;
data temp;      merge
                fdate (keep=gvkey ticker linkdt rename=(linkdt=fdate))
                ldate (keep=gvkey ticker linkenddt rename=(linkenddt=ldate));
        by gvkey ticker;
run;
/*Check for duplicates*/
data dups nodups; set temp;
        by gvkey ticker;
        if first.gvkey=0 or last.gvkey=0 then output dups;
        if not (first.gvkey=0 or last.gvkey=0) then output nodups;
run;
 
proc sort data=dups;
        by gvkey fdate ldate ticker;
run;
 
data dups (where=(flag ne 1));
        set dups;
        by gvkey;
        if first.gvkey=0 and (fdate<=lag(ldate) or lag(ldate)=.E) then flag=1;
run;
data cibeslnk;
        set nodups dups (drop=flag);
run;
 
proc sql; drop table nodups, dups, fdate, ldate, lnk1;quit;
* a) Link Gvkey with Lpermno;
proc sql;
   create table comp1
   as select a.*, b.lpermno
   from comp (where=(&begindate<=fqenddt<=&enddate)) as a left join lnk as b
   on a.gvkey=b.gvkey and ((b.linkdt<=a.fqenddt <=b.linkenddt) or
   (b.linkdt<=a.fqenddt and b.linkenddt=.E) or
   (b.linkdt=.B and a.fqenddt <=b.linkenddt));

* b) Link Gvkey with IBES Ticker;
create table comp1
   as select a.*, b.ticker
   from comp1 as a left join cibeslnk as b
   on a.gvkey=b.gvkey and ((b.fdate<=a.fqenddt <=b.ldate) or
   (b.fdate<=a.fqenddt and b.ldate=.E) or (b.fdate=.B and a.fqenddt <=b.ldate));

 /* c) Link IBES analysts' expectations (MEDEST), IBES report dates (repdats)
* and actuals (act) with Compustat data; */
create table comp1
   as select a.*, b.medest, b.numest,b.repdats, b.act, b.basis
   from comp1 as a left join medest as b
   on a.ticker=b.ticker and
   year(a.fqenddt)*100+month(a.fqenddt)=year(b.fpedats)*100+month(b.fpedats);
quit;

*remove fully duplicate records and pre-sort;
proc sort data=comp1 noduprec; by _all_;run;
proc sort data=comp1; by gvkey fyearq fqtr;run;

/* Description: 3 Methods of calculating standardized earnings surprises                       */
/*                                                                                             */
/* Macro SUE calculates standardized earnings surprises using 3 (three) methods considered     */
/* by LM (2006). Method 1 assumes a rolling seasonal random walk model. Method 2 excludes      */
/* "special items" from the Compustat Data. In these two methods, if most analyst forecasts of */
/* EPS are based on diluted (primary) EPS, Macro uses Compustat's diluted (basic) figures      */
/* Method 3 is based solely on IBES median estimates/actuals and does not use Compustat data   */
/***********************************************************************************************/

%MACRO SUE (method=, input=);
/* Process Compustat Data on a seasonal year-quarter basis*/
%local i;
%do i=1 %to 4;
proc sort data=comp1 (where=(fqtr=&i)) out=qtr;
    by gvkey fyearq fqtr;
run;
 
data qtr; set qtr;
    by gvkey fyearq;
    %if &method=1 %then
     %do;
        lageps_p=lag(epspxq);lageps_d=lag(epsfxq);lagadj=lag(ajexq);
        if first.gvkey then do; lageps_p=.;lageps_d=.;lagadj=.;end;
        select (basis);
        when ('P') do; actual=epspxq/ajexq; expected=lageps_p/lagadj;end;
        when ('D') do; actual=epsfxq/ajexq; expected=lageps_d/lagadj;end;
        otherwise do; actual=epspxq/ajexq; expected=lageps_p/lagadj;end;
        end;
        drop lageps_p lageps_d lagadj;
        deflator=prccq/ajexq;
    %end;%else;
    %if &method=2 %then
     %do;
        lageps_p=lag(epspxq);lagshr_p=lag(cshprq);lagadj=lag(ajexq);
        lageps_d=lag(epsfxq);lagshr_d=lag(cshfdq);lagspiq=lag(spiq);
        if first.gvkey then do; lageps_p=.;lageps_d=.;lagshr_p=.;
                                lagshr_d=.;lagadj=.;lagspiq=.;end;
        select (basis);
        when ('P') do; actual=sum(epspxq,-0.65*spiq/cshprq)/ajexq; expected=sum(lageps_p,-0.65*lagspiq/lagshr_p)/lagadj;end;
        when ('D') do; actual=sum(epsfxq,-0.65*spiq/cshfdq)/ajexq; expected=sum(lageps_d,-0.65*lagspiq/lagshr_d)/lagadj;end;
        otherwise do; actual=sum(epspxq,-0.65*spiq/cshprq)/ajexq; expected=sum(lageps_p,-0.65*lagspiq/lagshr_p)/lagadj;end;
        end;
        drop lageps_p lagshr_p lagadj lageps_d lagshr_d lagspiq;
        deflator=prccq/ajexq;
        %end;%else;
    %if &method=3 %then
     %do;
        actual=act;
        expected=medest;
        deflator=prccq;
     %end;
    sue&method=(actual-expected)/deflator;
    format sue&method percent7.4;
run;
 
proc append base=comp_final&method data=qtr;run;
proc sql; drop table qtr;quit;
%end;
 
proc sort data=comp_final&method; by gvkey fyearq fqtr;run;
%MEND;

* Macro SUE calculates standardized earnings surprises SUE1, SUE2, SUE3
* and outputs datasets comp_final&k into the work directory;
%MACRO Allsurprises;
   %do k=1 %to 3;
   %SUE (method=&k, input=comp1);
   %end;
%mend;
%Allsurprises;

* Merge all of the results together to get a dataset containing SUE1 , SUE2
* and SUE3 for all relevant (GVKEY-Report date) pairs;
data comp_final;
   merge comp_final1 comp_final2 (keep=gvkey fyearq fqtr sue2)
   comp_final3 (keep=gvkey fyearq fqtr sue3);
   by gvkey fyearq fqtr;
   label fqenddt='Calendar date of fiscal period end';
   keep ticker ibtic lpermno gvkey conm fyearq fqtr fyr fqenddt repdats rdq;
   keep sue1 sue2 sue3 basis actual expected deflator act medest numest prccq mcap;
run;

proc sort data=comp_final;
   *descending sort is intentional to define leads;
   by gvkey descending fyearq descending fqtr;
run;
 
* Shifting the announcement date to be a trading day;
* Defining the day after the following quarterly earnings announcement as leadrdq1;
* INTNX  function takes a starting date and
returns the date after which a given number of interval boundaries have been crossed. ;
data retdates; set comp_final;
   by gvkey;
   leadrdq=lag(rdq);
   if first.gvkey then leadrdq=intnx('month',rdq,3,'sameday');
   *if sunday move back by 2 days, if saturday move back by 1 day;
   if weekday(rdq)=1 then rdq1=intnx('day',rdq,-2); else
   if weekday(rdq)=7 then rdq1=intnx('day',rdq,-1); else rdq1=rdq;
   if weekday(leadrdq)=1 then leadrdq1=intnx('day',leadrdq,2); else
   if weekday(leadrdq)=7 then leadrdq1=intnx('day',leadrdq,3); else
   if weekday(leadrdq)=6 then leadrdq1=intnx('day',leadrdq,3);else
   leadrdq1=intnx('day',leadrdq,1);
   if leadrdq=rdq then delete;
   keep lpermno gvkey fyearq fqtr rdq1 leadrdq1 rdq;
   format rdq1 leadrdq1 date9.;
run;

* Apply LM filter
* Earnings report dates in Compustat and in IBES (if available)
* should not differ by more than one calendar day;
%let LM_filter=(missing(rdq)=0 and prccq>1 and mcap>5.0);
data comp_final;
   set comp_final;
   if &LM_filter and (((missing(sue1)=0 or missing(sue2)=0) and missing(repdats)=1)
   or (missing(repdats)=0 and abs(intck('day',repdats,rdq))<=1));
run;

* Extract file of raw daily returns around between earnings announcement dates; 
* The INTCK function computes the number of intervals between two dates;
* The INTNX function computes a date after a given number of intervals;
proc sql;
   create table crsprets
   as select a.*, b.rdq1, b.leadrdq1, b.rdq
   from es.crsp (keep=permno ret date where=(&begindate<=date<=&enddate)) as a,
   retdates (where=(missing(rdq1)=0 and missing(leadrdq1)=0 and
   30<intck('day',rdq1,leadrdq1))) as b
   where a.permno=b.lpermno and intnx('day',rdq1,-5)<=a.date<=intnx('day',leadrdq1,5);
quit;
*remove fully duplicate records;
proc sort data=crsprets noduprec; by _all_;run;
*To estimate the drift, we compute CAR1 and CAR2;
proc sort data=crsprets out=temp1;
   where date lt rdq;
   by permno rdq descending date; *descending order is intentional;
run;
data temp1; set temp1;
   by permno rdq;
   if first.rdq then td_count=0;
   td_count=td_count-1; *increments in negative direction;
   retain td_count;
run;
proc sort data=crsprets out=temp2;
   where date ge rdq;
   by permno rdq date; *ascending order as default;
run;
data temp2; set temp2 ;
   by permno rdq;
   if first.rdq and date=rdq1 then td_count=0;
   td_count=td_count+1; *increments in positive direction;
   if date=rdq1 then td_count=0;
   retain td_count;
run;

data crsprets; set temp1 temp2;run;
proc sort data=crsprets; by permno rdq td_count;run;
proc sql; drop table temp1, temp2; quit;

* Calculate cumulative abornal returns:
* PROC MEANS with a NOPRINT option is the same as using PROC SUMMARY.
* a) CAR1 (3-day window);
proc means data=crsprets noprint;
   *define the even window and check that the start date is not far from report date;
   where -1<=td_count<=1 and intck('day',rdq,date)<=5;
   by permno rdq;
   var ret;
   output out=CAR1 (rename=(_freq_=daysCAR1)) sum=CAR1;
run;

* b) CAR2 (between consequent quarterly earnings announcement dates);
proc means data=crsprets noprint;
   where 3<=td_count and date<=leadrdq1;
   by permno rdq;
   var ret;
   output out=CAR2 (rename=(_freq_=daysCAR2)) sum=CAR2;
run;


* Merge surprises with abnormal returns and place the final set into home directory;
* Use daysCAR1 and daysCAR2 to check for whether CAR1 and CAR2 are computed over
* potentially misleading time windows due to missing returns data in CRSP DSF file;
proc sql;
   create table suecars
   as select a.gvkey,a.lpermno label='CRSP PERMNO Identifier',
   a.ticker label='Historical IBES Ticker', a.rdq, a.fqenddt, a.fyearq,
   a.fqtr, a.sue1 label='Earnings Surprise (Seasonal Random Walk)',
   a.sue2 label='Earnings Surprise (Excluding Special items)',
   a.sue3 label='Earnings Surprise (Analyst Forecast-based)',
   a.numest label='Number of analyst forecasts used in Analyst-based SUE',
   b.car1 label='Cumulative AR around EAD (-1,+1)',
   b.daysCAR1 label='Actual days used in CAR1 calculation',
   c.car2 label='Cumulative AR between Consequent EADs'
   from comp_final as a, car1 as b, car2 as c
   where a.lpermno=b.permno and a.rdq=b.rdq and a.lpermno=c.permno and a.rdq=c.rdq;
quit;

proc sort data=suecars out=es.suecars; by gvkey fyearq fqtr;run;
