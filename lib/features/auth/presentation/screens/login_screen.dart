import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/validations/app_validation.dart';
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.brightYellowColor,
              AppColors.lightYellowColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Logo and company name
              const Column(
                children: [
                  SizedBox(height: 12),
                  CustomText(
                    title: 'Century Insurance',
                    fontSize: 22,
                    weight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(height: 2),
                  CustomText(
                    title: 'A Lakson Group Company',
                    fontSize: 14,
                    weight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ],
              ),
              const SizedBox(height: 36),
              // Card with form
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            title: 'Sign in',
                            fontSize: 28,
                            weight: FontWeight.bold,
                          ),
                          const SizedBox(height: 24),
                          const CustomText(
                            title: 'User name or email',
                            fontSize: 16,
                            weight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 8),
                          buildEmailTextField(),
                          const SizedBox(height: 20),
                          const CustomText(
                            title: 'Password',
                            fontSize: 16,
                            weight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 8),
                          buildPasswordTextField(),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: authState is AuthLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : CustomButton(
                                    text: 'Sign in',
                                    onPressed: _login,
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.purpleColor,
                                        AppColors.orangeColor,
                                      ],
                                    ),
                                    borderRadius: 12,
                                  ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    context.push(RouteNames.forgotPassword);
                                  },
                                  child: const CustomText(
                                    title: 'Forgot Password?',
                                    fontSize: 16,
                                    weight: FontWeight.normal,
                                    color: Colors.black87,
                                  ),
                                ),
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailTextField() {
    return CustomTextField(
      hintText: 'User Name or Email',
      controller: _emailController,
      validator: AppValidation.validateEmail,
      prefixIcon: const Icon(Icons.person_outline),
      suffixIcon: _emailController.text.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _emailController.clear(),
            )
          : null,
      borderColor: Colors.amber,
      borderRadius: 12,
    );
  }

  Widget buildPasswordTextField() {
    return CustomTextField(
      controller: _passwordController,
      obscureText: true,
      validator: AppValidation.validatePassword,
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(
          _passwordController.text.isNotEmpty
              ? Icons.visibility_off
              : Icons.visibility,
        ),
        onPressed: () {
          setState(() {
            // Toggle obscureText
          });
        },
      ),
      borderColor: Colors.amber,
      borderRadius: 12,
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
