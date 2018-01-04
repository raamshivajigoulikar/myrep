
dm "clear log"; dm "clear out";
 
/****************************************************************************************/
* PROGRAM: impact_analysis_OPRD.sas
* SAS version:  SAS 9.4 in Unix 	
* BY:  Lynn Liu
* DATE: 12/06/2016
*
* PURPOSE: This program creates the CareDiscovery client Impact Analysis for comparing 
		   OPRD v2016 and OPRD v2017 models 
*
* INPUTS: FLAT13C CareDiscovery client data
*         cd_FY2016q1
*         cd_FY2016q2
*         cd_FY2016q3
*         cd_FY2016q4
*
*	      OPRD v2016 and v2017 DISCH output
*         OPRD v2016 and v2017 DI1 output
*         OPRD v2016 and v2017 rcc10 output
*
*         CDW Utilities Database - Procgrp table, STATE table 
*		  CDW Facilities Database - FACILITY table 
*
* OUTPUTS: This program outputs facility summary files. 
*		   One facility summary file is created for each model:CST and CHG
* 
* KNOWN ISSUES:	None
* 
* MACROS:
* %summary  - Creates facility-level summary
* %analysis - Calculates summary variables for CST/CHG
* %output   - Outputs data to flat file
*
* DATE:        CHANGE:
* 12/06/2016   Initial program
***************************************************************************************** ;
rsubmit;
options symbolgen mprint;

/****************************************************************************************/
/* Define Parameters/Lib Ref															*/
/****************************************************************************************/
libname util informix server = utilities;
libname fac informix server = facilities;
/*libname norm oracle user=cstefano password=gator path='@cadmartp' schema=cstefano dbindex=yes; ******* 02/23/2016: Don't need this for DB Impact Analysis*/

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

/*%let cdfile = OP_20160202;   **** 02/23/2016: Don't need this for DB Impact Analysis;*/

/****************************************************************************************/
/* Import FLAT13C data																	*/	
/****************************************************************************************/

data work.flat13c (drop = dkey total_chrg);
	set flat13c.cd_2016q1(keep = dkey legacy_facility total_chrg rename=(legacy_facility=fac))
	    flat13c.cd_2016q2(keep = dkey legacy_facility total_chrg rename=(legacy_facility=fac))
		flat13c.cd_2016q3(keep = dkey legacy_facility total_chrg rename=(legacy_facility=fac))
		flat13c.cd_2016q4(keep = dkey legacy_facility total_chrg rename=(legacy_facility=fac));
 
    key32 = left(put(dkey,32.));
	chg2016_obs = total_chrg;
	chg2017_obs = total_chrg;
run;

/*************************************************************************************/
/* Import DataBridge v2016							                                 */
/*************************************************************************************/
data work.v2016_DISCH;
	set db_16q1.cd2016_q1_disch (keep = key32 fac RCCECSTS)
		db_16q2.cd2016_q2_disch (keep = key32 fac RCCECSTS)
		db_16q3.cd2016_q3_disch (keep = key32 fac RCCECSTS)
		db_16q4.cd2016_q4_disch (keep = key32 fac RCCECSTS);
	rename
	RCCECSTS=CST2016_OBS;
run;

endrsubmit;

rsubmit;
data work.v2016_DI1;
	set db_16q1.cd2016_q1_di1 (keep = key32 PROC_NUM OP_CST_EXCL OP_CHG_EXCL op_oprdexcl OP_RWAECST OP_RWAECHG opsc_version release)
		db_16q2.cd2016_q2_di1 (keep = key32 PROC_NUM OP_CST_EXCL OP_CHG_EXCL op_oprdexcl OP_RWAECST OP_RWAECHG opsc_version release)
		db_16q3.cd2016_q3_di1 (keep = key32 PROC_NUM OP_CST_EXCL OP_CHG_EXCL op_oprdexcl OP_RWAECST OP_RWAECHG opsc_version release)
		db_16q4.cd2016_q4_di1 (keep = key32 PROC_NUM OP_CST_EXCL OP_CHG_EXCL op_oprdexcl OP_RWAECST OP_RWAECHG opsc_version release);
    rename
	PROC_NUM =procnum_2016
	
	OP_CST_EXCL=CST2016_EXCL
	OP_CHG_EXCL=CHG2016_EXCL
    op_oprdexcl=OPRD2016_EXCL

	OP_RWAECST =CST2016_EXP
	OP_RWAECHG =CHG2016_EXP
    
	opsc_version=opsc_2016
	release=opsc_rls_2016;
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
	set db_17q1.cd2017_q1_disch (keep = key32 fac RCCECSTS)
		db_17q2.cd2017_q2_disch (keep = key32 fac RCCECSTS)
		db_17q3.cd2017_q3_disch (keep = key32 fac RCCECSTS)
		db_17q4.cd2017_q4_disch (keep = key32 fac RCCECSTS);;
	rename
	RCCECSTS=CST2017_OBS;
