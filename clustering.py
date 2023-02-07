import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import MinMaxScaler
from openpyxl import load_workbook
import statistics
from statistics import stdev
from sklearn.preprocessing import StandardScaler
from datetime import datetime

# Read Data
df = pd.read_excel('Laporan tanah.xlsx', header=None)

# Data Mining Process
# Preprocessing
df = df.drop(0)
df = df.drop(1)
df = df.reset_index(drop=True)
df.columns = df.iloc[0]
df.drop(df.index[0])
df = df.drop(0)
def_status = 0
df.fillna(def_status, inplace=True)
df.columns = df.columns.str.replace(' ', '_')
df = df.loc[:, ["PEMILIK_SEKARANG", "HARGA_TAKSIR_NJOP",
                "PENGGUNAAN", "PRODUKTIF", "SENGKETA"]]

for index, row in df.iterrows():
    if row['HARGA_TAKSIR_NJOP'] > 0:
        df.loc[index, 'HARGA'] = '0'
    else:
        df.loc[index, 'HARGA'] = '1'

for index, row in df.iterrows():
    if row['PENGGUNAAN'] == 'Belum termanfaatkan':
        df.loc[index, 'PENGGUNAAN_ASET'] = '1'
    else:
        df.loc[index, 'PENGGUNAAN_ASET'] = '0'

for index, row in df.iterrows():
    if row['SENGKETA'] == 'Tidak':
        df.loc[index, 'SENGKETA_ASET'] = '0'
    else:
        df.loc[index, 'SENGKETA_ASET'] = '2'

df = df.loc[:, ["HARGA", "PENGGUNAAN_ASET", "SENGKETA_ASET"]]

data_types = {'HARGA': int}
df = df.astype(data_types)

data_types = {'PENGGUNAAN_ASET': int}
df = df.astype(data_types)

data_types = {'SENGKETA_ASET': int}
df = df.astype(data_types)

# K-Means Proses
X = df
cols = X.columns

ms = MinMaxScaler()

X = ms.fit_transform(X)
X = pd.DataFrame(X, columns=[cols])

kmeans = KMeans(n_clusters=3, random_state=0)

kmeans.fit(X)
kmeans.cluster_centers_
kmeans.inertia_
kmeans = KMeans(n_clusters=3, random_state=0)

y_predicted = kmeans.fit_predict(X)
y_predicted

df['HASIL'] = y_predicted
conditions = [
    (df['HASIL'] == 0),
    (df['HASIL'] == 1),
    (df['HASIL'] == 2)]
choices = ['Produktif', 'Tidak Diketahui', 'Tidak Produktif']
df['HASIL'] = np.select(conditions, choices)

conditions = [
    (df['HASIL'] == 'Produktif'),
    (df['HASIL'] == 'Tidak Diketahui'),
    (df['HASIL'] == 'Tidak Produktif')]
choices = ['Aset Telah Digunakan',
           'Belum diverifikasi', 'Aset Belum Digunakan']
df['Keterangan'] = np.select(conditions, choices)
print(df)
