import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background with colorful gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4FACFE),
                  Color(0xFF00F2FE),
                  Color(0xFF43E97B),
                  Color(0xFF38F9D7),
                ],
                stops: [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          // Decorative glassmorphism circles
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.3,
            right: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.15,
            left: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: size.height * 0.25,
            right: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.03),
                  ],
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Card(
                    elevation: 20,
                    shadowColor: Colors.black.withOpacity(0.3),
                    color: Colors.white.withOpacity(0.95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: _emailSent ? _buildSuccessView() : _buildFormView(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormView() {
    final l10n = AppLocalizations.of(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Back button
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Modular.to.pop(),
                color: const Color(0xFF4FACFE),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Logo/Icon with gradient background and badge
          Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                children: [
                  // White background circle
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                  // Gradient circle with icon
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF4FACFE),
                            Color(0xFF00F2FE),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        Icons.lock_reset,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Badge
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF43E97B),
                            Color(0xFF38F9D7),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF43E97B).withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mail_outline,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            'Forgot Password?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 8),

          Text(
            'No worries, we\'ll send you reset instructions',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 32),

          // Email Field with gradient icon
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: l10n.email,
              hintText: 'Enter your email',
              prefixIcon: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4FACFE),
                      Color(0xFF00F2FE),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF4FACFE),
                  width: 2,
                ),
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
            enabled: !_isLoading,
          ),
          const SizedBox(height: 32),

          // Send Button with gradient
          Container(
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4FACFE),
                  Color(0xFF00F2FE),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4FACFE).withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _sendResetLink,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isLoading
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
                  : const Text(
                      'Send Reset Link',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 24),

          // Back to login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_back,
                size: 16,
                color: Color(0xFF4FACFE),
              ),
              TextButton(
                onPressed: () => Modular.to.pop(),
                child: Text(
                  'Back to ${l10n.login}',
                  style: const TextStyle(
                    color: Color(0xFF4FACFE),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    final l10n = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Success Icon with gradient
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF43E97B).withOpacity(0.2),
                const Color(0xFF38F9D7).withOpacity(0.1),
              ],
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF43E97B),
                  Color(0xFF38F9D7),
                ],
              ),
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),

        Text(
          'Check your email',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 16),

        Text(
          'We have sent a password reset link to',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),

        Text(
          _emailController.text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF4FACFE),
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Back to login button with gradient
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4FACFE),
                Color(0xFF00F2FE),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4FACFE).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => Modular.to.pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Back to ${l10n.login}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Resend email
        TextButton(
          onPressed: () {
            setState(() => _emailSent = false);
          },
          child: const Text(
            'Didn\'t receive the email? Resend',
            style: TextStyle(
              color: Color(0xFF4FACFE),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