run;

data work.v2017_DI1;
	set db_17q1.cd2017_q1_di1 (keep = key32 PROC_NUM OP_CST_EXCL OP_CHG_EXCL op_oprdexcl OP_RWAECST OP_RWAECHG opsc_version release)
		db_17q2.cd2017_q2_di1 (keep = key32 PROC_NUM OP_CST_EXCL OP_CHG_EXCL op_oprdexcl OP_RWAECST OP_RWAECHG opsc_version release)
		db_17q3.cd2017_q3_di1 (keep = key32 PROC_NUM OP_CST_EXCL OP_CHG_EXCL op_oprdexcl OP_RWAECST OP_RWAECHG opsc_version release)
		db_17q4.cd2017_q4_di1 (keep = key32 PROC_NUM OP_CST_EXCL OP_CHG_EXCL op_oprdexcl OP_RWAECST OP_RWAECHG opsc_version release);;
    rename
	PROC_NUM=procnum_2017
	
	OP_CST_EXCL=CST2017_EXCL
	OP_CHG_EXCL=CHG2017_EXCL
    op_oprdexcl=OPRD2017_EXCL

	OP_RWAECST =CST2017_EXP
	OP_RWAECHG =CHG2017_EXP

	opsc_version=opsc_2017
	release=opsc_rls_2017;
run;

proc sort data = work.v2017_DI1; by KEY32; run;
proc sort data = work.v2017_DISCH; by KEY32; run;

data work.OPRD_v2017;
	merge work.v2017_DISCH work.v2017_DI1;
	by KEY32;
run;

/***************************************/
/* Combine Flat13c, v2016, v2017 data  */
/***************************************/
proc sort data = work.flat13c; by fac key32; run;
proc sort data = work.OPRD_v2016; by fac key32; run;
proc sort data = work.OPRD_v2017; by fac key32; run;

data work.disch;
	merge work.flat13c work.OPRD_v2016 work.OPRD_v2017;
	by fac key32;
run;

endrsubmit;

rsubmit;
*To get the version and release info of procgrp used in OPSC;
proc freq data=disch;table opsc_2016; run;
proc freq data=disch;table opsc_rls_2016; run;
proc freq data=disch;table opsc_2017; run;
proc freq data=disch;table opsc_rls_2017; run;
endrsubmit;

rsubmit;
* proc freq shows that both opsc2016 and opsc2017 uses procgrp2016r2;

/*********************************************************************************************************/
/* PURPOSE: Merge on proc_num for ATG and CSC mapping, via import from UTILITIES Database/PROCGRP Table  */	
/*********************************************************************************************************/
* Import ATG_CSC2016;
data work.atg_csc2016 (keep = procnum_2016 atg2016 csc2016);
	set util.procgrp;
	where procgrp_ver ='2016' and release=2;
	rename 
	ATG = ATG2016
	CSC = CSC2016
    procgrp=procnum_2016;
run;

* Import ATG_CSC2017;
data work.atg_csc2017 (keep = procnum_2017 atg2017 csc2017);
	set util.procgrp;
	where procgrp_ver = '2016' and release=2;
	rename 
	ATG = ATG2017
	CSC = CSC2017
    procgrp=procnum_2017;
run;

* proc_num2016 to map atg and csc 2016;
proc sort data = work.disch; by procnum_2016; run;
proc sort data = work.atg_csc2016; by procnum_2016; run;

