# Final Project - InvBase

## 📌 Introduction
Final Project InvBase adalah aplikasi manajemen inventaris berbasis **Node.js** dan **Flutter**.  
Aplikasi ini memiliki **backend dengan Express.js** untuk mengelola data pengguna, kategori, dan produk, serta **frontend menggunakan Flutter** untuk tampilan dan interaksi pengguna.

## 🎯 Features

### 🔑 User Authentication (JWT)
- Registrasi dan login pengguna.
- Menggunakan JSON Web Token (JWT) untuk autentikasi dan sesi pengguna.

### 📂 Category Management
- CRUD kategori (tambah, lihat, ubah, hapus).
- Setiap produk terhubung dengan kategori tertentu.

### 📦 Product Management
- CRUD produk (tambah, lihat, ubah, hapus).
- Produk memiliki relasi dengan kategori dan pengguna.

### 📤 File Upload (Multer)
- Pengguna dapat mengunggah gambar profil.
- Menggunakan middleware Multer untuk menangani penyimpanan file.

### 🛡 Middleware Security
- Middleware untuk verifikasi token JWT sebelum mengakses endpoint tertentu.
- Proteksi endpoint terhadap pengguna yang tidak terautentikasi.

### 🔗 Database Relationship
- Menggunakan Sequelize ORM dengan hubungan **1 to Many** antara User, Category, dan Product.
- Penyimpanan timestamp otomatis saat data diubah atau dibuat.

### 🎨 Flutter Frontend
- **Tampilan Modern**: Menggunakan **Flutter** untuk pengalaman pengguna yang responsif dan dinamis.
- **Koneksi API**: Terhubung dengan backend melalui **REST API**.
- **State Management**: Menggunakan **Provider.
- **Authentication UI**: Halaman **Login & Register** dengan validasi.
- **Product & Category Management UI**: Tampilan daftar, detail, serta form untuk menambah dan mengubah data.

