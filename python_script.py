import numpy as np
import pandas as pd

##########
import os
cwd = os.getcwd()
cwd
os.chdir('C:\\Users\\Schliebs\\OneDrive\\github\\bigdata_import_zips')


import gzip
import csv
import sqlite3
##############

########### data/offline/SPLITS_US_ALL_BBO_L_20170206
with gzip.open('data/offline/SPLITS_US_ALL_BBO_L_20170206.gz', 'rt') as input_file: 
    try:
        df = pd.DataFrame.from_csv(input_file,sep = "|",low_memory=False)
        print(type(input_file))
        print(type(df))

    finally:
        input_file.close()
        

conn = sqlite3.connect("simon_realdata.sqlite")


df.to_sql("Data", conn, if_exists='replace')
df.shape
