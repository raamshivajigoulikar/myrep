************************************************************************************************* ;
* THIS IS AN EXAMPLE OF A PROGRAM THAT CAN BE USED TO READ IN THE                               * ;
* LINKED NCHS-CMS MEDICAID (MAX) FEASIBILITY STUDY ASCII FILE.                                  * ;
*                                                                                               * ;
* TO DOWNLOAD AND SAVE THE LINKED NCHS-CMS MEDICAID (MAX) FEASIBILITY STUDY                     * ;
* ASCII FILE TO YOUR HARD DRIVE, FOLLOW THESE STEPS:                                            * ;
*                                                                                               * ;
* STEP 1: DESIGNATE A FOLDER ON YOUR HARD DRIVE TO DOWNLOAD THE LINKED                          * ;
*         NCHS-CMS MEDICARE FEASIBILITY STUDY ASCII FILE. IN THIS                               * ;
*         EXAMPLE, THE DATA WILL BE SAVED TO: 'C:\Feasibility Study Data\'                      * ;
*                                                                                               * ;
* STEP 2: DOWNLOAD THE ASCII DATA FROM THE NCHS WEB SITE.                                       * ;
*         GO TO THE NCHS WEB SITE (LINK BELOW) AND DOWNLOAD THE LINKED                          * ;
*         NCHS-CMS MEDICAID (MAX) FEASIBILITY STUDY ASCII FILE TO THE FOLDER                    * ;
*        'C:\Feasibility Study Data\'                                                           * ;
*                                                                                               * ;
* ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/datalinkage/feasibility_study_data/CMS/Medicaid  * ;
*                                                                                               * ;
*                                                                                               * ;
* IMPORTANT INFORMATION REGARDING THE SURVEY ID VARIABLE:                                       * ;
*                                                                                               * ;
*  FOR NHIS USE PUBLICID AS THE ID VARIABLE                                                     * ;
*  FOR NHANES USE SEQN AS THE ID VARIABLE                                                       * ;
*  FOR NNHS USE RESNUM AS THE ID VARIABLE                                                       * ;
*                                                                                               * ;
************************************************************************************************* ;

filename intext "&ip." ; 

