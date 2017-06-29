import os
from bs4 import BeautifulSoup
import urllib
os.chdir("C:\\HealthData_Projekt\\Link14")


url="https://ftp.cdc.gov/pub/Health_Statistics/NCHS/Datasets/nis/"

html=urllib.urlopen(url)
soup=BeautifulSoup(html)
all_links=soup.find_all("a")
print all_links

for link in all_links:
    if (".dat" or ".sas") in link.get("href").lower():
                m=link.get("href")
                file_name=str(link.get("href")).split("/")[-1]
                down_link=url + file_name
                print "DataLink is: ", down_link
                urllib.urlretrieve(down_link,file_name)
    
