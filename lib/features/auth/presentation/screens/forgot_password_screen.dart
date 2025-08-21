// features/auth/presentation/screens/forgot_password_screen.dart
import 'package:claim_app/core/utils/validators.dart';
import 'package:claim_app/core/widgets/loading_indicator.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:claim_app/features/auth/presentation/widgets/show_password_change_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:claim_app/core/widgets/custom_button.dart';
import 'package:claim_app/core/widgets/custom_textfield.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:claim_app/core/constants/app_colors.dart';
import 'package:claim_app/core/widgets/custom_text.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next is AuthPasswordResetSent) {
        showPasswordChangedDialog(context);
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
              buildCompanyName(),
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
                          buildHeadingtext('Forgot Password'),
                          const SizedBox(height: 24),
                          buildEmailField(),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: authState is AuthLoading
                                ? const Center(child: LoadingIndicator())
                                : buildSendButton(authState),
                          ),
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

  Widget buildCompanyName() {
    return const Column(
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
    );
  }

  Widget buildHeadingtext(String text, {int? size, FontWeight? weight}) {
    return CustomText(
      title: text,
      fontSize: 28,
      weight: FontWeight.bold,
    );
  }

  Widget buildEmailField() {
    return CustomTextField(
      hintText: 'Enter your email',
      controller: _emailController,
      validator: Validators.email,
      prefixIcon: const Icon(Icons.email_outlined),
      borderColor: Colors.amber,
      borderRadius: 12,
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget buildSendButton(AuthState authState) {
    return authState is AuthLoading
        ? const LoadingIndicator()
        : CustomButton(
            text: 'Send Password',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ref
                    .read(authControllerProvider.notifier)
                    .forgotPassword(_emailController.text.trim());
              }
            },
            gradient: const LinearGradient(
              colors: [
                AppColors.purpleColor,
                AppColors.orangeColor,
              ],
            ),
            borderRadius: 12,
          );
  }
}
