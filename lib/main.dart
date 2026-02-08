import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/feature/auth/signup/signup_screen.dart';
import 'package:money_tracker_app/feature/home/home_screen.dart';
import 'package:money_tracker_app/feature/profile_settings/profile_and_settings_screen.dart';
import 'package:money_tracker_app/firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_routes.dart';
import 'feature/splash/splash_screen.dart';
import 'feature/auth/login/login_screen.dart';

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

      // Named routes configuration
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.profileAndSettings: (context) =>
            const ProfileAndSettingsScreen(),
      },
    );
  }
}
