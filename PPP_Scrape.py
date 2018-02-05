from bs4 import BeautifulSoup
from urllib import request
import sqlite3
import unidecode
url="file:///F:/Python/ppp.html"

html=request.urlopen(url)

soup=BeautifulSoup(html)

th=soup.find_all('a',class_='table-chart-sort-link')

col_names=[]
for i in th:
    print(i.get_text().strip('?'))
    col_names.append(i.get_text().strip('?')[1:])

col_names[0]='Location'

#conn=sqlite3.connect("PPP.db")

cr_qry = "CREATE TABLE PPP_VALUES ( Location TEXT NOT NULL "
last_item=col_names[len(col_names) - 1]
for c in col_names:
    if c != "Location":
        cr_qry=cr_qry + " , Year_" + c +  " REAL "
        if c == last_item:
            cr_qry=cr_qry + " ) ;"
print(cr_qry)
ll=[]
ll_a=[]
cnt=0
for j in soup.find_all('span', class_='table-chart-value'):
	     if j.get_text()=='':
		     k='0.0'
	     else:
		     k=j.get_text()
	     if cnt == 56:
	        ll.append(ll_a)
	        ll_a=ll_a.append(float(k.encode('ascii','ignore')))
	        cnt=0
	        ll_a=[]
	     else:
	        ll_a.append(float(k.encode('ascii','ignore')))
	        cnt=cnt+1
dd={}
for h in soup.find_all('th',class_="table-chart-tbody-th"):
       dd[h.get_text()]=[]
cnt=0
for z in list(dd.keys()):
	     dd[z]=ll[cnt]
	     cnt=cnt + 1

#conn.execute(cr_qry)
