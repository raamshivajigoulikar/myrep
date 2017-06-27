***************************************************************************************** ;
* THIS IS AN EXAMPLE OF A PROGRAM THAT CAN BE USED TO READ IN THE                       * ;
* LINKED NCHS-CMS MEDICARE FEASIBILITY STUDY ASCII FILE.                                * ;
*                                                                                       * ;
* TO DOWNLOAD AND SAVE THE LINKED NCHS-CMS MEDICARE FEASIBILITY STUDY                   * ;
* ASCII FILE TO YOUR HARD DRIVE, FOLLOW THESE STEPS:                                    * ;
*                                                                                       * ;
* STEP 1: DESIGNATE A FOLDER ON YOUR HARD DRIVE TO DOWNLOAD THE LINKED                  * ;
*         NCHS-CMS MEDICARE FEASIBILITY STUDY ASCII FILE. IN THIS                       * ;
*         EXAMPLE, THE DATA WILL BE SAVED TO: 'C:\Feasibility Study Data\'              * ;
*                                                                                       * ;
* STEP 2: DOWNLOAD THE ASCII DATA FROM THE NCHS WEB SITE.                               * ;
*         GO TO THE NCHS WEB SITE (LINK BELOW) AND DOWNLOAD THE LINKED                  * ;
*         NCHS-CMS MEDICARE FEASIBILITY STUDY ASCII FILE TO THE FOLDER                  * ;
*        'C:\Feasibility Study Data\'                                                   * ;
*                                                                                       * ;
* ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/datalinkage/feasibility_study_data/CMS/  * ;
*                                                                                       * ;
*                                                                                       * ;
* IMPORTANT INFORMATION REGARDING THE SURVEY ID VARIABLE:                               * ;
*                                                                                       * ;
*  FOR NHIS AND LSOA II SURVEYS USE PUBLICID AS THE ID VARIABLE                         * ;
*  FOR NHANES AND NHEFS SURVEYS USE SEQN AS THE ID VARIABLE                             * ;
*  FOR NHHCS USE PATNUM AS THE ID VARIABLE                                              * ;
*  FOR NNHS USE RESNUM AS THE ID VARIABLE                                               * ;
*                                                                                       * ;
***************************************************************************************** ;
filename intext "&ip." ; 

