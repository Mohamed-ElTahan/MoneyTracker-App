import 'package:flutter/material.dart';
import '../../../core/theme/colors_manager.dart';
import '../../../../core/extension/media_query_extension.dart';
import 'widgets/donut_chart.dart';
import 'widgets/category_spending_item.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categorySpendingItems = [
      {
        "category": "Food & Drink",
        "amount": "\$1,134.00",
        "percentage": "35%",
        "progress": 0.35,
        "color": ColorsManager.expenseRed,
        "icon": Icons.restaurant,
      },
      {
        "category": "Shopping",
        "amount": "\$810.00",
        "percentage": "25%",
        "progress": 0.25,
        "color": Colors.blue,
        "icon": Icons.shopping_bag,
      },
      {
        "category": "Transport",
        "amount": "\$486.00",
        "percentage": "15%",
        "progress": 0.15,
        "color": ColorsManager.successGreen,
        "icon": Icons.directions_car,
      },
      {
        "category": "Entertainment",
        "amount": "\$324.00",
        "percentage": "10%",
        "progress": 0.10,
        "color": Colors.orange,
        "icon": Icons.movie,
      },
      {
        "category": "Bills & Utilities",
        "amount": "\$226.80",
        "percentage": "7%",
        "progress": 0.07,
        "color": Colors.purple,
        "icon": Icons.receipt_long,
      },
      {
        "category": "Others",
        "amount": "\$259.20",
        "percentage": "8%",
        "progress": 0.08,
        "color": ColorsManager.textGrey,
        "icon": Icons.more_horiz,
      },
    ];
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w(0.05)),
        child: Column(
          children: [
            // Donut Chart
            SizedBox(
              height: context.h(0.3),
              child: DonutChart(
                totalAmount: "\$3,240",
                data: [
                  DonutChartData(1134.0, ColorsManager.expenseRed), // Food
                  DonutChartData(810.0, Colors.blue), // Shopping
                  DonutChartData(
                    486.0,
                    ColorsManager.successGreen,
                  ), // Transport
                  DonutChartData(324.0, Colors.orange), // Entertainment
                  DonutChartData(226.8, Colors.purple), // Bills
                  DonutChartData(259.2, ColorsManager.textGrey), // Others
                ],
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
                  return CategorySpendingItem(
                    category: categorySpendingItems[index]["category"],
                    amount: categorySpendingItems[index]["amount"],
                    percentage: categorySpendingItems[index]["percentage"],
                    progress: categorySpendingItems[index]["progress"],
                    color: categorySpendingItems[index]["color"],
                    icon: categorySpendingItems[index]["icon"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
