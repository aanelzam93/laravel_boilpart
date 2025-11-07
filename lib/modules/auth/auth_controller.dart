import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String username;
  AuthSuccess(this.username);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoggedOut extends AuthState {}

// Cubit
class AuthController extends Cubit<AuthState> {
  final SharedPreferences prefs;

  AuthController(this.prefs) : super(AuthInitial()) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final username = prefs.getString('username');
    
    if (isLoggedIn && username != null) {
      emit(AuthSuccess(username));
    } else {
      emit(AuthLoggedOut());
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Dummy validation - accept any non-empty username and password
    if (username.isNotEmpty && password.isNotEmpty) {
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
      emit(AuthSuccess(username));
    } else {
      emit(AuthError('Username dan password tidak boleh kosong'));
    }
  }

  Future<void> logout() async {
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');
    emit(AuthLoggedOut());
  }
}
