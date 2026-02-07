import 'package:flutter/material.dart';
import '../../../../core/extension/media_query_extension.dart';
import '../../../../core/theme/colors_manager.dart';

class OrContinueWithRow extends StatelessWidget {
  const OrContinueWithRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(0.02)),
          child: const Text(
            "OR CONTINUE WITH",
            style: TextStyle(
              fontSize: 12,
              color: ColorsManager.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
