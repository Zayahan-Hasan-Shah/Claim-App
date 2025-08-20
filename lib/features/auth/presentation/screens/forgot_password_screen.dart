// features/auth/presentation/screens/forgot_password_screen.dart
import 'package:claim_app/core/utils/validators.dart';
import 'package:claim_app/core/widgets/custom_app_bar.dart';
import 'package:claim_app/core/widgets/loading_indicator.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:claim_app/core/widgets/custom_button.dart';
import 'package:claim_app/core/widgets/custom_textfield.dart';
import 'package:claim_app/features/auth/presentation/controllers/auth_controller.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent')),
        );
        context.pop();
      }
      if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.message)),
        );
      }
    });

    return Scaffold(
      appBar: const CustomAppBar(title: 'Forgot Password'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildEmailField(),
              const SizedBox(height: 24),
              authState is AuthLoading
                  ? const LoadingIndicator()
                  : buildSendButton(authState),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      label: 'Email',
      validator: Validators.email,
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
          );
  }
}
