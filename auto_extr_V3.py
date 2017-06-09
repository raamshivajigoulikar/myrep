import pandas as pd
import wrds
import csv
import os
df=pd.read_csv('ALL_CEO.csv')
ceo_list=list(df['CEO_NAME'])
not_found_list=[]
comp_list=list(df['Company Name'])

ceo_dict={}

for i in range(735):
	ceo_dict[ceo_list[i]]=comp_list[i]

if 'ALL_COMP_DET.csv' in os.listdir('.'):
	os.remove('ALL_COMP_DET.csv')


with open('ALL_COMP_DET.csv','a') as f:
	for i in ceo_list:
		k=i.split()
		n=str(ceo_dict[i])
		print("Processing CEO and Comp ",i,":",ceo_dict[i])
		if (len(k[1])==1 and n !='nan'):
			m=ceo_dict[i].split()
			qry='select b.personid,b.proid,b.personname,b.companyname,b.year,b.ctype1,b.ctype2,b.ctype3,b.ctype5,b.ctype15,b.ctype18,b.ctype19,b.ctype21,a.currencyname,b.title from ciq.ciqcurrency a,ciq.wrds_compensation b where lower(b.personname) contains '+ '"' +(k[2].lower())+', '+(k[0].lower())+'" and lower(b.companyname) contains '+ '"'+(m[0].lower())+'"'+' and a.currencyid=b.currencyid'
			res=wrds.sql(qry)
			if res.empty:
				print "Its Empty: ",i
				not_found_list.append(i)
			res.to_csv(f,encoding='utf-8',header=False)
		if (len(k[1])!= 1 and n !='nan'):
			m=ceo_dict[i].split()
			qry='select b.personid,b.proid,b.personname,b.companyname,b.year,b.ctype1,b.ctype2,b.ctype3,b.ctype5,b.ctype15,b.ctype18,b.ctype19,b.ctype21,a.currencyname,b.title from ciq.ciqcurrency a ,ciq.wrds_compensation b where lower(b.personname) contains '+ '"' +(k[1].lower())+', '+(k[0].lower())+'" and lower(b.companyname) contains '+ '"'+(m[0].lower())+'"'+' and a.currencyid=b.currencyid'
			res=wrds.sql(qry)
			if res.empty:
				print "Its Empty: ",i
				not_found_list.append(i)
			res.to_csv(f,encoding='utf-8',header=False)
		if n=='nan':
			print "Its Empty: ",i
			not_found_list.append(i)

print "Sample Not Found List is: ", not_found_list[0:10]

		
with open('not_found_list.csv','wb') as f:
	writer=csv.writer(f)
	writer.writerow(not_found_list)