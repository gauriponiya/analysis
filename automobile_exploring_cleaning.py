#!/usr/bin/env python
# coding: utf-8

# In[1]:


# import libraries
import pandas as pd
import numpy as np


# In[3]:


# load file into panda dataframe
df = pd.read_csv('Automobile.csv')


# In[41]:


# Data exploration
print("dimentions of the datset:", df.shape)
print("\nfirst few rows of the dataset:")
print(df.head())
print("\ninformation about the dataset:\n")
print(df.info())
print("\nsummary statistics of numerical columns:\n")
print(df.describe())
print("\nunique values in name column\n")
for column in df.select_dtypes(include= 'object'):
    print(column, ":", df[column].unique())


# In[42]:


print(df)


# In[43]:


# data cleaning

if df.duplicated().any():
    df.drop_duplicate(inplace=True)
    print("duplicates=yes")
    
else:
    print("duplicate=no")


# In[37]:


missing_value_count = df.isnull().sum()
print("\nmissing values count")
print(missing_value_count)

# Get rows and columns with missing values
rows_with_missing = df[df.isnull().any(axis=1)]
columns_with_missing = df.columns[df.isnull().any()]

# Print rows with missing values
print("\nRows with missing values:")
print(rows_with_missing)

# Print columns with missing values
print("\nColumns with missing values:")
print(columns_with_missing)


# In[36]:


# Delete rows with missing values
df.dropna(inplace=True)


# In[40]:


# Convert column from float to int
df['mpg'] = df['mpg'].astype(int)


# In[ ]:




