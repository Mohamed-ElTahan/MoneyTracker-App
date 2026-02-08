import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/validator.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_label_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_footer_row.dart';
import '../widgets/or_continue_with_row.dart';
import '../widgets/social_auth_buttons.dart';
import '../../../../core/extension/media_query_extension.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const _LoginScreenContent(),
    );
  }
}

class _LoginScreenContent extends StatelessWidget {
  const _LoginScreenContent();

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = context.w(0.06);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("MoneyWise"),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            // Parse Firebase error messages to user-friendly text
            String errorMessage = state.errorMessage.toLowerCase();
            String friendlyMessage;

            if (errorMessage.contains('user-not-found')) {
              friendlyMessage =
                  'No account found with this email. Please sign up.';
            } else if (errorMessage.contains('wrong-password') ||
                errorMessage.contains('invalid-credential')) {
              friendlyMessage =
                  'Incorrect email or password. Please try again.';
            } else if (errorMessage.contains('invalid-email')) {
              friendlyMessage =
                  'Invalid email address. Please check and try again.';
            } else if (errorMessage.contains('user-disabled')) {
              friendlyMessage = 'This account has been disabled.';
            } else if (errorMessage.contains('network-request-failed')) {
              friendlyMessage = 'Network error. Please check your connection.';
            } else if (errorMessage.contains('too-many-requests')) {
              friendlyMessage =
                  'Too many login attempts. Please try again later.';
            } else if (errorMessage.contains('unknown-error') ||
                errorMessage.contains('internal-error')) {
              friendlyMessage =
                  'Something went wrong. Please check your credentials and try again.';
            } else if (errorMessage.contains('operation-not-allowed')) {
              friendlyMessage =
                  'Email/password login is not enabled. Please contact support.';
            } else {
              // Generic fallback message
              friendlyMessage =
                  'Login failed. Please check your email and password.';
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(friendlyMessage),
                backgroundColor: ColorsManager.expenseRed,
                duration: const Duration(seconds: 4),
              ),
            );
          } else if (state is LoginSuccess) {
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login successful! Welcome back 👋'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );

            // Navigate to home after success message
            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            });
          }
        },
        builder: (context, state) {
          final loginCubit = context.read<LoginCubit>();

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: Form(
              key: loginCubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: context.h(0.04)),
                  // Wallet Icon Container
                  Container(
                    padding: EdgeInsets.all(context.w(0.05)),
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.account_balance_wallet,
                      size: context.w(0.1), // Responsive icon
                      color: ColorsManager.primaryBlue,
                    ),
                  ),
                  SizedBox(height: context.h(0.03)),
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Login to manage your finances and track your expenses.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: context.h(0.04)),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomLabelField(label: "Email Address"),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: "name@example.com",
                    keyboardType: TextInputType.emailAddress,
                    controller: loginCubit.emailController,
                    validator: AppValidator.validateEmail,
                  ),

                  SizedBox(height: context.h(0.025)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomLabelField(label: "Password"),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    hintText: "Enter your password",
                    isPassword: true,
                    controller: loginCubit.passwordController,
                    validator: AppValidator.validatePassword,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO: implement forgot password
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: ColorsManager.primaryBlue),
                      ),
                    ),
                  ),

                  SizedBox(height: context.h(0.025)),
                  state is LoginLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          text: "Login",
                          onPressed: () => loginCubit.emitLoginStates(),
                        ),

                  SizedBox(height: context.h(0.04)),
                  SizedBox(height: context.h(0.04)),
                  const OrContinueWithRow(),
                  SizedBox(height: context.h(0.03)),

                  const SocialAuthButtons(),

                  SizedBox(height: context.h(0.04)),
                  AuthFooterRow(
                    isLogin: true,
                    onTap: () => Navigator.pushNamed(context, AppRoutes.signup),
                  ),
                  SizedBox(height: context.h(0.04)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
