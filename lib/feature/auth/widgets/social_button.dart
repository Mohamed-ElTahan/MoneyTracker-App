import 'package:flutter/material.dart';
import '../../../core/theme/colors_manager.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final String? assetPath;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.text,
    this.icon,
    this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: const BorderSide(color: ColorsManager.lightGrey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: ColorsManager.textDark,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[Icon(icon, size: 30), const SizedBox(width: 8)],
          // Fallback for asset if needed, though we use Icons primarily
          if (assetPath != null) ...[
            // Image.asset(assetPath!, height: 24),
            // const SizedBox(width: 8),
          ],
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
