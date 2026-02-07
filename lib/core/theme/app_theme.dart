import 'package:flutter/material.dart';
import 'colors_manager.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: ColorsManager.primaryBlue,
      scaffoldBackgroundColor: ColorsManager.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsManager.primaryBlue,
        surface: ColorsManager.background,
      ),
      useMaterial3: true,
      fontFamily: 'Roboto',

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorsManager.white,
        foregroundColor: ColorsManager.black,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorsManager.black),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: ColorsManager.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      // floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.primaryBlue,
        foregroundColor: ColorsManager.white,
        elevation: 0,
        iconSize: 30,
        shape: CircleBorder(),
      ),

      // ElevatedButton Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryBlue,
          foregroundColor: ColorsManager.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorsManager.primaryBlue,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorsManager.expenseRed, width: 2),
        ),
        errorMaxLines: 2,
        errorStyle: TextStyle(
          color: ColorsManager.expenseRed,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        hintStyle: const TextStyle(color: ColorsManager.textGrey),
      ),

      // Text Theme
      textTheme: const TextTheme(
        // Used for: Login Screen Title ("Welcome Back")
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: ColorsManager.textDark,
        ),
        // Used for: Signup Screen Title ("Join MoneyWise")
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: ColorsManager.textDark,
        ),
        // Used for:
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsManager.textDark,
        ),
        // Used for: Section Headers (Home: "Monthly Summary")
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ColorsManager.textDark,
        ),
        // Used for: CustomLabelField (Input Labels), Filter Chips, Transaction Items
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: ColorsManager.textDark,
        ),
        // Used for: Standard Body Text, TransactionItem Amounts, Cancel Buttons
        bodyLarge: TextStyle(fontSize: 16, color: ColorsManager.textDark),
        // Used for: Subtitles, Dates, Hints, Secondary Text
        bodyMedium: TextStyle(fontSize: 14, color: ColorsManager.textGrey),
        // Used for: Primary Buttons
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorsManager.primaryBlue,
        ),
        // Used for: Large Amount Display (Add Transaction)
        displaySmall: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: ColorsManager.textDark,
        ),
        // Used for: Profile & Settings Title
        labelSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorsManager.textGrey,
        ),

        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: ColorsManager.textGrey,
        ),
      ),
    );
  }
}
