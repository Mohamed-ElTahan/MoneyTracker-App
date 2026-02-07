import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';

class AuthFooterRow extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onTap;

  const AuthFooterRow({super.key, required this.isLogin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? "Don't have an account? " : "Already have an account? ",
          style: const TextStyle(color: ColorsManager.textGrey),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            isLogin ? "Create account" : "Log In",
            style: const TextStyle(
              color: ColorsManager.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
