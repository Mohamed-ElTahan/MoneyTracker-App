import 'package:flutter/material.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = context.w(0.06);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        title: const Text("MoneyWise"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Form(
          key: _formKey,
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
                controller: _emailController,
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
                controller: _passwordController,
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
              PrimaryButton(
                text: "Login",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  }
                },
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
      ),
    );
  }
}
