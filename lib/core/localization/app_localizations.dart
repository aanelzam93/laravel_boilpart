import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // Common
      'app_name': 'Flutter Boilerplate',
      'welcome': 'Welcome',
      'hello': 'Hello',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'cancel': 'Cancel',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'search': 'Search',
      'filter': 'Filter',
      'sort': 'Sort',
      'refresh': 'Refresh',
      'retry': 'Retry',
      'back': 'Back',
      'next': 'Next',
      'submit': 'Submit',
      'confirm': 'Confirm',
      
      // Auth
      'login': 'Login',
      'logout': 'Logout',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Forgot Password?',
      'remember_me': 'Remember Me',
      'dont_have_account': "Don't have an account?",
      'already_have_account': 'Already have an account?',
      
      // Home
      'home': 'Home',
      'profile': 'Profile',
      'settings': 'Settings',
      'notifications': 'Notifications',
      
      // Settings
      'language': 'Language',
      'theme': 'Theme',
      'dark_mode': 'Dark Mode',
      'light_mode': 'Light Mode',
      'system_mode': 'System Mode',
      'about': 'About',
      'version': 'Version',
      'privacy_policy': 'Privacy Policy',
      'terms_of_service': 'Terms of Service',
      
      // Messages
      'no_data': 'No data available',
      'no_internet': 'No internet connection',
      'something_went_wrong': 'Something went wrong',
      'try_again': 'Please try again',
      'coming_soon': 'Coming Soon',
      
      // Validation
      'field_required': 'This field is required',
      'invalid_email': 'Invalid email address',
      'password_too_short': 'Password must be at least 6 characters',
      'passwords_dont_match': 'Passwords do not match',
    },
    'id': {
      // Common
      'app_name': 'Flutter Boilerplate',
      'welcome': 'Selamat Datang',
      'hello': 'Halo',
      'loading': 'Memuat...',
      'error': 'Kesalahan',
      'success': 'Berhasil',
      'cancel': 'Batal',
      'ok': 'OK',
      'yes': 'Ya',
      'no': 'Tidak',
      'save': 'Simpan',
      'delete': 'Hapus',
      'edit': 'Edit',
      'search': 'Cari',
      'filter': 'Filter',
      'sort': 'Urutkan',
      'refresh': 'Muat Ulang',
      'retry': 'Coba Lagi',
      'back': 'Kembali',
      'next': 'Selanjutnya',
      'submit': 'Kirim',
      'confirm': 'Konfirmasi',
      
      // Auth
      'login': 'Masuk',
      'logout': 'Keluar',
      'register': 'Daftar',
      'email': 'Email',
      'password': 'Kata Sandi',
      'forgot_password': 'Lupa Kata Sandi?',
      'remember_me': 'Ingat Saya',
      'dont_have_account': 'Belum punya akun?',
      'already_have_account': 'Sudah punya akun?',
      
      // Home
      'home': 'Beranda',
      'profile': 'Profil',
      'settings': 'Pengaturan',
      'notifications': 'Notifikasi',
      
      // Settings
      'language': 'Bahasa',
      'theme': 'Tema',
      'dark_mode': 'Mode Gelap',
      'light_mode': 'Mode Terang',
      'system_mode': 'Mode Sistem',
      'about': 'Tentang',
      'version': 'Versi',
      'privacy_policy': 'Kebijakan Privasi',
      'terms_of_service': 'Syarat Layanan',
      
      // Messages
      'no_data': 'Tidak ada data',
      'no_internet': 'Tidak ada koneksi internet',
      'something_went_wrong': 'Terjadi kesalahan',
      'try_again': 'Silakan coba lagi',
      'coming_soon': 'Segera Hadir',
      
      // Validation
      'field_required': 'Kolom ini wajib diisi',
      'invalid_email': 'Alamat email tidak valid',
      'password_too_short': 'Kata sandi minimal 6 karakter',
      'passwords_dont_match': 'Kata sandi tidak cocok',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Getters for easy access
  String get appName => translate('app_name');
  String get welcome => translate('welcome');
  String get hello => translate('hello');
  String get loading => translate('loading');
  String get error => translate('error');
  String get success => translate('success');
  String get cancel => translate('cancel');
  String get ok => translate('ok');
  String get yes => translate('yes');
  String get no => translate('no');
  String get save => translate('save');
  String get delete => translate('delete');
  String get edit => translate('edit');
  String get search => translate('search');
  String get filter => translate('filter');
  String get sort => translate('sort');
  String get refresh => translate('refresh');
  String get retry => translate('retry');
  String get back => translate('back');
  String get next => translate('next');
  String get submit => translate('submit');
  String get confirm => translate('confirm');
  
  String get login => translate('login');
  String get logout => translate('logout');
  String get register => translate('register');
  String get email => translate('email');
  String get password => translate('password');
  String get forgotPassword => translate('forgot_password');
  String get rememberMe => translate('remember_me');
  String get dontHaveAccount => translate('dont_have_account');
  String get alreadyHaveAccount => translate('already_have_account');
  
  String get home => translate('home');
  String get profile => translate('profile');
  String get settings => translate('settings');
  String get notifications => translate('notifications');
  
  String get language => translate('language');
  String get theme => translate('theme');
  String get darkMode => translate('dark_mode');
  String get lightMode => translate('light_mode');
  String get systemMode => translate('system_mode');
  String get about => translate('about');
  String get version => translate('version');
  String get privacyPolicy => translate('privacy_policy');
  String get termsOfService => translate('terms_of_service');
  
  String get noData => translate('no_data');
  String get noInternet => translate('no_internet');
  String get somethingWentWrong => translate('something_went_wrong');
  String get tryAgain => translate('try_again');
  String get comingSoon => translate('coming_soon');
  
  String get fieldRequired => translate('field_required');
  String get invalidEmail => translate('invalid_email');
  String get passwordTooShort => translate('password_too_short');
  String get passwordsDontMatch => translate('passwords_dont_match');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'id'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
