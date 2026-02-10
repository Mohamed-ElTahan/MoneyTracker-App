import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';

class TransactionAmountInput extends StatelessWidget {
  final TextEditingController controller;

  const TransactionAmountInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "\$",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: ColorsManager.textGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            IntrinsicWidth(
              child: TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                style: Theme.of(context).textTheme.displaySmall,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "0.00",
                  hintStyle: TextStyle(color: ColorsManager.textGrey),
                ),
                onTap: () {
                  if (controller.text == '0.00') {
                    controller.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