data work.disch_atg_csc_2016;
	merge work.disch (in = a) work.atg_csc2016;
	by procnum_2016;
	if a = 1;
run;

* proc_num2017 to map atg and csc2017;
proc sort data = work.disch_atg_csc_2016; by procnum_2017; run;
proc sort data = work.atg_csc2017; by procnum_2017; run;

data work.disch_atg_csc;
	merge work.disch_atg_csc_2016 (in = a) work.atg_csc2017;
	by procnum_2017;
	if a = 1;
run;
endrsubmit;

rsubmit;
* QA Check: Are there any missing ATG/CSCs? 
* Result: There are 6,185,939 records with some missing values due to be excluded by opsc model, so it is fine. (12/07/2016);
proc print data = work.disch_atg_csc(obs = 10);
	where procnum_2016 is not missing and atg2016 is missing and csc2016 is missing;
run;
endrsubmit;

rsubmit;
proc print data = work.disch_atg_csc(obs = 10);
	where procnum_2017 is not missing and atg2017 is missing and csc2017 is missing;
run;

proc freq data = work.disch_atg_csc;
	table procnum_2016 /list missing;
	table procnum_2017 /list missing;
	table atg2016 /list missing;
	table csc2016 /list missing;
	table atg2017 /list missing;
	table csc2017 /list missing;
run;
endrsubmit;

rsubmit;
data work.disch_atg_csc_renorm;
	set work.disch_atg_csc;;
	CST2016_RENORM_FACTOR = 1;
	CST2017_RENORM_FACTOR = 1;
	CHG2016_RENORM_FACTOR = 1;
	CHG2017_RENORM_FACTOR = 1;
run;

data work.disch_normalized;
	set work.disch_atg_csc_renorm;
	*CST;
	CST2016_REXP = CST2016_EXP * CST2016_RENORM_FACTOR;
	CST2017_REXP = CST2017_EXP * CST2017_RENORM_FACTOR;
	*CHG;
	CHG2016_REXP = CHG2016_EXP * CHG2016_RENORM_FACTOR;
	CHG2017_REXP = CHG2017_EXP * CHG2017_RENORM_FACTOR;
run;


/********************************************************************/
/* Create six summaries: CST/CHG v2016 and v2017		        	*/
/* Merge the six summaries by FAC to create Facility-level summary  */
/********************************************************************/

proc sql;
create table total as
select FAC, count(*) as total_records
from work.disch_normalized
group by FAC;
Quit;

%macro summary(model=,ver=);
proc sql;
create table work.&model.&ver. as
select
FAC,
count(*) as &model.&ver._QUAL_DISCHARGES,
sum(&model.&ver._OBS) as &model.&ver._OBSERVED,
avg(&model.&ver._OBS) as &model.&ver._OBSERVED_AVG,
STDERR(&model.&ver._OBS) as &model.&ver._OBSERVED_SE,
sum(&model.&ver._EXP) as &model.&ver._EXPECTED,
sum(&model.&ver._REXP) as &model.&ver._RENORM_EXPECTED,
avg(&model.&ver._REXP) as &model.&ver._RENORM_EXPECTED_AVG,
STDERR(&model.&ver._REXP) as &model.&ver._RENORM_EXPECTED_SE
from work.disch_normalized
where (&model.&ver._EXCL = 0)
group by FAC;

create table work.&model.&ver._final as
select a.*, b.&model.&ver._QUAL_DISCHARGES, &model.&ver._OBSERVED,        &model.&ver._OBSERVED_AVG,        &model.&ver._OBSERVED_SE,
             &model.&ver._EXPECTED,         &model.&ver._RENORM_EXPECTED, &model.&ver._RENORM_EXPECTED_AVG, &model.&ver._RENORM_EXPECTED_SE
from total as a, work.&model.&ver. as b
where a.fac=b.fac;
quit;

%mend summary;

%summary(model=CST,ver=2016);
%summary(model=CST,ver=2017);
%summary(model=CHG,ver=2016);
%summary(model=CHG,ver=2017);
endrsubmit;


rsubmit;
*The datasets that are produced above are after exclusion code filter, so each dataset may have different sets of facilities.
Check the facility list before the data mergeing, which could be good info for analyzing the results;

