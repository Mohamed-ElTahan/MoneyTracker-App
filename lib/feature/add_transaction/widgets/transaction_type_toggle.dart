import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';

class TransactionTypeToggle extends StatelessWidget {
  final bool isExpense;
  final ValueChanged<bool> onTypeChanged;

  const TransactionTypeToggle({
    super.key,
    required this.isExpense,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: ColorsManager.lightGrey.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: _buildButton("Expense", isExpense)),
          Expanded(child: _buildButton("Income", !isExpense)),
        ],
      ),
    );
  }

  Widget _buildButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onTypeChanged(text == "Expense");
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? ColorsManager.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? ColorsManager.textDark : ColorsManager.textGrey,
          ),
        ),
      ),
    );
  }
}
