from flask import Flask, render_template, url_for, redirect, request, session, flash
from flaskext.mysql import MySQL
from werkzeug.security import check_password_hash, generate_password_hash
import pandas as pd
import pymysql
import numpy as np
from matplotlib import pyplot as plt
from sklearn.cluster import KMeans
from openpyxl import load_workbook
from sklearn.preprocessing import StandardScaler
from datetime import datetime
import pickle

# memanggil library name pada flask
app = Flask(__name__)
model1 = pickle.load(open("modelTanah.pkl", "rb"))
model2 = pickle.load(open("modelBangunan.pkl", "rb"))
model3 = pickle.load(open("modelKendaraan.pkl", "rb"))
model4 = pickle.load(open("modelBarang.pkl", "rb"))

# change this to your secret key (can be anything, it's for extra protection)
app.secret_key = 'myKey'

mysql = MySQL()

# MySQL configurations

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'pwm_db'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)


# http://localhost:5000/login/ - this will be the login page
@app.route("/", methods=["POST", "GET"])
def login():

    # Check if "Username" and "Password" POST request exist (User sumbitted form)
    if request.method == 'POST':
        # Create variables for easy access
        username = request.form['username']
        password = request.form['password']

        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # cek data username
        cursor.execute(
            'SELECT * FROM users WHERE username=%s', (username,))
        akun = cursor.fetchone()
        if not akun or not check_password_hash(akun['password'], password):
            flash('Username atau Password salah', 'danger')
        else:
            session['loggedin'] = True
            session['username'] = akun['username']
            session['level'] = akun['level']
            session['nama'] = akun['nama']
            return redirect(url_for('dashboard_super'))

    return render_template('login.html')


@app.route("/dashboard")
def dashboard_super():
    if 'loggedin' in session:
        return render_template('dashboard_admin.html')
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


@app.route("/view_user")
def user_view():

    # make connection to mysql
    conn = mysql.connect()
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    if 'loggedin' in session:
        if session['level'] == 'Admin Super':
            # Eksekusi query SELECT
            cursor.execute("SELECT * FROM users")
            # Mengambil hasil eksekusi query dan menyimpannya dalam variabel data
            data = cursor.fetchall()

            # menyisipkan data ke tampil_user.html
            return render_template('tampil_user.html', user=data)
        else:
            return render_template('404.html')

    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


@app.route("/input", methods=('GET', 'POST'))
def user_input():
    if 'loggedin' in session:
        if session['level'] == 'Admin Super':

            if request.method == 'POST':
                nama = request.form['nama']
                username = request.form['username']
                password = request.form['password']
                email = request.form['email']
                level = request.form['level']

                # cek username atau email
                conn = mysql.connect()
                cursor = conn.cursor(pymysql.cursors.DictCursor)
                cursor.execute(
                    'SELECT * FROM users WHERE username=%s  OR email=%s', (username, email, ))
                akun = cursor.fetchone()
                if akun is None:
                    cursor.execute('INSERT INTO users Values (NULL, %s, %s, %s, %s, %s)', (
                        nama, username, generate_password_hash(password), email, level))
                    conn.commit()
                    flash('Registrasi Berhasil', 'success')
                else:
                    flash('Username atau Email sudah ada', 'danger')

            return render_template('user_input.html')
        else:
            return render_template('404.html')
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


@app.route('/edit/<id>', methods=["POST", "GET"])
def user_edit(id):
    if 'loggedin' in session:
        if session['level'] == 'Admin Super':
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)

            cursor.execute('SELECT * FROM users WHERE id=%s', (id))
            data = cursor.fetchone()
            if request.method == 'POST':
                id = request.form['id']
                nama = request.form['nama']
                username = request.form['username']
                password = request.form['password']
                email = request.form['email']
                level = request.form['level']

                sql = "UPDATE users SET nama=%s, username=%s, password=%s, email=%s, level=%s WHERE id=%s"
                val = (nama, username, generate_password_hash(
                    password), email, level, id)
                cursor.execute(sql, val)
                conn.commit()
                flash('Data berhasil diubah', 'success')
            return render_template('user_edit.html', data=data)
        else:
            return render_template('404.html')
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


