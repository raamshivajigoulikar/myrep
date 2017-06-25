import urllib
from bs4 import BeautifulSoup
import urllib2
import os
import sqlite3
os.chdir("D:\Harshitha_work\Health Data Project")
os.mkdir("Link16")
os.chdir(".\Link16")
os.mkdir("CMS_DATA")
os.chdir(".\CMS_DATA")

url="https://ftp.cdc.gov/pub/Health_Statistics/NCHS/datalinkage/feasibility_study_data/CMS/"

html=urllib2.urlopen(url)
soup=BeautifulSoup(html)

all_links=soup.find_all("a")
for link in all_links:
        if ".dat" in link.get("href").lower():
                m=link.get("href")
                file_name=str(link.get("href")).split("/")[-1]
                down_link=url + file_name
                print "DataLink is: ", down_link
                urllib.urlretrieve(down_link,file_name)
