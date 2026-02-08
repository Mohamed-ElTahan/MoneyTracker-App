import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/feature/auth/signup/signup_screen.dart';
import 'package:money_tracker_app/feature/home/home_screen.dart';
import 'package:money_tracker_app/feature/profile_settings/profile_and_settings_screen.dart';
import 'package:money_tracker_app/firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_routes.dart';
<<<<<<< HEAD
import 'feature/add_transaction/add_transaction_screen.dart';
import 'feature/auth/login/login_screen.dart';
import 'feature/auth/signup/signup_screen.dart';
import 'feature/splash/splash_screen.dart';
import 'feature/main_scaffold/main_scaffold_screen.dart';
=======
import 'feature/splash/splash_screen.dart';
import 'feature/auth/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
>>>>>>> da81dfdde254f64a4c2354a8c7f2ff061876c47e

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

      // Named routes configuration
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
<<<<<<< HEAD
        AppRoutes.home: (context) => const MainScaffoldScreen(),
        AppRoutes.addTransaction: (context) => const AddTransactionScreen(),
=======
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.profileAndSettings: (context) =>
            const ProfileAndSettingsScreen(),
>>>>>>> da81dfdde254f64a4c2354a8c7f2ff061876c47e
      },
    );
  }
}
