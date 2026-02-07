import 'package:flutter/material.dart';

class CustomLabelField extends StatelessWidget {
  const CustomLabelField({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium,
      textAlign: TextAlign.left,
    );
  }
}
