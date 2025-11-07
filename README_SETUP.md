# 🚀 BoilPart Flutter - Setup Guide

## 📋 Prerequisites

- Flutter SDK: **3.29.3** or higher
- Dart SDK: **3.0.0** or higher
- IDE: VS Code, Android Studio, or IntelliJ IDEA

## 🛠️ Installation Steps

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Verify Flutter Installation

```bash
flutter doctor
```

### 3. Run the App

```bash
flutter run
```

## 📱 Features Implemented

### ✅ Modular Architecture
- Clean separation using `flutter_modular`
- Modules: Auth, Home, Profile, CRUD
- Dependency injection with GetIt

### ✅ Environment Configuration
- `.env` file for configuration
- Easy API base URL setup
- Development/Production modes

### ✅ Authentication Module
- Login page with dummy validation
- Any username/password combination works
- Session persistence with SharedPreferences
- Auto-redirect after login

### ✅ Home Module
- Bottom Navigation Bar with 3 tabs
- Dashboard with welcome message
- Feature showcase cards
- Language switcher

### ✅ CRUD Module
- Complete Item Management
- Add, Edit, Delete operations
- Local storage (in-memory)
- Clean UI with Material 3

### ✅ Profile Module
- User profile display (dummy data)
- Logout functionality
- Returns to login page after logout

### ✅ Multi-Language Support
- 🇮🇩 Bahasa Indonesia
- 🇬🇧 English
- Persistent language selection
- Easy to add more languages

### ✅ Modern UI/UX
- Material 3 Design
- Google Fonts (Poppins)
- Light & Dark theme support
- Teal/Blue color scheme
- Smooth animations

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   ├── di/
│   │   └── injection.dart
│   ├── env/
│   │   └── env_config.dart
│   ├── localization/
│   │   ├── app_localizations.dart
│   │   └── language_cubit.dart
│   ├── network/
│   │   └── dio_client.dart
│   ├── router/
│   │   ├── app_router.dart
│   │   └── route_names.dart
│   ├── storage/
│   │   └── local_storage.dart
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   └── utils/
│       ├── logger.dart
│       └── validators.dart
├── data/
│   ├── models/
│   │   ├── item_model.dart
│   │   └── user_model.dart
│   └── repositories/
│       └── item_repository.dart
├── modules/
│   ├── auth/
│   │   ├── auth_controller.dart
│   │   ├── auth_module.dart
│   │   └── login_page.dart
│   ├── home/
│   │   ├── home_dashboard_page.dart
│   │   ├── home_module.dart
│   │   └── home_page.dart
│   ├── profile/
│   │   ├── profile_module.dart
│   │   └── profile_page.dart
│   └── crud/
│       ├── crud_controller.dart
│       ├── crud_module.dart
│       └── crud_page.dart
├── shared/
│   └── widgets/
│       ├── custom_button.dart
│       ├── custom_text_field.dart
│       ├── empty_widget.dart
│       ├── error_widget.dart
│       └── loading_widget.dart
├── app_module.dart
├── app_widget.dart
└── main.dart
```

## 🔧 Configuration

### Environment Variables (.env)

```env
API_BASE_URL=https://api.example.com
APP_MODE=development
APP_NAME=BoilPart Flutter
```

### Adding New API Endpoints

1. Update `API_BASE_URL` in `.env`
2. Use `EnvConfig.apiBaseUrl` in your code
3. Dio client is pre-configured in `core/network/dio_client.dart`

## 🌍 Adding New Languages

1. Open `lib/core/localization/app_localizations.dart`
2. Add translations to `_localizedValues` map:

```dart
'es': {
  'welcome': 'Bienvenido',
  'login': 'Iniciar sesión',
  // ... more translations
}
```

3. Add locale to supported locales in `app_widget.dart`:

```dart
supportedLocales: const [
  Locale('en', ''),
  Locale('id', ''),
  Locale('es', ''), // Spanish
],
```

## 🎨 Customizing Theme

### Colors
Edit `lib/core/theme/app_colors.dart`:

```dart
static const Color primary = Color(0xFF2196F3); // Change to your color
```

### Fonts
The app uses Google Fonts (Poppins). To change:

```dart
// In app_theme.dart
textTheme: GoogleFonts.robotoTextTheme(), // Change font
```

## 📝 Usage Examples

### Login
- Username: any text
- Password: any text
- Both fields must not be empty

### CRUD Operations
1. Navigate to "Items" tab
2. Click "Tambah Item" button
3. Fill name and description
4. Edit or delete items using icons

### Language Switch
1. Click language icon in app bar
2. Select Indonesian or English
3. Language persists across app restarts

## 🧪 Testing

```bash
# Run tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📦 Building for Production

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🐛 Troubleshooting

### Issue: Dependencies not resolving
```bash
flutter clean
flutter pub get
```

### Issue: Build errors
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: Font not loading
- Check internet connection (Google Fonts downloads on first use)
- Fonts are cached after first download

## 📚 Key Dependencies

- **flutter_modular**: ^6.3.4 - Modular architecture
- **flutter_bloc**: ^8.1.3 - State management
- **flutter_dotenv**: ^5.1.0 - Environment configuration
- **google_fonts**: ^6.1.0 - Typography
- **dio**: ^5.4.0 - HTTP client
- **shared_preferences**: ^2.2.2 - Local storage

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

Created with ❤️ for Flutter developers

---

**Happy Coding! 🚀**
