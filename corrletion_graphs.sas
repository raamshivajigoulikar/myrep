/*Create graphs for impact analysis at facility level*/

/********************************************************************************************************************************************************************************
 * Macro Name: corrgraph
 * SAS version: PC SAS9.4                                                                                                                                                     *
 * Function: create scatter plot with correlation coefficient displayed                                                                                                         *
 * Part of codes is edited from UCLA: Statistical Consulting Group http://www.ats.ucla.edu/stat/sas/faq/corrgraph.htm.                                                          *
 * %corrgraph(file, text1, text2, ver1, ver2, index1, index2, zscore1, zscore2, label1, label2);                                                                                *
 *       file---the dataset that has all the information for creating overall impact analysis and correlation graphs (including both model versions)                            *
 *       text1/text2---they are values of model variable in overall impact analysis table. e.g. "ECRI v17 POA (No Char)"/"ECRI v18 POA (No Char)" for ECRI                      *
 *       ver1/ver2---model version number, e.g. ERCI17/ECRI18 for ECRIC, which depends on what they appear in the dataset                                                       *
 *       ver_norm1/ver_norm2---model version number for normalized expected values, e.g. ERCI17_RENORM_EXPECTED/ECRI18_RENORM_EXPECTED for ECRIC, which depends on what they    *
 *                             appear in the dataset. For databrdige impact anlaysis these values can be as same as ver1/ver2                                                   *                        
 *       index1/index2---index version for creating index by facility correlation graph, e.g. ECRI_index_17/ECRI_index_18 for ECRI                                              *     
 *       zscore1/zscore2---score version for creating zscore by facility correlation graph, e.g. ECRI_zscore_17/ECRI_zscore_18 for ECRI                                         *
 *       label1/label2---label1 for index1/zscore1 in the graph. it is the label for x axis, i.e. how the axis x in the graph looks like. e.g. "ECRI v17 POA" for x-axis in ECRI*
 *                       label2 for index2/zscore2 in the graph. it is the label for y axis, i.e. how the axis y in the graph looks like. e.g. "ECRI v18 POA" for y-axis in ECRI*
 *Below is the example of applying the macro to ECRI impact analysis                                                                                                            *
 *%corrgraph(final_ecri_rami, "ECRI v17 POA (No Char)", "ECRI v18 POA (No Char)", ECRI17, ECRI18, ECRI_index_17, ECRI_index_18, ECRI_zscore_17, ECRI_zscore_18, "ECRI v17 POA", *
 *            "ECRI v18 POA");                                                                                                                                                  *
 *Note---the macro was developed based on the ERIC/RAMI/PFD impact analysis. Some minor changes might be needed if applied to differenct models 
 *********************************************************************************************************************************************************************************/

*Libname directory is subject to change due to a temporary space it is ;

libname output "Y:\LynnL\Impact\OPRD_2016_11\analysis";


%MACRO corrgraph(file, text1, text2, ver1, ver_norm1, ver2, ver_norm2, index1, index2, zscore1, zscore2, label1, label2);

proc sql;
    create table overall_impact1 as
	select &text1 as Model, sum(&ver1._qual_discharges) as N, SUM(&ver1._observed)/sum(&ver1._qual_discharges) as Avg_observed,
	        SUM(&ver_norm1._expected)/sum(&ver1._qual_discharges) as Avg_expected, SUM(&ver1._observed)/sum(&ver_norm1._expected) as index
	from output.&file;
quit;

proc sql;
    create table overall_impact2 as
	select &text2 as Model, sum(&ver2._qual_discharges) as N, SUM(&ver2._observed)/sum(&ver2._qual_discharges) as Avg_observed,
	        SUM(&ver_norm2._expected)/sum(&ver2._qual_discharges) as Avg_expected,  SUM(&ver2._observed)/sum(&ver_norm2._expected) as index
	from output.&file;
quit;

data overall_impact;
    set overall_impact1 overall_impact2;
run;

data overall_impact_final(drop=lag_index);
    set overall_impact;
	lag_index=lag(index); 
    Index_diff=index-lag_index;
	index_per_diff=(index-lag_index)/lag_index;
run;  
 
proc corr data=output.&file noprint outp=_rcorr_index;
   var &index1  &index2;
 run;
 proc print data=_rcorr_index;run;

*Put correlation coefficient to r;

