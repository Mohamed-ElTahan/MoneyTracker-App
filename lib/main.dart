import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_routes.dart';
import 'feature/add_transaction/add_transaction_screen.dart';
import 'feature/auth/login/login_screen.dart';
import 'feature/auth/signup/signup_screen.dart';

import 'feature/profile_settings/profile_and_settings_screen.dart';
import 'feature/splash/splash_screen.dart';

import 'feature/main_wrapper/main_wrapper_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.home: (context) => const MainWrapperScreen(),
        AppRoutes.addTransaction: (context) => const AddTransactionScreen(),
        AppRoutes.profileAndSettings: (context) =>
            const ProfileAndSettingsScreen(),
      },
    );
  }
}
