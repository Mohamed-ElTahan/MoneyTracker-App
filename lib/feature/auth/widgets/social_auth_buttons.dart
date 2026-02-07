import 'package:flutter/material.dart';
import '../../../../core/extension/media_query_extension.dart';
import 'social_button.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SocialButton(
            text: "Google",
            icon: Icons.g_mobiledata, // Replace with actual asset if available
            onPressed: () {
              // TODO: Google Auth
            },
          ),
        ),
        SizedBox(width: context.w(0.02)),
        Expanded(
          child: SocialButton(
            text: "Apple",
            icon: Icons.apple,
            onPressed: () {
              // TODO: Apple Auth
            },
          ),
        ),
      ],
    );
  }
}