proc sort data=work.cst2016_final; by fac; run;
proc sort data=work.cst2017_final; by fac; run;
proc compare base=work.cst2016_final compare=work.cst2017_final; ID FAC; RUN;

proc sort data=work.chg2016_final; by fac; run;
proc sort data=work.chg2017_final; by fac; run;
proc compare base=work.chg2016_final compare=work.chg2017_final; ID FAC; RUN;

*Merge the summaries to create one dataset;
data work.summary_cst;
merge 
work.cst2016_final work.cst2017_final;
by FAC;
run;

data work.summary_chg;
merge 
work.chg2016_final work.chg2017_final;
by FAC;
run;

/****************************************************/
/* Calculate Confidence intervals 			    */
/****************************************************/
%macro ci();

%let model = CST CHG;

%do i = 1 %to 2;
%let var = %scan(&model.,&i.);


data work.summary_ci_&var;
set work.summary_&var;

&var.2016_95cilo = (&var.2016_OBSERVED_AVG - (1.96 * &var.2016_OBSERVED_SE)) / &var.2016_RENORM_EXPECTED_AVG;
&var.2016_95cihi = (&var.2016_OBSERVED_AVG + (1.96 * &var.2016_OBSERVED_SE)) / &var.2016_RENORM_EXPECTED_AVG;
&var.2017_95cilo = (&var.2017_OBSERVED_AVG - (1.96 * &var.2017_OBSERVED_SE)) / &var.2017_RENORM_EXPECTED_AVG;
&var.2017_95cihi = (&var.2017_OBSERVED_AVG + (1.96 * &var.2017_OBSERVED_SE)) / &var.2017_RENORM_EXPECTED_AVG;

%end;

run;

%mend ci;

%ci();

title 'QA: CI Calculation';
proc print data = work.summary_ci_cst (obs = 10);
run;
proc print data = work.summary_ci_chg (obs = 10);
run;

/*******************************************************************************/
/* Create Analysis Variables, as defined by Product Management and Content QA  */
/*******************************************************************************/
*Tier difintion;
proc format;
value
impact
1 = 'Absolute Index Change 0.2+ that is statistically significant and associated with change in performance vs. expected'
2 = 'Absolute Index Change 0.2+ that is NOT statistically significant but is associated with change in performance vs. expected'
3 = 'Absolute Index Change 0.2+ that is statistically significant but NO associated change in performance vs. expected'
4 = 'Absolute Index Change 0.2+ that is NOT statistically significant and NO associated change in performance vs. expected'
5 = 'Absolute Index Change < 0.2'
;
run;

%macro analysis();
* Iterate through models;

%let model = CST CHG;

	%do j = 1 %to 2;
		%let mod = %scan(&model.,&j.);

