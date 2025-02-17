# Final Project - InvBase

## 📌 Introduction
InvBase adalah aplikasi manajemen inventaris berbasis **Express.js** dan **Flutter**.  
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
- **State Management**: Menggunakan **Provider.
- **Authentication UI**: Halaman **Login & Register** dengan validasi.
- **Product & Category Management UI**: Tampilan daftar, detail, serta form untuk menambah dan mengubah data.

