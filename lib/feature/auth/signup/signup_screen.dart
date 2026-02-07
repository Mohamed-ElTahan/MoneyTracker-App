import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/utils/validator.dart';
import '../../../core/utils/app_routes.dart';
import '../widgets/custom_label_field.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_footer_row.dart';
import '../widgets/or_continue_with_row.dart';
import '../widgets/social_auth_buttons.dart';
import '../../../../core/extension/media_query_extension.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: const _SignupScreenContent(),
    );
  }
}

class _SignupScreenContent extends StatefulWidget {
  const _SignupScreenContent();

  @override
  State<_SignupScreenContent> createState() => _SignupScreenContentState();
}

class _SignupScreenContentState extends State<_SignupScreenContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorsManager.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "MoneyWise",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: ColorsManager.expenseRed,
              ),
            );
          } else if (state is SignupSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
        },
        builder: (context, state) {
          final signupCubit = context.read<SignupCubit>();
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/money.png',
                  height: context.h(0.25),
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.w(0.06)),
                  child: Form(
                    key: signupCubit.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: context.h(0.02)),
                        Text(
                          "Join MoneyWise",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Start tracking your expenses and save smarter.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: context.h(0.03)),

                        // Full Name
                        const CustomLabelField(label: "Full Name"),
                        CustomTextField(
                          controller: signupCubit.nameController,
                          hintText: "Enter your name",
                          prefixIcon: Icons.person_outline,
                          validator: AppValidator.validateName,
                        ),

                        SizedBox(height: context.h(0.02)),
                        // Email
                        const CustomLabelField(label: "Email Address"),
                        CustomTextField(
                          controller: signupCubit.emailController,
                          hintText: "example@email.com",
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidator.validateEmail,
                        ),

                        SizedBox(height: context.h(0.02)),
                        // Password
                        const CustomLabelField(label: "Password"),
                        CustomTextField(
                          controller: signupCubit.passwordController,
                          hintText: "Create a password",
                          prefixIcon: Icons.lock_outline,
                          isPassword: true,
                          validator: AppValidator.validatePassword,
                        ),

                        SizedBox(height: context.h(0.02)),
                        // Confirm Password
                        const CustomLabelField(label: "Confirm Password"),
                        CustomTextField(
                          controller: signupCubit.confirmPasswordController,
                          hintText: "Repeat password",
                          prefixIcon: Icons.lock_reset,
                          isPassword: true,
                          validator: (value) =>
                              AppValidator.validateConfirmPassword(
                                value,
                                signupCubit.passwordController.text,
                              ),
                        ),

                        SizedBox(height: context.h(0.03)),
                        state is SignupLoading
                            ? const Center(child: CircularProgressIndicator())
                            : PrimaryButton(
                                text: "Register",
                                onPressed: () => signupCubit.emitSignupStates(),
                              ),

                        SizedBox(height: context.h(0.03)),
                        const OrContinueWithRow(),
                        SizedBox(height: context.h(0.03)),

                        const SocialAuthButtons(),

                        SizedBox(height: context.h(0.03)),
                        AuthFooterRow(
                          isLogin: false,
                          onTap: () => Navigator.pop(context),
                        ),

                        SizedBox(height: context.h(0.02)),
                        const Text(
                          "By registering, you agree to our Terms of Service and Privacy Policy.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ColorsManager.textGrey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: context.h(0.02)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