data work.analysis_&mod;
	set work.summary_ci_&mod;
			length 	
			&mod._v2016_vs_exprenorm      /* v2016 vs. Exp Renorm */
			&mod._v2017_vs_exprenorm      /* v2017 vs. Exp Renorm */
			&mod._v2016v2017_pcc  		    /* v2016-v2017 Performance Class Change */
			&mod._95ci_sig 			    /* version Results Significant Diff using 95% CI */
			$ 13
			;

			* Index;
			if &mod.2016_RENORM_EXPECTED > 0 then do;
				&mod._index_2016 = &mod.2016_OBSERVED/&mod.2016_RENORM_EXPECTED;
			end;
			if &mod.2017_RENORM_EXPECTED > 0 then do;
				&mod._index_2017 = &mod.2017_OBSERVED/&mod.2017_RENORM_EXPECTED;
			end;

			* Z-Score;
			&mod._zscore2016 = (&mod.2016_OBSERVED_AVG-&mod.2016_RENORM_EXPECTED_AVG)/(&mod.2016_RENORM_EXPECTED_SE * SQRT(&mod.2016_QUAL_DISCHARGES));
			&mod._zscore2017 = (&mod.2017_OBSERVED_AVG-&mod.2017_RENORM_EXPECTED_AVG)/(&mod.2017_RENORM_EXPECTED_SE * SQRT(&mod.2017_QUAL_DISCHARGES));
	
			* Abs Index Diff;
			&mod._index_diff = abs(&mod._index_2016 - &mod._index_2017);

			* Index % Diff;
			if &mod._index_2016 > 0 then do;
				&mod._v2016v2017_diff = (&mod._index_2017 - &mod._index_2016) / &mod._index_2016;
			end;

			* v2016 vs. Exp Renorm;
			if &mod.2016_95CIHI >= 0 and &mod.2016_95CIHI < 1 then &mod._v2016_vs_exprenorm= 'Lower';
			else if &mod.2016_95CILO > 1 then &mod._v2016_vs_exprenorm = 'Higher';
			else &mod._v2016_vs_exprenorm = 'No Different';

			* v2017 vs. Exp Renorm;
			if &mod.2017_95CIHI >= 0 and &mod.2017_95CIHI < 1 then &mod._v2017_vs_exprenorm = 'Lower';
			else if &mod.2017_95CILO > 1 then &mod._v2017_vs_exprenorm = 'Higher';
			else &mod._v2017_vs_exprenorm = 'No Different';

			* v2016-v2017 Performance Class Change;
			if &mod._v2016_vs_exprenorm = 'Lower' and &mod._v2017_vs_exprenorm in ('No Different', 'Higher') 
				then &mod._v2016v2017_pcc = 'Higher';
			else if &mod._v2016_vs_exprenorm = 'No Different' and &mod._v2017_vs_exprenorm = 'Higher'
				then &mod._v2016v2017_pcc = 'Higher';
			else if &mod._v2016_vs_exprenorm = 'Higher' and &mod._v2017_vs_exprenorm in ('No Different', 'Lower')
				then &mod._v2016v2017_pcc = 'Lower';
			else if &mod._v2016_vs_exprenorm = 'No Different' and &mod._v2017_vs_exprenorm = 'Lower'
				then &mod._v2016v2017_pcc = 'Lower';
			else &mod._v2016v2017_pcc = 'No Different';

			* Version Results Significant Diff using 95% CI ;
			if &mod.2016_95CILO <= &mod.2017_95CILO <= &mod.2016_95CIHI
				then &mod._95ci_sig = 'N';
			else if &mod.2016_95CILO <= &mod.2017_95CIHI <= &mod.2016_95CIHI
				then &mod._95ci_sig = 'N';
			else if &mod.2017_95CILO <= &mod.2016_95CILO <= &mod.2017_95CIHI
				then &mod._95ci_sig = 'N';
			else if &mod.2017_95CILO <= &mod.2016_95CIHI <= &mod.2017_95CIHI
				then &mod._95ci_sig = 'N';
			else &mod._95ci_sig = 'Y';
			
			* Impact Tier;
			if &mod._v2016v2017_pcc in ('Lower', 'Higher') and &mod._95ci_sig = 'Y' and &mod._index_diff >=0.20
				then &mod._impact_tier = 1;
			else if &mod._v2016v2017_pcc in ('Lower', 'Higher') and &mod._95ci_sig = 'N' and &mod._index_diff >=0.20
				then &mod._impact_tier = 2;
			else if &mod._v2016v2017_pcc = ('No Different') and &mod._95ci_sig = 'Y' and &mod._index_diff >=0.20
				then &mod._impact_tier = 3;
			else if &mod._v2016v2017_pcc in ('No Different') and &mod._95ci_sig = 'N' and &mod._index_diff >=0.20
				then &mod._impact_tier = 4;
			else &mod._impact_tier = 5;

			* Impact Tier Description;
			&mod._imptr_desc = put(&mod._impact_tier,impact.);
	%end;

run;

%mend analysis;

%analysis();

/*******************************************************************/
/* Incorporate Facility Information (12/07/2016)				   */
/* (1) Facility Name/Census Region/State from FACILITIES.FACILITY  */
/* (2) Division from UTILITIES.STATE					       	   */
/*******************************************************************/
%macro faci_div();
* Iterate through models;

%let model = CST CHG;

	%do j = 1 %to 2;
		%let mod = %scan(&model.,&j.);
    
