import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../data/models/user_model.dart';
import '../../data/services/auth_service.dart';

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  final String token;

  AuthSuccess(this.user, this.token);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLoggedOut extends AuthState {}

// Cubit
class AuthController extends Cubit<AuthState> {
  final SharedPreferences prefs;
  final AuthService authService;

  AuthController(this.prefs, this.authService) : super(AuthInitial()) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;
    final token = prefs.getString(AppConstants.keyToken);
    final userDataJson = prefs.getString(AppConstants.keyUserData);

    if (isLoggedIn && token != null && userDataJson != null) {
      try {
        final userData = json.decode(userDataJson);
        final user = UserModel.fromJson(userData);
        emit(AuthSuccess(user, token));
      } catch (e) {
        emit(AuthLoggedOut());
      }
    } else {
      emit(AuthLoggedOut());
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthLoading());

    try {
      // Call real API
      final response = await authService.login(
        username: username,
        password: password,
      );

      // Extract token and user data
      final token = response['token'] ?? response['accessToken'] ?? '';
      final userData = response;

      // Save to SharedPreferences
      await prefs.setBool(AppConstants.keyIsLoggedIn, true);
      await prefs.setString(AppConstants.keyToken, token);
      await prefs.setString(AppConstants.keyUserData, json.encode(userData));
      await prefs.setInt(AppConstants.keyUserId, userData['id']);
      await prefs.setString(AppConstants.keyUsername, userData['username']);

      // Parse user model
      final user = UserModel.fromJson(userData);

      emit(AuthSuccess(user, token));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> logout() async {
    await prefs.setBool(AppConstants.keyIsLoggedIn, false);
    await prefs.remove(AppConstants.keyToken);
    await prefs.remove(AppConstants.keyUserData);
    await prefs.remove(AppConstants.keyUserId);
    await prefs.remove(AppConstants.keyUsername);
    emit(AuthLoggedOut());
  }

  UserModel? getCurrentUser() {
    if (state is AuthSuccess) {
      return (state as AuthSuccess).user;
    }
    return null;
  }

  String? getToken() {
    if (state is AuthSuccess) {
      return (state as AuthSuccess).token;
    }
    return prefs.getString(AppConstants.keyToken);
  }
}
