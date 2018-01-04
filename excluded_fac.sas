rsubmit;
dm "clear log"; dm "clear out";

/************************************************************************************************/
* PROGRAM:  Excluded_fac.sas 
* BY:  Lynn (Xiahong) Liu
* DATE:  12/07/2016
*
* PURPOSE:      Processes OPRD 2016 and 2017 Databridge output
* 				Check the information of excluded facilities in each model
*	
* INPUTS: 		OPRD 2016/2017 Databridge output, stored in contentqa@infxdbpd_anet. 
*				The following four quarters of CD data were run: 
*					(1) FY2016 Q1
*					(2) FY2016 Q2
*					(3) FY2016 Q3
*					(4) FY2016 Q4
*
*				
*				Facilities@infxdbpd_anet:
*					Tables: FACILITY
*
*               Utilities@infxdbpd_anet:
*					Tables: exclu_codes
* 
* OUTPUTS: 		Facility-level summary for OPRD (xlsx file after proc export procedure)
* 
* KNOWN ISSUES:	No issues.
* 
*;    
/************************************************************************************************/

options symbolgen mprint;

/****************************************************************************************/
/* Define Lib Ref															*/
/****************************************************************************************/
libname util informix server = utilities;
libname fac informix server = facilities;
libname output "/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/analysis";

libname db_16q1 '/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/databridge/OPRD2016/FY2016Q1';
libname db_16q2 '/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/databridge/OPRD2016/FY2016Q2';
libname db_16q3 '/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/databridge/OPRD2016/FY2016Q3';
libname db_16q4 '/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/databridge/OPRD2016/FY2016Q4';

libname db_17q1 '/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/databridge/OPRD2017/FY2016Q1';
libname db_17q2 '/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/databridge/OPRD2017/FY2016Q2';
libname db_17q3 '/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/databridge/OPRD2017/FY2016Q3';
libname db_17q4 '/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/databridge/OPRD2017/FY2016Q4';

libname flat13c '/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/data_extract/data';



/********************************
/* Import DataBridge OPRD2016	*/
/********************************/

data work.v2016_DISCH;
	set db_16q1.cd2016_q1_disch (keep = key32 fac )
		db_16q2.cd2016_q2_disch (keep = key32 fac )
		db_16q3.cd2016_q3_disch (keep = key32 fac )
		db_16q4.cd2016_q4_disch (keep = key32 fac );
run;

data work.v2016_DI1;
	set db_16q1.cd2016_q1_di1 (keep = key32  OP_CST_EXCL OP_CHG_EXCL op_oprdexcl )
		db_16q2.cd2016_q2_di1 (keep = key32  OP_CST_EXCL OP_CHG_EXCL op_oprdexcl )
		db_16q3.cd2016_q3_di1 (keep = key32  OP_CST_EXCL OP_CHG_EXCL op_oprdexcl )
		db_16q4.cd2016_q4_di1 (keep = key32  OP_CST_EXCL OP_CHG_EXCL op_oprdexcl );
    rename
	OP_CST_EXCL=CST2016_EXCL
	OP_CHG_EXCL=CHG2016_EXCL
    op_oprdexcl=OPRD2016_EXCL;

run;

proc sort data = work.v2016_DI1; by KEY32; run;
proc sort data = work.v2016_DISCH; by KEY32; run;

data work.OPRD_v2016;
	merge work.v2016_DI1 work.v2016_DISCH;
	by KEY32;
run;

/*************************************************************************************/
/* Import DataBridge v2017							                                 */
/*************************************************************************************/
data work.v2017_DISCH;
	set db_17q1.cd2017_q1_disch (keep = key32 fac )
		db_17q2.cd2017_q2_disch (keep = key32 fac )
		db_17q3.cd2017_q3_disch (keep = key32 fac )
		db_17q4.cd2017_q4_disch (keep = key32 fac );
run;

