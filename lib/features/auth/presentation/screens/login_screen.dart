import 'package:claim_app/core/validations/app_validation.dart';
import 'package:claim_app/core/widgets/custom_app_bar.dart';
import 'package:claim_app/core/widgets/custom_button.dart';
import 'package:claim_app/core/widgets/custom_text.dart';
import 'package:claim_app/core/widgets/custom_textfield.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:claim_app/navigation/route_names.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        context.go(RouteNames.mainWrapper);
      }
      if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    return Scaffold(
      appBar: const CustomAppBar(title: 'Login'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField(
                label: 'Email',
                controller: _emailController,
                validator: AppValidation.validateEmail,
              ),
              const SizedBox(height: 16),
              buildTextField(
                label: 'Password',
                controller: _passwordController,
                obscureText: true,
                validator: AppValidation.validatePassword,
              ),
              const SizedBox(height: 24),
              authState is AuthLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: 'Login',
                      onPressed: _login,
                    ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  context.push(RouteNames.forgotPassword);
                },
                child: const CustomText(
                    title: 'Forgot Password?',
                    fontSize: 16,
                    color: Colors.blue,
                    underline: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return CustomTextField(
      controller: controller,
      label: label,
      obscureText: obscureText,
      validator: validator,
    );
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      ref.read(authControllerProvider.notifier).login(email, password);
    }
  }
}
