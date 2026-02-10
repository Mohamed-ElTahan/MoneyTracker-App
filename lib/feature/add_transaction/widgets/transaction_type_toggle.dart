import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/app_strings.dart';

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
          Expanded(
            child: _buildButton(
              context,
              AppLocalizations.of(context)!.translate(AppStrings.expense),
              true,
              isExpense,
            ),
          ),
          Expanded(
            child: _buildButton(
              context,
              AppLocalizations.of(context)!.translate(AppStrings.income),
              false,
              !isExpense,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    bool isExpenseType,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          onTypeChanged(isExpenseType);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? (isExpenseType
                    ? ColorsManager.expenseRed
                    : ColorsManager.successGreen)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color:
                        (isExpenseType
                                ? ColorsManager.expenseRed
                                : ColorsManager.successGreen)
                            .withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : ColorsManager.textGrey,
          ),
        ),
      ),
    );
  }
}