# fungsi untuk menghapus data
@app.route('/hapus/<id>', methods=['GET', 'POST'])
def user_delete(id):
    if 'loggedin' in session:
        if session['level'] == 'Admin Super':
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)

            cursor.execute('DELETE FROM users WHERE id=%s', (id))
            conn.commit()
            return redirect(url_for('user_view'))
        else:
            return render_template('404.html')

    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))

# Mengambil inputan data


@app.route('/get_input', methods=['POST'])
def get_input_values():
    val = request.form['file']


# function untuk clustering data tanah
def clusteringTanah(conn, cursor, data_frame):

    df = data_frame

    # Menghapus Index ke-0
    df = df.drop([0, 1])
    # Menghapus Index
    df = df.reset_index(drop=True)

    # Membuat nama kolom
    df.columns = ['kode wilayah', 'Kode Aset', 'no sertif', 'jenis sertif', 'Status Tanah', 'pemilik sebelum',
                  'pemilik sekarang', 'alamat', 'desa', 'luas', 'cara perolehan', 'harga perolehan', 'tanggal perolehan',
                  'harga taksir pasar', 'tahun taksir pasar', 'harga taksir njop', 'tahun taksir njop',
                  'penggunaan', 'kategori', 'bidang', 'lokasi_arsip', 'fasum', 'produktif', 'sengketa',
                  'nib', 'tanggal_tempo', 'keterangan',
                  'latitude', 'longitude']

    # Merubah missing value menjadi 0
    def_status = 0
    df.fillna(def_status, inplace=True)
    # SELECTION DATA
    df = df.loc[:, ["Kode Aset", "Status Tanah",
                    "penggunaan", "sengketa"]]
    # Memberi bobot ke atribut Penggunaan
    for index, row in df.iterrows():
        if row['penggunaan'] == 'Belum termanfaatkan':
            df.loc[index, 'Penggunaan Aset'] = 2
        else:
            df.loc[index, 'Penggunaan Aset'] = 1
    # Memberi bobot ke atribut Sengketa
    for index, row in df.iterrows():
        if row['sengketa'] == 'Tidak':
            df.loc[index, 'Sengketa Aset'] = 1
        else:
            df.loc[index, 'Sengketa Aset'] = 3
    # Membuat data training
    X = df[['Penggunaan Aset', 'Sengketa Aset']].values
    # FEATURE SCALLING
    scaler = StandardScaler()
    X = scaler.fit_transform(X)
    y_cluster = model1.predict(X)
    df['Cluster'] = y_cluster
    # Membuat kolom Hasil
    df['Hasil'] = df['Cluster'].replace(
        [0, 1, 2], ['Produktif', 'Tidak Produktif', 'Tidak Diketahui'])
    # Membuat kolom Keterangan
    df['Keterangan'] = df['Cluster'].replace([0, 1, 2], [
                                             'Telah Dimanfaatkan', 'Belum Termanfaatkan Oleh Pihak PWM', 'Belum Diverifikasi'])
    df = df.loc[:, ["Kode Aset", "Status Tanah", "Hasil", "Keterangan"]]

    # memasukan hasil ke variabel result
    result = pd.concat([df], axis=1)

    # Menampilkan grafik
    clust0 = df.apply(
        lambda x: True if x['Hasil'] == 'Produktif' else False, axis=1)
    clust1 = df.apply(
        lambda x: True if x['Hasil'] == 'Tidak Produktif' else False, axis=1)
    clust2 = df.apply(
        lambda x: True if x['Hasil'] == 'Tidak Diketahui' else False, axis=1)

    jumlah0 = len(clust0[clust0 == True].index)
    jumlah1 = len(clust1[clust1 == True].index)
    jumlah2 = len(clust2[clust2 == True].index)

    Data = {'Chart': [jumlah0, jumlah1, jumlah2]}
    data = pd.DataFrame(Data, columns=['Chart'], index=[
        'Produktif', 'Tidak Produktif', 'Tidak Diketahui'])
    data.plot.bar(y='Chart')

    plt.savefig('static/img/chartTanah.png', bbox_inches="tight")

    # dataframe to list for insertion
    df_list = result.values.tolist()

    # truncate table for insertion
    cursor.execute("TRUNCATE TABLE tanah")
    conn.commit()

    # insertion clustering result
    sql = "INSERT INTO tanah (kode_aset, status_tanah, hasil, keterangan) VALUES (%s, %s, %s, %s)"
    for row in df_list:
        val = (row[0], row[1], row[2], row[3])
        cursor.execute(sql, val)
    conn.commit()

    return result


