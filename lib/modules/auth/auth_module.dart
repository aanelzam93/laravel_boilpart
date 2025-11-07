import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'auth_controller.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'forgot_password_page.dart';

class AuthModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthController>(),
        child: const LoginPage(),
      ),
    );
    
    r.child(
      '/register',
      child: (context) => BlocProvider.value(
        value: Modular.get<AuthController>(),
        child: const RegisterPage(),
      ),
    );
    
    r.child(
      '/forgot-password',
      child: (context) => const ForgotPasswordPage(),
    );
  }
}
