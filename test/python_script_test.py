# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import numpy as np
import pandas as pd

##########
import os
cwd = os.getcwd()
cwd
os.chdir('OneDrive/github/bigdata_import_zips')


import gzip
import csv
import sqlite3
##############

########### data/offline/SPLITS_US_ALL_BBO_L_20170206
with gzip.open('data/wiki_csv1.csv.gz', 'rt') as input_file: 
    try:
        df = pd.DataFrame.from_csv(input_file)
        
    finally:
        input_file.close()
        

conn = sqlite3.connect("simon.sqlite")

df.to_sql("Data", conn, if_exists='replace', index=False)



