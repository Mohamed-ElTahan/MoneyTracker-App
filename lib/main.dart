import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'feature/add_transaction/add_transaction_screen.dart';
import 'feature/auth/login/login_screen.dart';
import 'feature/auth/signup/signup_screen.dart';
import 'feature/splash/splash_screen.dart';
import 'feature/main_scaffold/main_scaffold_screen.dart';
import 'feature/transactions/model/category_model.dart';
import 'feature/transactions/model/transaction_model.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/profile_settings/cubit/setting/setting_cubit.dart';
import 'feature/profile_settings/cubit/setting/setting_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  await Hive.openBox<TransactionModel>("transactions");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit(),
      child: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MoneyWise',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.settingModel.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,

            // Initial route - Splash Screen
            initialRoute: AppRoutes.splash,

            // Named routes
            routes: {
              AppRoutes.splash: (context) => const SplashScreen(),
              AppRoutes.login: (context) => const LoginScreen(),
              AppRoutes.signup: (context) => const SignupScreen(),
              AppRoutes.home: (context) => const MainScaffoldScreen(),
              AppRoutes.addTransaction: (context) =>
                  const AddTransactionScreen(),
            },
          );
        },
      ),
    );
  }
}