data _null_;
    set _rcorr_index;
	if _n_=4 then do;
	r=floor(&index2*1000)/1000+0;
	if r = 1 then r1 = 1;
    else if r = -1 then r1 = -1;
    else if r = 0 then r1 = 0;
    else  r1 = input(r, 20.);
    call symput('r1',strip(r1));
   end;
 run;

proc corr data=output.&file noprint outp=_rcorr_zscore ;
   var &zscore1  &zscore2;
 run;

data _null_;
    set _rcorr_zscore;
	if _n_=4 then do;
	r=floor(&zscore2*1000)/1000+0;
	if r = 1 then r2 = 1;
    else if r = -1 then r2 = -1;
    else if r = 0 then r2 = 0;
    else  r2 = input(r, 20.);
    call symput('r2',strip(r2));
   end;
 run;

%put &r1 &r2;

ods excel file="Y:\LynnL\Impact\OPRD_2016_11\analysis\&ver1._&ver2._correlation.xlsx" options(sheet_interval='none' );

ods excel options(start_at='A1' sheet_name='Scatter Plot Correlation' embedded_titles='yes');
title;
Title1 j=left italic "Overall Statistics";

proc print data=overall_impact_final noobs; 
   var Model N avg_observed avg_expected index Index_diff index_per_diff;
   format N comma10. avg_observed 6.4 avg_expected 6.4 index 6.4 Index_diff 6.4 index_per_diff percent7.2;
 run;
ods excel;

proc sql ;
     create table range1 as 
     select ceil(min(&index2)-1) as min1, ceil(max(&index2)+1) as max1, int((ceil(max(&index2)+1)- ceil(min(&index2)-1))/4) as num1, 
            ceil(min(&index1)-1) as min2, ceil(max(&index1)+1) as max2, int((ceil(max(&index1)+1)- ceil(min(&index1)-1))/4) as num2            
from output.&file;
quit;

proc sql noprint;
    select min(min1, min2), max(max1, max2), max(num1,num2)         
    into :min,:max,:num
from range1;
quit;

%put &min &max &num;

*Create the annotate dataset;
data anno;
   function='move'; 
   xsys='1'; ysys='1'; 
   x=0; y=0; 
   output;

   function='draw'; 
   xsys='1'; ysys='1'; 
   color='green'; 
   x=100; y=100; 
   output;
run;


proc gplot data=output.&file;
   label &index2=&label2 &index1=&label1;   
   plot &index2*&index1/anno=anno vaxis=axis1 haxis=axis2 grid frame;
   axis1 order=(0 to &max by &num &max); 
   axis2 order=(0 to &max by &num &max);    
   title1 j=center h=2 bold  "Index by Hospital"; 
   title2 j=center h=1.5 bold "(Correlation Coefficient=&r1)"; 
 run;
 quit;

ods excel;

proc sql;
    create table range2 as
    select ceil(min(&zscore2)-1) as min1, ceil(max(&zscore2)+1) as max1, int((ceil(max(&zscore2)+1)- ceil(min(&zscore2)-1))/4) as num1, 
           ceil(min(&zscore1)-1) as min2, ceil(max(&zscore1)+1) as max2, int((ceil(max(&zscore1)+1)- ceil(min(&zscore1)-1))/4) as num2 
    from output.&file;
quit;

proc sql noprint;
    select min(min1, min2), max(max1, max2), max(num1,num2)         
    into :min,:max,:num
from range2;
quit;

proc gplot data=output.&file;
    label &zscore2=&label2 &zscore1=&label1;   
    plot &zscore2*&zscore1/anno=anno vaxis=axis1 haxis=axis2 regeqn frame grid;
    axis1 order=(&min to &max by &num &max); 
    axis2 order=(&min to &max by &num &max);   
    title1 j=center h=2 bold "Z-Score by Hospital"; 
    title2 j=center h=1.5 bold "(Correlation Coefficient=&r2)";  
 run;
 quit;
ods excel close;

%mend;
%corrgraph(final_oprd_cst, "OPRD-CST v2016", "OPRD-CST v2017", CST2016, CST2016_RENORM, CST2017, CST2017_RENORM, CST_index_2016, CST_index_2017, CST_zscore2016, CST_zscore2017, "CST v2016", "CST v2017");
%corrgraph(final_oprd_chg, "OPRD-CHG v2016", "OPRD-CHG v2017", CHG2016, CHG2016_RENORM, CHG2017, CHG2017_RENORM, CHG_index_2016, CHG_index_2017, CHG_zscore2016, CHG_zscore2017, "CHG v2016", "CHG v2017");