# function untuk clustering data bangunan
def clusteringBangunan(conn, cursor, data_frame):
    df = data_frame

    # Preprocessing Data
    df = df.drop([0, 1])

    df = df.reset_index(drop=True)
    # Membuat nama kolom
    df.columns = ['bidang', 'kategori', 'kode wilayah', 'Kode Aset', 'Nama Aset', 'pengelola',
                  'luas', 'harga', 'tanggal dibangun', 'harga taksir', 'tahun taksir', 'keterangan', 'alamat']

    def_status = 0
    df.fillna(def_status, inplace=True)

    # Selection Data
    df = df.loc[:, ["Kode Aset", "Nama Aset", "luas"]]

    # Transformasi Data
    for index, row in df.iterrows():
        if row['Nama Aset'] == 0:
            df.loc[index, 'Penggunaan'] = 2  # tidak produktif
        else:
            df.loc[index, 'Penggunaan'] = 1  # Produkfif

    for index, row in df.iterrows():
        if row['luas'] >= 100:
            df.loc[index, 'Luas'] = 1  # Produktif
        else:
            df.loc[index, 'Luas'] = 2  # Tidak Produktif

    X = df[['Penggunaan', 'Luas']].values

    # KMEANS
    scaler = StandardScaler()
    X = scaler.fit_transform(X)

    y_cluster = model2.predict(X)
    df['Cluster'] = y_cluster

    df['Hasil'] = df['Cluster'].replace(
        [0, 1, 2], ['Produktif', 'Tidak Produktif', 'Tidak Diketahui', ])
    df['Keterangan'] = df['Cluster'].replace([0, 1, 2], [
                                             'Telah Dimanfaatkan', 'Belum Termanfaatkan Oleh Pihak PWM', 'Belum Diverifikasi', ])

    df = df.loc[:, ["Kode Aset", "Nama Aset", "Hasil", "Keterangan"]]

    result = pd.concat([df], axis=1)

    # Menampilkan grafik
    clust0 = df.apply(
        lambda x: True if x['Hasil'] == 'Produktif' else False, axis=1)
    clust1 = df.apply(
        lambda x: True if x['Hasil'] == 'Tidak Produktif' else False, axis=1)
    clust2 = df.apply(
        lambda x: True if x['Hasil'] == 'Tidak Diketahui' else False, axis=1)

    jumlah0 = len(clust0[clust0 == True].index)
    jumlah1 = len(clust1[clust1 == True].index)
    jumlah2 = len(clust2[clust2 == True].index)

    Data = {'Chart': [jumlah0, jumlah1, jumlah2]}
    data = pd.DataFrame(Data, columns=['Chart'], index=[
        'Produktif', 'Tidak Produktif', 'Tidak Diketahui'])
    data.plot.bar(y='Chart')

    plt.savefig('static/img/chartBangunan.png', bbox_inches="tight")

    # dataframe to list for insertion
    df_list = result.values.tolist()

    # truncate table for insertion
    cursor.execute("TRUNCATE TABLE bangunan")
    conn.commit()

    # insertion clustering result
    sql = "INSERT INTO bangunan (kode_aset, nama, hasil, keterangan) VALUES (%s, %s, %s, %s)"
    for row in df_list:
        val = (row[0], row[1], row[2], row[3])
        cursor.execute(sql, val)
    conn.commit()

    return result


