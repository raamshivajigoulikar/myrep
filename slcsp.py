import os
import pandas as pd
import pandasql as psql

def read_files():
    print("----------Reading the Input Files-------")
    zips=pd.read_csv(r"C:\Users\slcsp\zips.csv")
    slcsp=pd.read_csv(r"C:\Users\slcsp\slcsp.csv")
    plans=pd.read_csv(r"C:\Users\slcsp\plans.csv")
    return zips, slcsp, plans



def process_data(zips,slcsp,plans):
    print("-----------Merging the zips and Plans to get the rate for the state and rate_area---------")
    q="select distinct a.zipcode,a.state,a.rate_area,b.rate,b.metal_level from zips a inner join plans b where a.state=b.state and a.rate_area=b.rate_area and b.metal_level='Silver'"
    zips_2=psql.sqldf(q,locals())
    print("-----------Checking the count for each zipcode and state for multiple rate_area---------")
    q="select zipcode,state,count(distinct rate_area) as check_multi_rate from zips_2 group by zipcode, state"
    zips_3=psql.sqldf(q,locals())
    print("-----------Filtering out the records with multiple rate_area for the zipcode---------")
    q="select * from zips_2 where zipcode in (select distinct zipcode from zips_3 where check_multi_rate = 1)"
    zips_2=psql.sqldf(q,locals())a
    zips_2.sort_values(by=['zipcode','state','rate_area','rate'],inplace=True)
    q="select distinct zipcode,rate from zips_2"
    zips_final=psql.sqldf(q,locals())
    print("-----------Creating the row numbers for each zipcode group---------")
    zips_final['row']=zips_final.groupby(['zipcode']).cumcount()+1
    zips_final_secondlowest=zips_final[zips_final['row']==2]
    print("-----------Merging the input with the zipcode and second lowest rate for Silver---------")
    q="select a.zipcode,b.rate from slcsp a left join zips_final_secondlowest b on a.zipcode=b.zipcode "
    slcsp=psql.sqldf(q,locals())
    print("-----------Exporting the final data to a CSV file---------")
    slcsp.to_csv(r"C:\Users\slcsp\slcsp_new.csv",index=None, header=True)


if __name__=="__main__":
    zips,slcsp,plans=read_files()
    process_data(zips,slcsp,plans)
