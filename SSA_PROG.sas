************************************************************************************************* ;
* THIS IS AN EXAMPLE OF A PROGRAM THAT CAN BE USED TO READ IN THE                               * ;
* LINKED NCHS-CMS SSA (FINAL) FEASIBILITY STUDY ASCII FILE.      	                        * ;
*                                                                                               * ;
* TO DOWNLOAD AND SAVE THE LINKED NCHS-SSA (FINAL) FEASIBILITY STUDY        	                * ;
* ASCII FILE TO YOUR HARD DRIVE, FOLLOW THESE STEPS:                                            * ;
*                                                                                               * ;
* STEP 1: DESIGNATE A FOLDER ON YOUR HARD DRIVE TO DOWNLOAD THE LINKED                          * ;
*         NCHS-SSA FEASIBILITY STUDY ASCII FILE. IN THIS EXAMPLE		                * ;
*         THE DATA WILL BE SAVED TO: 'C:\Feasibility Study Data\'                     		* ;
*                                                                                               * ;
* STEP 2: DOWNLOAD THE ASCII DATA FROM THE NCHS WEB SITE.                                       * ;
*         GO TO THE NCHS WEB SITE (LINK BELOW) AND DOWNLOAD THE LINKED                          * ;
*         NCHS-SSA (FINAL) FEASIBILITY STUDY ASCII FILE TO THE FOLDER   		        * ;
*        'C:\Feasibility Study Data\'                                                           * ;
*                                                                                               * ;
* ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/datalinkage/feasibility_study_data/ssa/		* ;
*                                                                                               * ;
*                                                                                               * ;
* IMPORTANT INFORMATION REGARDING THE SURVEY ID VARIABLE:                                       * ;
*                                                                                               * ;
*  FOR NHIS USE PUBLICID AS THE ID VARIABLE                                                     * ;
*  FOR NHANES USE SEQN AS THE ID VARIABLE                                                       * ;
*  FOR NNHS USE RESNUM AS THE ID VARIABLE                                                       * ;
*                                                                                               * ;
************************************************************************************************* ;

filename intext "&ip."; 

data Feasibility ;
 infile intext lrecl=20 ;

 input  @1 PUBLICID		$CHAR14.
	@1 SEQN			5.
	@1 RESNUM		7. /* FOR NNHS 1985 RESNUM SHOULD BE CREATED USING POSITIONS 1 - 7 */ 
	@1 RESNUM		6. /* FOR NNHS 1995 1997 AND 2004 RESNUM SHOULD BE CREATED USING POSITIONS 1 - 6 */ 
	@15 SSA_MATCH  		1.
	@16 ON_MBR_FLAG 	1.
	@17 ON_SSR_FLAG 	1.
	@18 ON_PHUS_FLAG	1.
	@19 ON_831_FLAG 	1.
	@20 ON_QOC_FLAG 	1. ;	

  attrib 
 
	 PUBLICID	length=$14  label="NCHS SURVEY ID NUMBER"
	 SEQN          	length=5    label="SAMPLE SEQUENCE NUMBER (PUBLIC ID)"
	 RESNUM         length=7    label="NCHS SURVEY IDENTIFIER - RESIDENT RECORD NUMBER" 
         SSA_MATCH     	length=3    label="SSA MATCH STATUS"
         ON_MBR_FLAG  	length=3    label="ON MBR FILE INDICATOR"
         ON_SSR_FLAG  	length=3    label="ON SSR FILE INDICATOR"
         ON_PHUS_FLAG 	length=3    label="ON PHUS FILE INDICATOR"
         ON_831_FLAG  	length=3    label="ON 831 FILE INDICATOR"
         ON_QOC_FLAG  	length=3    label="ON QOC FILE INDICATOR";
run;

proc export data=feasibility outfile="&op."
dbms=csv
replace;
run;