# function untuk clustering data kendaraan
def clusteringKendaraan(conn, cursor, data_frame):

    df = data_frame

    # Menghapus Index ke 0
    df = df.drop([0, 1])

    # Menghapus Index
    df = df.reset_index(drop=True)

    df.columns = ['kode wilayah', 'Kode Aset', 'Kendaraan', 'pemilik', 'nopol', 'warna', 'perolehan', 'harga beli',
                  'tanggal beli', 'harga taksir', 'tahun taksir', 'pajak 1 tahunan', 'pajak 5 tahunan', 'keterangan']

    # Merubah Missing Value menjadi 0
    def_status = 0
    df.fillna(def_status, inplace=True)

    # Selection Data
    df = df.loc[:, ["Kode Aset", "Kendaraan", "tanggal beli", "harga taksir"]]

    # TRANSFORMASI DATA
    # MENGUBAH TYPE DATA TANGGAL BELI DARI OBJECT MENJADI DATETIME
    df['tanggal beli'] = pd.to_datetime(df['tanggal beli'])

    # MENGHITUNG USIA KENDARAAN
    today = pd.to_datetime('today')
    df['usia kendaraan'] = today.year - df['tanggal beli'].dt.year

    for index, row in df.iterrows():
        if row['usia kendaraan'] < 20:
            df.loc[index, 'Usia Kendaraan'] = 1  # Produktif
        else:
            df.loc[index, 'Usia Kendaraan'] = 2  # Tidak Produktif

    for index, row in df.iterrows():
        if row['harga taksir'] > 0:
            df.loc[index, 'Harga'] = 1  # Produktif
        else:
            df.loc[index, 'Harga'] = 2  # Tidak Produktif

    X = df[['Usia Kendaraan', 'Harga']].values

    # Feature Scalling
    scaler = StandardScaler()
    X = scaler.fit_transform(X)

    # KMEANS
    y_cluster = model3.predict(X)
    df['Cluster'] = y_cluster

    df['Hasil'] = df['Cluster'].replace(
        [0, 1, 2], ['Produktif', 'Tidak Produktif', 'Tidak Diketahui'])
    df['Keterangan'] = df['Cluster'].replace([0, 1, 2], [
                                             'Telah Dimanfaatkan', 'Usia Kendaraan lebih dari 20 tahun', 'Harga Taksir = 0'])

    df = df.loc[:, ["Kode Aset", "Kendaraan", "Hasil", "Keterangan"]]

    # memasukan hasil ke variabel result
    result = pd.concat([df], axis=1)

    # Menampilkan grafik
    clust0 = df.apply(
        lambda x: True if x['Hasil'] == 'Produktif' else False, axis=1)
    clust1 = df.apply(
        lambda x: True if x['Hasil'] == 'Tidak Produktif' else False, axis=1)
    clust2 = df.apply(
        lambda x: True if x['Hasil'] == 'Tidak Diketahui' else False, axis=1)

    jumlah0 = len(clust0[clust0 == True].index)
    jumlah1 = len(clust1[clust1 == True].index)
    jumlah2 = len(clust2[clust2 == True].index)

    Data = {'Chart': [jumlah0, jumlah1, jumlah2]}
    data = pd.DataFrame(Data, columns=['Chart'], index=[
        'Produktif', 'Tidak Produktif', 'Tidak Diketahui'])
    data.plot.bar(y='Chart')

    plt.savefig('static/img/chartKendaraan.png', bbox_inches="tight")

    # dataframe to list for insertion
    df_list = result.values.tolist()

    # truncate table for insertion
    cursor.execute("TRUNCATE TABLE kendaraan")
    conn.commit()

    # insertion clustering result
    sql = "INSERT INTO kendaraan (kode_aset, kendaraan, hasil, keterangan) VALUES (%s, %s, %s, %s)"
    for row in df_list:
        val = (row[0], row[1], row[2], row[3])
        cursor.execute(sql, val)
    conn.commit()

    return result