data Feasibility ;
	infile intext lrecl=128 ;
	attrib 
		PUBLICID           length=$14           label='NCHS Survey Identifier - Participant Identification Number'  
		SEQN               length=5  format=Z5. label='NCHS Survey Identifier - Sample Sequence Number'        
		PATNUM		   length=6  format=Z6. label='NCHS Survey Identifier - Patient/Discharge Record Number'
		RESNUM             length=6  format=Z6. label='NCHS Survey Identifier - Resident Record (Case) Number' 
		CMS_MEDICARE_MATCH length=3  format=1.  label='CMS MEDICARE MATCH STATUS'

		ON_MBSF_1999   length=3  format=1.  label='ON MBSF FILE INDICATOR (1999)'
		ON_MBSF_2000   length=3  format=1.  label='ON MBSF FILE INDICATOR (2000)'
		ON_MBSF_2001   length=3  format=1.  label='ON MBSF FILE INDICATOR (2001)'
		ON_MBSF_2002   length=3  format=1.  label='ON MBSF FILE INDICATOR (2002)'
		ON_MBSF_2003   length=3  format=1.  label='ON MBSF FILE INDICATOR (2003)'
		ON_MBSF_2004   length=3  format=1.  label='ON MBSF FILE INDICATOR (2004)'
		ON_MBSF_2005   length=3  format=1.  label='ON MBSF FILE INDICATOR (2005)'
		ON_MBSF_2006   length=3  format=1.  label='ON MBSF FILE INDICATOR (2006)'
		ON_MBSF_2007   length=3  format=1.  label='ON MBSF FILE INDICATOR (2007)'
		ON_MBSF_2008   length=3  format=1.  label='ON MBSF FILE INDICATOR (2008)'
		ON_MBSF_2009   length=3  format=1.  label='ON MBSF FILE INDICATOR (2009)'
		ON_MBSF_2010   length=3  format=1.  label='ON MBSF FILE INDICATOR (2010)'
		ON_MBSF_2011   length=3  format=1.  label='ON MBSF FILE INDICATOR (2011)'
		ON_MBSF_2012   length=3  format=1.  label='ON MBSF FILE INDICATOR (2012)'
		ON_MBSF_2013   length=3  format=1.  label='ON MBSF FILE INDICATOR (2013)'

		ON_MEDPAR_1999   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (1999)'
		ON_MEDPAR_2000   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2000)'
		ON_MEDPAR_2001   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2001)'
		ON_MEDPAR_2002   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2002)'
		ON_MEDPAR_2003   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2003)'
		ON_MEDPAR_2004   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2004)'
		ON_MEDPAR_2005   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2005)'
		ON_MEDPAR_2006   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2006)'
		ON_MEDPAR_2007   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2007)'
		ON_MEDPAR_2008   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2008)'
		ON_MEDPAR_2009   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2009)'
		ON_MEDPAR_2010   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2010)'
		ON_MEDPAR_2011   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2011)'
		ON_MEDPAR_2012   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2012)'
		ON_MEDPAR_2013   length=3  format=1.  label='ON MEDPAR FILE INDICATOR (2013)'

		ON_CARRIER_1999   length=3  format=1.  label='ON CARRIER FILE INDICATOR (1999)'
		ON_CARRIER_2000   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2000)'
		ON_CARRIER_2001   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2001)'
		ON_CARRIER_2002   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2002)'
		ON_CARRIER_2003   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2003)'
		ON_CARRIER_2004   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2004)'
		ON_CARRIER_2005   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2005)'
		ON_CARRIER_2006   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2006)'
		ON_CARRIER_2007   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2007)'
		ON_CARRIER_2008   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2008)'
		ON_CARRIER_2009   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2009)'
		ON_CARRIER_2010   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2010)'
		ON_CARRIER_2011   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2011)'
		ON_CARRIER_2012   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2012)'
		ON_CARRIER_2013   length=3  format=1.  label='ON CARRIER FILE INDICATOR (2013)'

		ON_DME_1999   length=3  format=1.  label='ON DME FILE INDICATOR (1999)'
		ON_DME_2000   length=3  format=1.  label='ON DME FILE INDICATOR (2000)'
		ON_DME_2001   length=3  format=1.  label='ON DME FILE INDICATOR (2001)'
		ON_DME_2002   length=3  format=1.  label='ON DME FILE INDICATOR (2002)'
		ON_DME_2003   length=3  format=1.  label='ON DME FILE INDICATOR (2003)'
		ON_DME_2004   length=3  format=1.  label='ON DME FILE INDICATOR (2004)'
		ON_DME_2005   length=3  format=1.  label='ON DME FILE INDICATOR (2005)'
		ON_DME_2006   length=3  format=1.  label='ON DME FILE INDICATOR (2006)'
		ON_DME_2007   length=3  format=1.  label='ON DME FILE INDICATOR (2007)'
		ON_DME_2008   length=3  format=1.  label='ON DME FILE INDICATOR (2008)'
		ON_DME_2009   length=3  format=1.  label='ON DME FILE INDICATOR (2009)'
		ON_DME_2010   length=3  format=1.  label='ON DME FILE INDICATOR (2010)'
		ON_DME_2011   length=3  format=1.  label='ON DME FILE INDICATOR (2011)'
		ON_DME_2012   length=3  format=1.  label='ON DME FILE INDICATOR (2012)'
		ON_DME_2013   length=3  format=1.  label='ON DME FILE INDICATOR (2013)'

		ON_HHA_1999   length=3  format=1.  label='ON HHA FILE INDICATOR (1999)'
		ON_HHA_2000   length=3  format=1.  label='ON HHA FILE INDICATOR (2000)'
		ON_HHA_2001   length=3  format=1.  label='ON HHA FILE INDICATOR (2001)'
		ON_HHA_2002   length=3  format=1.  label='ON HHA FILE INDICATOR (2002)'
		ON_HHA_2003   length=3  format=1.  label='ON HHA FILE INDICATOR (2003)'
		ON_HHA_2004   length=3  format=1.  label='ON HHA FILE INDICATOR (2004)'
		ON_HHA_2005   length=3  format=1.  label='ON HHA FILE INDICATOR (2005)'
		ON_HHA_2006   length=3  format=1.  label='ON HHA FILE INDICATOR (2006)'
		ON_HHA_2007   length=3  format=1.  label='ON HHA FILE INDICATOR (2007)'
		ON_HHA_2008   length=3  format=1.  label='ON HHA FILE INDICATOR (2008)'
		ON_HHA_2009   length=3  format=1.  label='ON HHA FILE INDICATOR (2009)'
		ON_HHA_2010   length=3  format=1.  label='ON HHA FILE INDICATOR (2010)'
		ON_HHA_2011   length=3  format=1.  label='ON HHA FILE INDICATOR (2011)'
		ON_HHA_2012   length=3  format=1.  label='ON HHA FILE INDICATOR (2012)'
		ON_HHA_2013   length=3  format=1.  label='ON HHA FILE INDICATOR (2013)'

		ON_HOSPICE_1999   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (1999)'
		ON_HOSPICE_2000   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2000)'
		ON_HOSPICE_2001   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2001)'
		ON_HOSPICE_2002   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2002)'
		ON_HOSPICE_2003   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2003)'
		ON_HOSPICE_2004   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2004)'
		ON_HOSPICE_2005   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2005)'
		ON_HOSPICE_2006   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2006)'
		ON_HOSPICE_2007   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2007)'
		ON_HOSPICE_2008   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2008)'
		ON_HOSPICE_2009   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2009)'
		ON_HOSPICE_2010   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2010)'
		ON_HOSPICE_2011   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2011)'
		ON_HOSPICE_2012   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2012)'
		ON_HOSPICE_2013   length=3  format=1.  label='ON HOSPICE FILE INDICATOR (2013)'

		ON_OUTPAT_1999   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (1999)'
		ON_OUTPAT_2000   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2000)'
		ON_OUTPAT_2001   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2001)'
		ON_OUTPAT_2002   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2002)'
		ON_OUTPAT_2003   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2003)'
		ON_OUTPAT_2004   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2004)'
		ON_OUTPAT_2005   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2005)'
		ON_OUTPAT_2006   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2006)'
		ON_OUTPAT_2007   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2007)'
		ON_OUTPAT_2008   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2008)'
		ON_OUTPAT_2009   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2009)'
		ON_OUTPAT_2010   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2010)'
		ON_OUTPAT_2011   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2011)'
		ON_OUTPAT_2012   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2012)'
		ON_OUTPAT_2013   length=3  format=1.  label='ON OUTPAT FILE INDICATOR (2013)'

		ON_PDE_2006   length=3  format=1.  label='ON PDE FILE INDICATOR (2006)'
		ON_PDE_2007   length=3  format=1.  label='ON PDE FILE INDICATOR (2007)'
		ON_PDE_2008   length=3  format=1.  label='ON PDE FILE INDICATOR (2008)'
		ON_PDE_2009   length=3  format=1.  label='ON PDE FILE INDICATOR (2009)'
		ON_PDE_2010   length=3  format=1.  label='ON PDE FILE INDICATOR (2010)'
		ON_PDE_2011   length=3  format=1.  label='ON PDE FILE INDICATOR (2011)'
		ON_PDE_2012   length=3  format=1.  label='ON PDE FILE INDICATOR (2012)'
		ON_PDE_2013   length=3  format=1.  label='ON PDE FILE INDICATOR (2013)';

	input 
		/* Survey ID Variables */
		@  1 PUBLICID           $CHAR14. 
		@  1 SEQN                5. 
		@  1 RESNUM              6. 
		@  1 PATNUM              6. 

		/* Linkage to CMS Medicare Admin Data */
		@ 15 CMS_MEDICARE_MATCH  1.

		/* Master Beneficiary Summary File: Positions 16 - 30 */
		@ 16 on_MBSF_1999 1. 
		@ 17 on_MBSF_2000 1. 
		@ 18 on_MBSF_2001 1. 
		@ 19 on_MBSF_2002 1. 
		@ 20 on_MBSF_2003 1. 
		@ 21 on_MBSF_2004 1. 
		@ 22 on_MBSF_2005 1. 
		@ 23 on_MBSF_2006 1. 
		@ 24 on_MBSF_2007 1. 
		@ 25 on_MBSF_2008 1. 
		@ 26 on_MBSF_2009 1. 
		@ 27 on_MBSF_2010 1. 
		@ 28 on_MBSF_2011 1. 
		@ 29 on_MBSF_2012 1. 
		@ 30 on_MBSF_2013 1. 

		/* Medicare Provider Analysis and Review File: Positions 31 - 45 */
		@ 31 on_MEDPAR_1999 1. 
		@ 32 on_MEDPAR_2000 1. 
		@ 33 on_MEDPAR_2001 1. 
		@ 34 on_MEDPAR_2002 1. 
		@ 35 on_MEDPAR_2003 1. 
		@ 36 on_MEDPAR_2004 1. 
		@ 37 on_MEDPAR_2005 1. 
		@ 38 on_MEDPAR_2006 1. 
		@ 39 on_MEDPAR_2007 1. 
		@ 40 on_MEDPAR_2008 1. 
		@ 41 on_MEDPAR_2009 1. 
		@ 42 on_MEDPAR_2010 1. 
		@ 43 on_MEDPAR_2011 1. 
		@ 44 on_MEDPAR_2012 1. 
		@ 45 on_MEDPAR_2013 1. 

		/* Carrier File: Positions 46 - 60 */
		@ 46 on_CARRIER_1999 1. 
		@ 47 on_CARRIER_2000 1. 
		@ 48 on_CARRIER_2001 1. 
		@ 49 on_CARRIER_2002 1. 
		@ 50 on_CARRIER_2003 1. 
		@ 51 on_CARRIER_2004 1. 
		@ 52 on_CARRIER_2005 1. 
		@ 53 on_CARRIER_2006 1. 
		@ 54 on_CARRIER_2007 1. 
		@ 55 on_CARRIER_2008 1. 
		@ 56 on_CARRIER_2009 1. 
		@ 57 on_CARRIER_2010 1. 
		@ 58 on_CARRIER_2011 1. 
		@ 59 on_CARRIER_2012 1. 
		@ 60 on_CARRIER_2013 1. 

		/* Durable Medical Equipment File: Positions 61 - 75 */
		@ 61 on_DME_1999 1. 
		@ 62 on_DME_2000 1. 
		@ 63 on_DME_2001 1. 
		@ 64 on_DME_2002 1. 
		@ 65 on_DME_2003 1. 
		@ 66 on_DME_2004 1. 
		@ 67 on_DME_2005 1. 
		@ 68 on_DME_2006 1. 
		@ 69 on_DME_2007 1. 
		@ 70 on_DME_2008 1. 
		@ 71 on_DME_2009 1. 
		@ 72 on_DME_2010 1. 
		@ 73 on_DME_2011 1. 
		@ 74 on_DME_2012 1. 
		@ 75 on_DME_2013 1. 

		/* Home Health Agency File: Positions 76 - 90 */
		@ 76 on_HHA_1999 1. 
		@ 77 on_HHA_2000 1. 
		@ 78 on_HHA_2001 1. 
		@ 79 on_HHA_2002 1. 
		@ 80 on_HHA_2003 1. 
		@ 81 on_HHA_2004 1. 
		@ 82 on_HHA_2005 1. 
		@ 83 on_HHA_2006 1. 
		@ 84 on_HHA_2007 1. 
		@ 85 on_HHA_2008 1. 
		@ 86 on_HHA_2009 1. 
		@ 87 on_HHA_2010 1. 
		@ 88 on_HHA_2011 1. 
		@ 89 on_HHA_2012 1. 
		@ 90 on_HHA_2013 1. 

		/* Hospice File: Positions 91 - 105 */
		@ 91 on_HOSPICE_1999 1. 
		@ 92 on_HOSPICE_2000 1. 
		@ 93 on_HOSPICE_2001 1. 
		@ 94 on_HOSPICE_2002 1. 
		@ 95 on_HOSPICE_2003 1. 
		@ 96 on_HOSPICE_2004 1. 
		@ 97 on_HOSPICE_2005 1. 
		@ 98 on_HOSPICE_2006 1. 
		@ 99 on_HOSPICE_2007 1. 
		@ 100 on_HOSPICE_2008 1. 
		@ 101 on_HOSPICE_2009 1. 
		@ 102 on_HOSPICE_2010 1. 
		@ 103 on_HOSPICE_2011 1. 
		@ 104 on_HOSPICE_2012 1. 
		@ 105 on_HOSPICE_2013 1. 

		/* Outpatient File: Positions 106 - 120 */
		@ 106 on_OUTPAT_1999 1. 
		@ 107 on_OUTPAT_2000 1. 
		@ 108 on_OUTPAT_2001 1. 
		@ 109 on_OUTPAT_2002 1. 
		@ 110 on_OUTPAT_2003 1. 
		@ 111 on_OUTPAT_2004 1. 
		@ 112 on_OUTPAT_2005 1. 
		@ 113 on_OUTPAT_2006 1. 
		@ 114 on_OUTPAT_2007 1. 
		@ 115 on_OUTPAT_2008 1. 
		@ 116 on_OUTPAT_2009 1. 
		@ 117 on_OUTPAT_2010 1. 
		@ 118 on_OUTPAT_2011 1. 
		@ 119 on_OUTPAT_2012 1. 
		@ 120 on_OUTPAT_2013 1. 

		/* Part D Prescription Drug Event File: Positions 121 - 128 */
		@ 121 on_PDE_2006 1. 
		@ 122 on_PDE_2007 1. 
		@ 123 on_PDE_2008 1. 
		@ 124 on_PDE_2009 1. 
		@ 125 on_PDE_2010 1. 
		@ 126 on_PDE_2011 1. 
		@ 127 on_PDE_2012 1. 
		@ 128 on_PDE_2013 1.;
run ;
    

proc export data=feasibility outfile="&op."
dbms=csv
replace;
run;
