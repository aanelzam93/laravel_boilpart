# 🚀 BoilPart – Flutter Modular Boilerplate App

BoilPart adalah template aplikasi Flutter modern dan modular yang dirancang untuk pengembangan cepat dengan struktur bersih, environment configuration, dan halaman dasar seperti **Login**, **Home**, **Profile**, serta **CRUD Page**.

---

## 🧩 Fitur Utama

- ✅ **Arsitektur Modular**
  - Setiap fitur dipisahkan dalam module (`auth`, `home`, `profile`, `crud`)
  - Menggunakan `flutter_modular` atau `get_it` untuk dependency injection
- ⚙️ **Environment Configuration**
  - Menggunakan `flutter_dotenv` untuk membaca file `.env`
  - Memudahkan konfigurasi `API_BASE_URL`, `APP_MODE`, dll
- 🔐 **Halaman Login**
  - UI clean dan modern
  - Login bisa dilakukan tanpa validasi API (username & password asal)
  - Setelah login, langsung diarahkan ke halaman Home
- 🏠 **Halaman Home**
  - Menampilkan sapaan pengguna
  - Navigasi ke halaman Profile dan CRUD
  - Menggunakan `BottomNavigationBar` atau `Drawer`
- 👤 **Halaman Profile**
  - Menampilkan data user dummy
  - Tombol Logout yang kembali ke halaman Login
- 📄 **Halaman CRUD (Item Management)**
  - Fitur: List, Tambah, Edit, Hapus item
  - Data disimpan sementara secara lokal (belum terhubung API)
  - Model dasar: `Item(id, name, description)`
- 🎨 **UI/UX Clean**
  - Desain modern berbasis **Material 3**
  - Menggunakan **Google Fonts (Poppins)**
  - Warna dominan: putih dan aksen teal/biru muda

---

## 📁 Struktur Folder

```bash
lib/
│
├── core/
│   ├── theme/
│   ├── utils/
│   ├── constants/
│   └── env/
│
├── data/
│   ├── models/
│   └── repositories/
│
├── modules/
│   ├── auth/
│   │   ├── login_page.dart
│   │   ├── auth_controller.dart
│   │   └── auth_module.dart
│   │
│   ├── home/
│   │   ├── home_page.dart
│   │   ├── home_controller.dart
│   │   └── home_module.dart
│   │
│   ├── profile/
│   │   ├── profile_page.dart
│   │   ├── profile_controller.dart
│   │   └── profile_module.dart
│   │
│   └── crud/
│       ├── crud_page.dart
│       ├── crud_controller.dart
│       └── crud_module.dart
│
├── app_module.dart
├── app_widget.dart
└── main.dart
# laravel_boilpart
