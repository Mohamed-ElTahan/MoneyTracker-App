import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors_manager.dart';
import '../model/transaction_model.dart';
import 'transaction_item.dart';

class TransactionListWidget extends StatelessWidget {
  final List<TransactionModel> transactions;
  const TransactionListWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Icon(
              Icons.receipt_long,
              size: 64,
              color: ColorsManager.grey.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              "No transactions yet",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: ColorsManager.grey),
            ),
            const SizedBox(height: 8),
            Text(
              "Start by adding your income or expense",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        return TransactionItem(
          title: tx.title,
          date: DateFormat('MMM d, h:mm a').format(tx.date),
          amount: tx.type == TransactionType.income
              ? "+\$${tx.amount}"
              : "-\$${tx.amount}",
          icon: tx.icon,
          iconBgColor: tx.color.withValues(alpha: 0.1),
          iconColor: tx.color,
          isNegative: tx.type == TransactionType.expense,
        );
      },
    );
  }
}
