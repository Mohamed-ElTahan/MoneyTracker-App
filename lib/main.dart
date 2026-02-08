import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'feature/add_transaction/add_transaction_screen.dart';
import 'feature/auth/login/login_screen.dart';
import 'feature/auth/signup/signup_screen.dart';
import 'feature/splash/splash_screen.dart';
import 'feature/main_scaffold/main_scaffold_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoneyWise',
      theme: AppTheme.lightTheme,

      // Initial route - Splash Screen
      initialRoute: AppRoutes.splash,

      // Named routes
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.home: (context) => const MainScaffoldScreen(),
        AppRoutes.addTransaction: (context) => const AddTransactionScreen(),
      },
    );
  }
}