data Feasibility ;
	infile intext lrecl=70 ;

	input  @1 PUBLICID		$CHAR14. 
		@1 SEQN             5. 
		@1 RESNUM           6. 
		@15 CMS_MEDICAID_MATCH 	1.
		@16 ON_PS_1999		1.
		@17 ON_PS_2000		1.
		@18 ON_PS_2001		1.
		@19 ON_PS_2002		1.
		@20 ON_PS_2003		1.
		@21 ON_PS_2004		1.
		@22 ON_PS_2005		1.
		@23 ON_PS_2006		1.
		@24 ON_PS_2007		1.
		@25 ON_PS_2008		1.
		@26 ON_PS_2009		1.
		@27 ON_IP_1999		1.
		@28 ON_IP_2000		1.
		@29 ON_IP_2001		1.
		@30 ON_IP_2002		1.
		@31 ON_IP_2003		1.
		@32 ON_IP_2004		1.
		@33 ON_IP_2005		1.
		@34 ON_IP_2006		1.
		@35 ON_IP_2007		1.
		@36 ON_IP_2008		1.
		@37 ON_IP_2009		1.
		@38 ON_LT_1999		1.
		@39 ON_LT_2000		1.
		@40 ON_LT_2001		1.
		@41 ON_LT_2002		1.
		@42 ON_LT_2003		1.
		@43 ON_LT_2004		1.
		@44 ON_LT_2005		1.
		@45 ON_LT_2006		1.
		@46 ON_LT_2007		1.
		@47 ON_LT_2008		1.
		@48 ON_LT_2009		1.
		@49 ON_OT_1999		1.
		@50 ON_OT_2000		1.
		@51 ON_OT_2001		1.
		@52 ON_OT_2002		1.
		@53 ON_OT_2003		1.
		@54 ON_OT_2004		1.
		@55 ON_OT_2005		1.
		@56 ON_OT_2006		1.
		@57 ON_OT_2007		1.
		@58 ON_OT_2008		1.
		@59 ON_OT_2009		1.
		@60 ON_RX_1999		1.
		@61 ON_RX_2000		1.
		@62 ON_RX_2001		1.
		@63 ON_RX_2002		1.
		@64 ON_RX_2003		1.
		@65 ON_RX_2004		1.
		@66 ON_RX_2005		1.
		@67 ON_RX_2006		1.
		@68 ON_RX_2007		1.
		@69 ON_RX_2008		1.
		@70 ON_RX_2009		1.;	

	attrib 
		ON_PS_1999 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (1999)'
		ON_PS_2000 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2000)'
		ON_PS_2001 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2001)'
		ON_PS_2002 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2002)'
		ON_PS_2003 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2003)'
		ON_PS_2004 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2004)'
		ON_PS_2005 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2005)'
		ON_PS_2006 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2006)'
		ON_PS_2007 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2007)'
		ON_PS_2008 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2008)'
		ON_PS_2009 length=3  label='ON MAX PERSON SUMMARY FILE INDICATOR (2009)'

		ON_IP_1999 length=3  label='ON MAX INPATIENT FILE INDICATOR (1999)'
		ON_IP_2000 length=3  label='ON MAX INPATIENT FILE INDICATOR (2000)'
		ON_IP_2001 length=3  label='ON MAX INPATIENT FILE INDICATOR (2001)'
		ON_IP_2002 length=3  label='ON MAX INPATIENT FILE INDICATOR (2002)'
		ON_IP_2003 length=3  label='ON MAX INPATIENT FILE INDICATOR (2003)'
		ON_IP_2004 length=3  label='ON MAX INPATIENT FILE INDICATOR (2004)'
		ON_IP_2005 length=3  label='ON MAX INPATIENT FILE INDICATOR (2005)'
		ON_IP_2006 length=3  label='ON MAX INPATIENT FILE INDICATOR (2006)'
		ON_IP_2007 length=3  label='ON MAX INPATIENT FILE INDICATOR (2007)'
		ON_IP_2008 length=3  label='ON MAX INPATIENT FILE INDICATOR (2008)'
		ON_IP_2009 length=3  label='ON MAX INPATIENT FILE INDICATOR (2009)'

		ON_LT_1999 length=3  label='ON MAX LONG TERM FILE INDICATOR (1999)'
		ON_LT_2000 length=3  label='ON MAX LONG TERM FILE INDICATOR (2000)'
		ON_LT_2001 length=3  label='ON MAX LONG TERM FILE INDICATOR (2001)'
		ON_LT_2002 length=3  label='ON MAX LONG TERM FILE INDICATOR (2002)'
		ON_LT_2003 length=3  label='ON MAX LONG TERM FILE INDICATOR (2003)'
		ON_LT_2004 length=3  label='ON MAX LONG TERM FILE INDICATOR (2004)'
		ON_LT_2005 length=3  label='ON MAX LONG TERM FILE INDICATOR (2005)'
		ON_LT_2006 length=3  label='ON MAX LONG TERM FILE INDICATOR (2006)'
		ON_LT_2007 length=3  label='ON MAX LONG TERM FILE INDICATOR (2007)'
		ON_LT_2008 length=3  label='ON MAX LONG TERM FILE INDICATOR (2008)'
		ON_LT_2009 length=3  label='ON MAX LONG TERM FILE INDICATOR (2009)'

		ON_OT_1999 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (1999)'
		ON_OT_2000 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2000)'
		ON_OT_2001 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2001)'
		ON_OT_2002 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2002)'
		ON_OT_2003 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2003)'
		ON_OT_2004 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2004)'
		ON_OT_2005 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2005)'
		ON_OT_2006 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2006)'
		ON_OT_2007 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2007)'
		ON_OT_2008 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2008)'
		ON_OT_2009 length=3  label='ON MAX OTHER SERVICES FILE INDICATOR (2009)'

		ON_RX_1999 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (1999)'
		ON_RX_2000 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2000)'
		ON_RX_2001 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2001)'
		ON_RX_2002 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2002)'
		ON_RX_2003 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2003)'
		ON_RX_2004 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2004)'
		ON_RX_2005 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2005)'
		ON_RX_2006 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2006)'
		ON_RX_2007 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2007)'
		ON_RX_2008 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2008)'
		ON_RX_2009 length=3  label='ON MAX PRESRCIPTION DRUG FILE INDICATOR (2009)';
run;


proc export data=feasibility outfile="&op."
dbms=csv
replace;
run;

