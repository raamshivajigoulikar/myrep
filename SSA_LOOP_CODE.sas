data ip_ds;
infile "C:\HealthData_Projekt\Link16\cms_medicaid_list.csv" dsd firstobs=2;
input ip_file :$100. op_file :$100. prog_name :$100.;
run;


data _null_;
set ip_ds;
call symput(cat('var',_n_),compress(ip_file||';'||op_file||';'||prog_name," "));
run;

options mprint mlogic symbolgen;

%macro loop_prog();

proc sql;
select count(*) into :ip_cnt from ip_ds;
quit;


%do i =1 %to &ip_cnt.;
	%let ip= %qscan(&&var&i.,1,';');
	%let op= %qscan(&&var&i.,2,';');
	%let prog=%qscan(&&var&i.,3,';');

    %put "The variables are: " &ip. &op. &prog.;
    %include "&prog.";
%end;

%mend loop;

%loop_prog()