* (1) Incorporate Descriptive Information - Facility Name/Census Region from FACILITIES.FACILITY; 
	data work.names (keep = FAC name region state);
	set fac.facility;
	rename fac_id = FAC hosp_name = name;
	run;

	*Sort the datasets by FAC;
	proc sort data=work.names; by FAC; run;
	proc sort data=work.analysis_&mod; by FAC; run;

	*Merge work.analysis and work.names by facility_identifier to pull in the name/region/state information;
	data work.analysis_names_&mod;
	merge work.analysis_&mod (in = a) work.names;
	by FAC;
	if a=1;
	run;	

* (2) Incorporate Descriptive Information - Division from UTILITIES.STATE;
	proc sql;
	create table work.div as
	select distinct 
	div,
	stab as state
	from util.state
	;
	quit;

	*Sort the datasets by Region;
	proc sort data=work.analysis_names_&mod; by state; run;
	proc sort data=work.div; by state; run;

	* Merge work.analysis_names and work.div by state to pull in the Division information;
	data work.final_&mod;
	merge work.analysis_names_&mod (in = a) work.div;
	by state;
	if a = 1;
	run;



* QA Check: Is every FAC assigned a Name/Region/State?;
	* Result: Yes, every FAC has description information (12/07/2016);

   Title " Distribution of description information per each facility -&mod";
	proc freq data = work.analysis_names_&mod;
	tables FAC*Name*Region*State /list missing;
	run;

  Title " Distribution of division per each facility -&mod";
	* QA Check: Is every FAC assigned a division?;
	* Result: Yes, every FAC has a division (12/07/2016);
	proc freq data = work.final_&mod;
	tables FAC*div /list missing;
	run;

 %end;
%mend faci_div;

%faci_div();

/*************************************************************/
/* Output final analysis	        				         */
/*************************************************************/
%macro output(model=);
	data _null_;
	set work.final_&model;
	file "/analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/analysis/&model..txt" dlm = ',' dsd lrecl = 5000;
	put
		FAC
		NAME
		REGION
		DIV
              total_records
		&model.2016_QUAL_DISCHARGES
		&model._INDEX_2016
		&model._zscore2016
		&model.2016_OBSERVED
		&model.2016_EXPECTED
		&model.2016_RENORM_EXPECTED
		&model.2016_95CILO
		&model.2016_95CIHI
		&model._v2016_VS_EXPRENORM

		&model.2017_QUAL_DISCHARGES
		&model._INDEX_2017
		&model._zscore2017
		&model.2017_OBSERVED
		&model.2017_EXPECTED
		&model.2017_RENORM_EXPECTED
		&model.2017_95CILO
		&model.2017_95CIHI
		&model._v2017_VS_EXPRENORM

		&model._v2016v2017_DIFF
		&model._INDEX_DIFF
		&model._v2016v2017_PCC
		&model._95CI_SIG
		&model._IMPACT_TIER
		&model._IMPTR_DESC
	;
	run;
%mend output;

%output(model=CST);
%output(model=CHG);

/*************************************************************/
/* Save final SAS analysis	        				         */
/*************************************************************/
%macro final ();
 %let model = CST CHG;

	%do j = 1 %to 2;
		%let mod = %scan(&model.,&j.);

data output.final_oprd_&mod;
set work.final_&mod;
run;
%end;
%mend final;

%final();
endrsubmit;

rsubmit;
data oprd2016;
    set db_16q1.cd2016_q1_di1(KEEP=KEY32 OP_CHG_EXCL OP_CST_EXCL op_oprdexcl opsc_excl rename=(OP_CHG_EXCL=CHG_EXCL2016 OP_CST_EXCL=CST_EXCL2016 op_oprdexcl=OPRD_EXCL2016 opsc_excl=opsc_excl2016))
	    db_16q2.cd2016_q2_di1(KEEP=KEY32 OP_CHG_EXCL OP_CST_EXCL op_oprdexcl opsc_excl rename=(OP_CHG_EXCL=CHG_EXCL2016 OP_CST_EXCL=CST_EXCL2016 op_oprdexcl=OPRD_EXCL2016 opsc_excl=opsc_excl2016))
	    db_16q3.cd2016_q3_di1(KEEP=KEY32 OP_CHG_EXCL OP_CST_EXCL op_oprdexcl opsc_excl rename=(OP_CHG_EXCL=CHG_EXCL2016 OP_CST_EXCL=CST_EXCL2016 op_oprdexcl=OPRD_EXCL2016 opsc_excl=opsc_excl2016))
	    db_16q4.cd2016_q4_di1(KEEP=KEY32 OP_CHG_EXCL OP_CST_EXCL op_oprdexcl opsc_excl rename=(OP_CHG_EXCL=CHG_EXCL2016 OP_CST_EXCL=CST_EXCL2016 op_oprdexcl=OPRD_EXCL2016 opsc_excl=opsc_excl2016)); 
        
