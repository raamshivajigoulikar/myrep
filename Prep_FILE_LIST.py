import os
import csv

file_list=os.listdir("C:\HealthData_projekt\Link16\medicaid")

opfile=open("C:\HealthData_projekt\Link16\cms_medicaid_list.csv","wb")

wr=csv.writer(opfile,delimiter=',')

wr.writerow(['ip_file','op_file','prog_name'])

a="C:\HealthData_projekt\Link16\medicaid\\"
b="C:\HealthData_projekt\Link16\CMS_MEDICAID_OP\\"
c="C:\HealthData_projekt\Link16\CMS_MEDICAID_PROG.sas"

for l in file_list:
    k=[a+l,b+l.upper().split('.DAT')[0]+'.CSV',c]
    wr.writerow(k)

opfile.close()



