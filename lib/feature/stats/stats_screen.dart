import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/extension/media_query_extension.dart';
import '../transactions/model/transaction_model.dart';
import 'widgets/donut_chart.dart';
import 'widgets/category_spending_item.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w(0.05)),
        child: ValueListenableBuilder<Box<TransactionModel>>(
          valueListenable: Hive.box<TransactionModel>(
            'transactions',
          ).listenable(),
          builder: (context, box, _) {
            final transactions = box.values.toList().cast<TransactionModel>();
            final expenses = transactions
                .where((tx) => tx.type == TransactionType.expense)
                .toList();

            if (expenses.isEmpty) {
              return Center(
                child: Text(
                  "No expenses yet",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }

            // Calculate Totals by Category
            final Map<String, double> categoryTotals = {};
            final Map<String, TransactionModel> categoryMeta = {};

            double totalExpense = 0;

            for (var tx in expenses) {
              totalExpense += tx.amount;
              categoryTotals[tx.category] =
                  (categoryTotals[tx.category] ?? 0) + tx.amount;
              // Save one tx to get icon and color
              categoryMeta.putIfAbsent(tx.category, () => tx);
            }

            // Prepare Data List
            final List<Map<String, dynamic>> categorySpendingItems = [];
            final List<DonutChartData> chartData = [];

            categoryTotals.forEach((category, amount) {
              final meta = categoryMeta[category]!;
              final percentage = amount / totalExpense;

              categorySpendingItems.add({
                "category": category,
                "amount": '\$$amount',
                "percentage": "${(percentage * 100).toStringAsFixed(0)}%",
                "progress": percentage,
                "color": meta.color,
                "icon": meta.icon,
                "rawAmount": amount, // for sorting
              });

              chartData.add(DonutChartData(amount, meta.color));
            });

            // Sort by amount descending
            categorySpendingItems.sort(
              (a, b) => (b["rawAmount"] as double).compareTo(
                a["rawAmount"] as double,
              ),
            );

            return Column(
              children: [
                // Donut Chart
                SizedBox(
                  height: context.h(0.3),
                  child: DonutChart(
                    totalAmount: "\$${totalExpense.toStringAsFixed(0)}",
                    data: chartData,
                  ),
                ),

                // Section Header
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "SPENDING BY CATEGORY",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: context.h(0.01)),
                // List Items
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categorySpendingItems.length,
                    itemBuilder: (context, index) {
                      final item = categorySpendingItems[index];
                      return CategorySpendingItem(
                        category: item["category"],
                        amount: item["amount"],
                        percentage: item["percentage"],
                        progress: item["progress"],
                        color: item["color"],
                        icon: item["icon"],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
