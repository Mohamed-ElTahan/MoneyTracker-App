import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';
import '../transactions/widgets/transaction_item.dart';
import 'widgets/balance_card.dart';
import 'widgets/income_expense_row.dart';
import 'widgets/spending_chart.dart';
import '../../../../core/extension/media_query_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = context.w(0.06);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const BalanceCard(),
            SizedBox(height: context.h(0.03)),
            const IncomeExpenseRow(),
            SizedBox(height: context.h(0.03)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Monthly Summary",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.textDark,
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text("Details")),
              ],
            ),
            const SizedBox(height: 8),
            const SpendingChart(),
            SizedBox(height: context.h(0.03)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Transactions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.textDark,
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text("See All")),
              ],
            ),
            const SizedBox(height: 8),

            // Transactions List
            TransactionItem(
              title: "Starbucks Coffee",
              date: "Today, 09:41 AM",
              amount: "-\$5.50",
              icon: Icons.coffee,
              iconBgColor: Colors.orange.shade50,
              iconColor: Colors.orange,
            ),
            TransactionItem(
              title: "Apple Store",
              date: "Yesterday, 04:20 PM",
              amount: "-\$129.00",
              icon: Icons.shopping_bag, // Or generic cart
              iconBgColor: Colors.blue.shade50,
              iconColor: Colors.blue,
            ),
            TransactionItem(
              title: "Monthly Salary",
              date: "Oct 28, 2023",
              amount: "+\$4,200.00",
              icon: Icons.attach_money,
              iconBgColor: Colors.green.shade50,
              iconColor: ColorsManager.successGreen,
              isNegative: false,
            ),
            TransactionItem(
              title: "Netflix Subscription",
              date: "Oct 25, 2023",
              amount: "-\$15.00",
              icon: Icons.movie,
              iconBgColor: Colors.purple.shade50,
              iconColor: Colors.purple,
            ),
            SizedBox(height: context.h(0.1)),
          ],
        ),
      ),
    );
  }
}