RUN;

data oprd2017;
    set db_17q1.cd2017_q1_di1(KEEP=KEY32 OP_CHG_EXCL OP_CST_EXCL op_oprdexcl opsc_excl rename=(OP_CHG_EXCL=CHG_EXCL2017 OP_CST_EXCL=CST_EXCL2017 op_oprdexcl=OPRD_EXCL2017 opsc_excl=opsc_excl2017))
	    db_17q2.cd2017_q2_di1(KEEP=KEY32 OP_CHG_EXCL OP_CST_EXCL op_oprdexcl opsc_excl rename=(OP_CHG_EXCL=CHG_EXCL2017 OP_CST_EXCL=CST_EXCL2017 op_oprdexcl=OPRD_EXCL2017 opsc_excl=opsc_excl2017))
	    db_17q3.cd2017_q3_di1(KEEP=KEY32 OP_CHG_EXCL OP_CST_EXCL op_oprdexcl opsc_excl rename=(OP_CHG_EXCL=CHG_EXCL2017 OP_CST_EXCL=CST_EXCL2017 op_oprdexcl=OPRD_EXCL2017 opsc_excl=opsc_excl2017))
	    db_17q4.cd2017_q4_di1(KEEP=KEY32 OP_CHG_EXCL OP_CST_EXCL op_oprdexcl opsc_excl rename=(OP_CHG_EXCL=CHG_EXCL2017 OP_CST_EXCL=CST_EXCL2017 op_oprdexcl=OPRD_EXCL2017 opsc_excl=opsc_excl2017));
RUN;

%macro excl_sum(file1, ver1, file2, ver2, path, output); 



* Produce frequency and percent for model version1;
proc freq data=&file1;
    tables &ver1/out=excl_1;
run;

* Produce frequency and percent for model version2;
proc freq data=&file2;
    tables &ver2/out=excl_2;
run;

*Create the list of the exclusion codes from both versions;

proc sql;
	create table excl_list as select *	from 
	(select distinct &ver1 as excl from &file1) union 
	(select distinct &ver2 from &file2);

*number(percent)_&ver1._a and number(percent)_&ver1._b were named to differentiate two variales in case of the &ver1 as same as &ver2;
    create table final_excl_1_excl_2 as             
	select a.excl, title as description, c.count as number_&ver1._a, c.percent/100 as percent_&ver1._a,
                                         d.count as number_&ver2._b, d.percent/100 as percent_&ver2._b,
                                         d.count-c.count as dif   
                                         from excl_list as a left join util.exclu_codes as b on a.excl=b.excl
                                                             left join excl_1 as c on a.excl=c.&ver1 
                                                             left join excl_2 as d on a.excl=d.&ver2                        
                        
    order by excl;
   
quit;


proc export data=final_excl_1_excl_2 outfile="&path./final_&output._summary.xlsx"  dbms = xlsx replace;
run;

%mend;
%excl_sum(oprd2016, CST_EXCL2016, oprd2017, CST_EXCL2017, /analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/analysis, COST_excl);
%excl_sum(oprd2016, CHG_EXCL2016, oprd2017, CHG_EXCL2017, /analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/analysis, Charge_excl);
%excl_sum(oprd2016, OPSC_EXCL2016, oprd2017, OPSC_EXCL2017, /analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/analysis, OPSC_excl);
%excl_sum(oprd2016, OPRD_EXCL2016, oprd2017, OPRD_EXCL2017, /analytics/contentqa/databridge/201611_OPRD_Impact_Analysis/analysis, OPRD_excl);
