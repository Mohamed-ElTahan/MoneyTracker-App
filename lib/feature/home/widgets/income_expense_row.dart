import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/colors_manager.dart';

class IncomeExpenseRow extends StatelessWidget {
  final double income;
  final double expense;

  const IncomeExpenseRow({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: AppLocalizations.of(context)!.translate(AppStrings.income),
            amount: income.toString(),

            icon: Icons.arrow_downward,
            color: ColorsManager.successGreen,
            isPositive: true,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: AppLocalizations.of(context)!.translate(AppStrings.expense),
            amount: expense.toString(),
            icon: Icons.arrow_upward,
            color: ColorsManager.expenseRed,
            isPositive: false,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color color;
  final bool isPositive;

  const _StatCard({
    required this.title,
    required this.amount,
    required this.icon,
    required this.color,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),

          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text('\$$amount', style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}
