import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';

class TransactionAmountInput extends StatelessWidget {
  final TextEditingController controller;

  const TransactionAmountInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "AMOUNT",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: ColorsManager.textGrey,
            letterSpacing: 1.2,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "\$",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: ColorsManager.primaryBlue,
              ),
            ),
            IntrinsicWidth(
              child: TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: Theme.of(context).textTheme.displaySmall,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
