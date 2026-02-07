import 'package:flutter/material.dart';

import '../../../core/theme/colors_manager.dart';

class CustomLogoutButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomLogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color.fromARGB(99, 228, 119, 135),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: const Icon(
          Icons.logout,
          color: ColorsManager.expenseRed,
          size: 24,
        ),
        label: const Text(
          "Logout",
          style: TextStyle(
            color: ColorsManager.expenseRed,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
