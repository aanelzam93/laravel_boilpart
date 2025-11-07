import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import 'auth_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Colorful gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFF093FB),
                  Color(0xFFF5576C),
                  Color(0xFFFF6B6B),
                  Color(0xFFFFB347),
                ],
                stops: [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          // Animated decorative circles
          Positioned(
            top: -150,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.2,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.02),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.12),
                    Colors.white.withOpacity(0.03),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.5,
            right: 20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.08),
                    Colors.white.withOpacity(0.02),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: size.height * 0.3,
            left: 30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.01),
                  ],
                ),
              ),
            ),
          ),

          // Main content
          BlocConsumer<AuthController, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Modular.to.navigate('/home/');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is AuthLoading;

              return SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Column(
                        children: [
                          // Back Button
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back),
                                onPressed: () => Modular.to.pop(),
                                color: const Color(0xFFF093FB),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Animated Logo/Icon at top
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFF093FB),
                                          Color(0xFFF5576C),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.person_add,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Glassmorphism Card
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(32),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Welcome Text
                                    const Text(
                                      'Create Account 🎉',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1A1A1A),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),

                                    Text(
                                      'Sign up to start your learning journey',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 24),

                                    // Name Field
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        hintText: 'Enter your full name',
                                        hintStyle: TextStyle(color: Colors.grey[400]),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.badge_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFF5F5F5),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                            color: Colors.grey[200]!,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFF093FB),
                                            width: 2,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Name tidak boleh kosong';
                                        }
                                        return null;
                                      },
                                      enabled: !isLoading,
                                    ),
                                    const SizedBox(height: 16),

                                    // Email Field
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: l10n.email,
                                        hintText: 'Enter your email',
                                        hintStyle: TextStyle(color: Colors.grey[400]),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.email_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFF5F5F5),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                            color: Colors.grey[200]!,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF4FACFE),
                                            width: 2,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Email tidak boleh kosong';
                                        }
                                        if (!value.contains('@')) {
                                          return 'Email tidak valid';
                                        }
                                        return null;
                                      },
                                      enabled: !isLoading,
                                    ),
                                    const SizedBox(height: 16),

                                    // Username Field
                                    TextFormField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        labelText: 'Username',
                                        hintText: 'Choose a username',
                                        hintStyle: TextStyle(color: Colors.grey[400]),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.person_outline,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFF5F5F5),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                            color: Colors.grey[200]!,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF667EEA),
                                            width: 2,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Username tidak boleh kosong';
                                        }
                                        return null;
                                      },
                                      enabled: !isLoading,
                                    ),
                                    const SizedBox(height: 16),

                                    // Password Field
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        labelText: l10n.password,
                                        hintText: 'Create a password',
                                        hintStyle: TextStyle(color: Colors.grey[400]),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFFFF6B6B), Color(0xFFEE5A6F)],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.lock_outline,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey[400],
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword = !_obscurePassword;
                                            });
                                          },
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFF5F5F5),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                            color: Colors.grey[200]!,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: Color(0xFFFF6B6B),
                                            width: 2,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password tidak boleh kosong';
                                        }
                                        if (value.length < 6) {
                                          return 'Password minimal 6 karakter';
                                        }
                                        return null;
                                      },
                                      enabled: !isLoading,
                                    ),
                                    const SizedBox(height: 16),

                                    // Confirm Password Field
                                    TextFormField(
                                      controller: _confirmPasswordController,
                                      obscureText: _obscureConfirmPassword,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        hintText: 'Confirm your password',
                                        hintStyle: TextStyle(color: Colors.grey[400]),
                                        prefixIcon: Container(
                                          margin: const EdgeInsets.all(12),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(
                                            Icons.lock_outline,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureConfirmPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey[400],
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureConfirmPassword = !_obscureConfirmPassword;
                                            });
                                          },
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFFF5F5F5),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide.none,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: BorderSide(
                                            color: Colors.grey[200]!,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF11998E),
                                            width: 2,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Konfirmasi password tidak boleh kosong';
                                        }
                                        if (value != _passwordController.text) {
                                          return 'Password tidak cocok';
                                        }
                                        return null;
                                      },
                                      enabled: !isLoading,
                                    ),
                                    const SizedBox(height: 24),

                                    // Register Button with gradient
                                    Container(
                                      height: 56,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFF093FB),
                                            Color(0xFFF5576C),
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFFF093FB).withOpacity(0.4),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: isLoading
                                            ? null
                                            : () {
                                                if (_formKey.currentState!.validate()) {
                                                  // Register with username (dummy)
                                                  BlocProvider.of<AuthController>(context).login(
                                                        _usernameController.text,
                                                        _passwordController.text,
                                                      );
                                                }
                                              },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: isLoading
                                            ? const SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                l10n.register,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Already have account
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          l10n.alreadyHaveAccount,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => Modular.to.pop(),
                                          child: Text(
                                            l10n.login,
                                            style: const TextStyle(
                                              color: Color(0xFFF093FB),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