# function untuk clustering data barang
def clusteringBarang(conn, cursor, data_frame):
    df = data_frame

    # Menghapus Index ke-0
    df = df.drop([0, 1])

    # Menghapus Index
    df = df.reset_index(drop=True)

    # Membuat kolom
    df.columns = ['Kode Aset', 'kategori', 'kelompok', 'Jenis', 'kondisi baik',
                  'kondisi rusak ringan', 'kondisi rusak berat', 'kondisi hilang', 'jumlah']

    # Mengubah Missing Value ke 0
    def_status = 0
    df.fillna(def_status, inplace=True)

    # Selection Data
    df = df.loc[:, ["Kode Aset", "Jenis", "kondisi baik",
                    "kondisi rusak ringan", "kondisi rusak berat", "kondisi hilang"]]

    # Transformasi Data
    for index, row in df.iterrows():
        if row['kondisi baik'] > 0:
            df.loc[index, 'Baik'] = 1  # Produktif
        else:
            df.loc[index, 'Baik'] = 2  # Tidak Produktif

    for index, row in df.iterrows():
        if row['kondisi rusak ringan'] >= 0:
            df.loc[index, 'Rusak Ringan'] = 1  # Produktif
        else:
            df.loc[index, 'Rusak Ringan'] = 2  # Tidak Produktif

    for index, row in df.iterrows():
        if row['kondisi rusak berat'] > 0:
            df.loc[index, 'Rusak Berat'] = 2  # Tidak Produktif
        else:
            df.loc[index, 'Rusak Berat'] = 1  # Produktif

    for index, row in df.iterrows():
        if row['kondisi hilang'] > 0:
            df.loc[index, 'Kondisi Hilang'] = 2  # Tidak Produktif
        else:
            df.loc[index, 'Kondisi Hilang'] = 1  # Produktif

    # K-MEANS PROSES
    X = df[['Baik', 'Rusak Ringan',
            'Rusak Berat', 'Kondisi Hilang']].values

    scaler = StandardScaler()
    X = scaler.fit_transform(X)

    y_cluster = model4.predict(X)
    df['Cluster'] = y_cluster

    df['Hasil'] = df['Cluster'].replace(
        [0, 1, 2], ['Produktif', 'Tidak Produktif', 'Tidak Diketahui'])
    df['Keterangan'] = df['Cluster'].replace([0, 1, 2], [
                                             'Termanfaatkan', 'Terdapat barang dengan kondisi rusak berat atau hilang', 'Jumlah barang dengan kondisi baik = 0'])

    df = df.loc[:, ["Kode Aset", "Jenis", "Hasil", "Keterangan"]]

    result = pd.concat([df], axis=1)

    # Menampilkan grafik
    clust0 = df.apply(
        lambda x: True if x['Hasil'] == 'Produktif' else False, axis=1)
    clust1 = df.apply(
        lambda x: True if x['Hasil'] == 'Tidak Produktif' else False, axis=1)
    clust2 = df.apply(
        lambda x: True if x['Hasil'] == 'Tidak Diketahui' else False, axis=1)

    jumlah0 = len(clust0[clust0 == True].index)
    jumlah1 = len(clust1[clust1 == True].index)
    jumlah2 = len(clust2[clust2 == True].index)

    Data = {'Chart': [jumlah0, jumlah1, jumlah2]}
    data = pd.DataFrame(Data, columns=['Chart'], index=[
        'Produktif', 'Tidak Produktif', 'Tidak Diketahui'])
    data.plot.bar(y='Chart')

    plt.savefig('static/img/chartBarang.png', bbox_inches="tight")

    # dataframe to list for insertion
    df_list = result.values.tolist()

    # truncate table for insertion
    cursor.execute("TRUNCATE TABLE barang")
    conn.commit()

    # insertion clustering result
    sql = "INSERT INTO barang (kode_aset, jenis, hasil, keterangan) VALUES (%s, %s, %s, %s)"
    for row in df_list:
        val = (row[0], row[1], row[2], row[3])
        cursor.execute(sql, val)
    conn.commit()

    return result


