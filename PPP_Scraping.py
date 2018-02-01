
# coding: utf-8

# In[1]:


from bs4 import BeautifulSoup


# In[2]:


url="https://data.oecd.org/conversion/purchasing-power-parities-ppp.htm"


# In[3]:


import request


# In[4]:


from request import urllib


# In[5]:


import urllib


# In[6]:


dir(urllib)


# In[7]:


from urllib import request


# In[8]:


dir(request)


# In[9]:


html=request.urlopen(url)


# In[10]:


html


# In[11]:


soup=BeautifulSoup(html)


# In[12]:


soup


# In[13]:


print(soup.prettify())


# In[14]:


soup.title


# In[15]:


soup.find_all('table',class_=ar'table-cht-table')


# In[16]:


t=soup.find('table')


# In[17]:


t


# In[18]:


print(t)


# In[19]:


html=request.urlopen("file:///D:/Users/rgoulika/Desktop/Python/ppp.html")


# In[20]:


html


# In[21]:


soup=BeautifulSoup(html)


# In[22]:


soup.find_all('table')


# In[23]:


print(soup.prettify())


# In[24]:


soup.find_all('<tr>')


# In[25]:


soup.find_all('table',class_='table-chart-thead-th')


# In[26]:


soup.find_all('a',class_='table-chart-sort-link')


# In[27]:


th=soup.find_all('a',class_='table-chart-sort-link')


# In[28]:


type(th)


# In[29]:


th.get('a')


# In[30]:


dir(th)


# In[31]:


for i in th:
    print(i.get('a'))


# In[32]:


len(th)


# In[36]:


for i in th:
    print(i.get_text().strip('?'))


# In[37]:


soup.find_all('tr',class_='table-chart-tbody-tr')


# In[38]:


for j in soup.find_all('tr',class_='table-chart-tbody-tr'):
    print(j.get_text())
    


# In[39]:


for j in soup.find_all('tr',class_='table-chart-tbody-tr'):
    print(j.get_text(),'|')


# In[40]:


soup.find_all('th',class_='table-chart-tbody-th')


# In[41]:


soup.find_all('span',class_='table-chart-value')


# In[42]:


soup.find_all('span',class_='table-chart-value').get_text()


# In[43]:


for j in soup.find_all('span',class_='table-chart-value'):
    print(j.get_text())


# In[44]:


import sqlite3


# In[45]:


dir(sqlite3)

