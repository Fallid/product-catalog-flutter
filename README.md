# Product Catalog App 🛍️
## Deskripsi Aplikasi

Product Catalog adalah aplikasi mobile yang memungkinkan pengguna untuk:
- Menjelajahi katalog produk dari FakeStore API
- Mencari produk berdasarkan nama
- Melihat detail lengkap produk
- Menambahkan produk ke keranjang belanja
- Mengelola keranjang belanja 

Aplikasi ini dibangun menggunakan **Clean Architecture** dengan pendekatan **Feature-First** untuk memastikan kode yang terstruktur, mudah di-maintain, dan scalable. Selain itu juga, Aplikasi ini dapat menyesuaikan ukuran terhadap layar pengguna.

## Fitur

#### 1. **Product List**

#### 2. **Product Detail**

#### 3. **Search Feature**

#### 4. **Shopping Cart**

#### 5. **Additional Features**

## Package yang Digunakan

### Core Dependencies
| Package | Version |
|---------|---------|
| **flutter_riverpod** | ^3.0.3 | 
| **dio** | ^5.9.0 | 
| **hive** | ^2.2.3 | 
| **hive_flutter** | ^1.1.0 | 
| **path_provider** | ^2.1.5 | 

### UI & UX
| Package | Version | 
|---------|---------|
| **flutter_screenutil** | ^5.9.3 | 
| **responsive_framework** | ^1.5.1 | 
| **cached_network_image** | ^3.4.1 | 
| **skeletonizer** | ^1.4.3 | 
| **card_loading** | ^0.3.2 | 

### Development Tools
| Package | Version | 
|---------|---------|
| **flutter_lints** | ^5.0.0 | 
| **custom_lint** | ^0.8.0 | 
| **riverpod_lint** | ^3.0.3 | 
| **build_runner** | ^2.4.13 | 

### Other
| Package | Version | 
|---------|---------|
| **cupertino_icons** | ^1.0.8 | 
| **dotenv** | ^4.2.0 | 


## Petunjuk Menjalankan Aplikasi

### Prerequisites
Pastikan Anda sudah menginstall:
- **Flutter Version**: 3.29.2 atau lebih tinggi
- **Dart Version**: 3.7.2 atau lebih tinggi
- **Android Studio / VS Code** dengan Flutter extension
- **Android Emulator** atau **Physical Device**

### Langkah-langkah Instalasi

1. **Clone Repository**
   ```bash
   git clone https://github.com/Fallid/product-catalog-flutter.git
   cd product_catalog
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Cek Flutter Doctor**
   ```bash
   flutter doctor
   ```
   Pastikan tidak ada issue critical.

4. **Run di Debug Mode**
   ```bash
   flutter run
   ```

5. **Build APK (Optional)**
   ```bash
   # Debug APK
   flutter build apk
   
   # Release APK
   flutter build apk --release
   ```

6. **Build untuk iOS (macOS only)**
   ```bash
   flutter build ios --release
   ```

### Device Setup

**Android:**
- Minimum SDK: 21 (Android 5.0 Lollipop)
- Target SDK: Latest

**iOS:**
- Minimum iOS Version: 12.0

## License
[MIT](./LICENSE).

## 👨‍💻 Developer

Created with ❤️ by **Fallid**