@app.route("/klasifikasi", methods=["POST", "GET"])
def cluster():
    if 'loggedin' in session:
        if session['level'] == 'Admin Super':

            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)

            if request.method == 'GET':
                return render_template('clustering.html')

            elif request.method == 'POST':
                excel_file = request.files["file"]
                df = pd.read_excel(excel_file)
                dataset_type = request.form["datasetType"]
                # Data Mining Process
                # Preprocessing
                if dataset_type == 'Tanah':
                    result = clusteringTanah(conn, cursor, df)

                elif dataset_type == 'Bangunan':
                    result = clusteringBangunan(conn, cursor, df)

                elif dataset_type == 'Kendaraan':
                    result = clusteringKendaraan(conn, cursor, df)

                elif dataset_type == 'Barang':
                    result = clusteringBarang(conn, cursor, df)

                else:
                    return render_template('404.html')

                hasil = result.to_html(
                    classes='table', justify='center').replace("<thead>", "<thead class='thead-primary table-hover'>")

                # menyisipkan data ke hasil_cluster
                return render_template('hasil_cluster.html', hasil=hasil)
            else:
                return render_template('clustering.html')
        else:
            return render_template('404.html')
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


@app.route('/view-klasifikasi')
def view():
    if 'loggedin' in session:
        return render_template('view-clustering.html')
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


@app.route('/view-klasifikasi-tanah')
def view_tanah():
    if 'loggedin' in session:
        # make connection to mysql
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        # Eksekusi query SELECT
        cursor.execute("SELECT * FROM tanah")
        # Mengambil hasil eksekusi query dan menyimpannya dalam variabel data
        data = cursor.fetchall()

        # menyisipkan data ke tampil_user.html
        return render_template('view-tanah.html', data=data)
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


@app.route('/view-klasifikasi-bangunan')
def view_bangunan():
    if 'loggedin' in session:
        # make connection to mysql
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        # Eksekusi query SELECT
        cursor.execute("SELECT * FROM bangunan")
        # Mengambil hasil eksekusi query dan menyimpannya dalam variabel data
        data = cursor.fetchall()

        # menyisipkan data ke tampil_user.html
        return render_template('view-bangunan.html', data=data)
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


@app.route('/view-klasifikasi-kendaraan')
def view_kendaraan():
    if 'loggedin' in session:
        # make connection to mysql
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        # Eksekusi query SELECT
        cursor.execute("SELECT * FROM kendaraan")
        # Mengambil hasil eksekusi query dan menyimpannya dalam variabel data
        data = cursor.fetchall()

        # menyisipkan data ke tampil_user.html
        return render_template('view-kendaraan.html', data=data)
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


@app.route('/view-klasifikasi-barang')
def view_barang():
    if 'loggedin' in session:
        # make connection to mysql

        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        # Eksekusi query SELECT
        cursor.execute("SELECT * FROM barang")
        # Mengambil hasil eksekusi query dan menyimpannya dalam variabel data
        data = cursor.fetchall()

        # menyisipkan data ke tampil_user.html
        return render_template('view-barang.html', data=data)
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))


@app.route('/view-chart-hasil')
def view_chart():
    if 'loggedin' in session:
        return render_template('chart.html')
    flash('Silahkan Login Dahulu', 'danger')
    return redirect(url_for('login'))

# Logout


@app.route('/logout')
def logout():
    session.clear()
    return render_template('login.html')


if __name__ == "__main__":
    app.run(debug=True)