data work.v2017_DI1;
	set db_17q1.cd2017_q1_di1 (keep = key32 OP_CST_EXCL OP_CHG_EXCL op_oprdexcl)
		db_17q2.cd2017_q2_di1 (keep = key32 OP_CST_EXCL OP_CHG_EXCL op_oprdexcl)
		db_17q3.cd2017_q3_di1 (keep = key32 OP_CST_EXCL OP_CHG_EXCL op_oprdexcl)
		db_17q4.cd2017_q4_di1 (keep = key32 OP_CST_EXCL OP_CHG_EXCL op_oprdexcl);
    rename	
	OP_CST_EXCL=CST2017_EXCL
	OP_CHG_EXCL=CHG2017_EXCL
    op_oprdexcl=OPRD2017_EXCL;
run;

proc sort data = work.v2017_DI1; by KEY32; run;
proc sort data = work.v2017_DISCH; by KEY32; run;

data work.OPRD_v2017;
	merge work.v2017_DISCH work.v2017_DI1;
	by KEY32;
run;

/********************************
/* Combine v2016, v2017 data  */
/*******************************/
proc sort data = work.OPRD_v2016; by fac key32; run;
proc sort data = work.OPRD_v2017; by fac key32; run;

data work.disch;
	merge work.OPRD_v2016 work.OPRD_v2017;
	by fac key32;
run;


data work.names (keep = FAC name region state);
	set fac.facility;
	rename fac_id = FAC hosp_name = name;
run;

proc sql;
	create table work.div as
	select distinct div, stab as state
	from util.state;
quit;

%macro ex_fac (model, dataset, excl_1, excl_2, data1, count1, percent1, count2, percent2, data2, data3, data4, data5);
proc sql;
	create table &model as 
	select * 
	from disch
	where fac not in (select fac from output.&dataset);
quit;

Proc freq data=&model;
	by fac;
	Table &excl_1/out=&excl_1;
run;

Proc freq data=&model;
	by fac;
	Table &excl_2/out=&excl_2;
run;

proc sql;
	create table &data1 as
	select coalesce(a.fac,b.fac) as fac, coalesce(a.&excl_1,b.&excl_2)as excl_code, a.count as &count1, a.percent/100 as &percent1,
                                                  b.count as &count2, b.percent/100 as &percent2
	from &excl_1 as a full join &excl_2 as b
	on a.fac =b.fac and a.&excl_1=b.&excl_2;
quit;

* (1) Incorporate Descriptive Information - Facility Name/Census Region from FACILITIES.FACILITY; 
	
	*Sort the datasets by FAC;
	proc sort data=work.names; by FAC; run;
	proc sort data=work.&data1; by FAC; run;

	*Merge work.analysis and work.names by facility_identifier to pull in the name/region/state information;
	data work.&data2;
	merge work.&data1 (in = a) work.names;
	by FAC;
	if a=1;
	run;
* (2) Incorporate Descriptive Information - Division from UTILITIES.STATE;
	
	*Sort the datasets by Region;
	proc sort data=&data2; by state; run;
	proc sort data=work.div; by state; run;

	* Merge work.analysis_names and work.div by state to pull in the Division information;
	
   data work.&data3;
	merge work.&data2 (in = a) work.div;
	by state;
	if a = 1;
	run;

proc sql;
	create table &data4 as
	select fac, name, region, div, state, excl_code, title as description, &count1, &percent1, &count2, &percent2  
	from &data3 as a left join util.exclu_codes as b
	on a.excl_code =b.excl;
quit;

proc export data=&data4 
	outfile="/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/analysis/&data5"
	dbms = xlsx replace;
run;
%mend;

%ex_fac(cst, final_oprd_cst, CST2016_EXCL, CST2017_EXCL, cst_EX, count2016, perent2016, count2017, perent2017, cst_EX_names, cst_EX_names_div, cst_final, cst_exclu_final);
%ex_fac(chg, final_oprd_chg, CHG2016_EXCL, CST2017_EXCL, chg_EX, count2016, perent2016, count2017, perent2017, chg_EX_names, chg_EX_names_div, cst_final, chg_exclu_final);

endrsubmit;
