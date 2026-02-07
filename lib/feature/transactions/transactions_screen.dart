import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/extension/media_query_extension.dart';
import 'model/transaction_model.dart';
import 'widgets/transaction_item.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // Dummy Data
  final List<TransactionModel> _transactions = [
    TransactionModel(
      id: '1',
      title: 'Starbucks Coffee',
      amount: 5.50,
      date: DateTime.now(),
      category: 'Food & Drink',
      type: TransactionType.expense,
      icon: Icons.coffee,
      color: Colors.orange,
    ),
    TransactionModel(
      id: '2',
      title: 'Apple Store',
      amount: 129.00,
      date: DateTime.now(),
      category: 'Electronics',
      type: TransactionType.expense,
      icon: Icons.shopping_bag,
      color: Colors.blue,
    ),
    TransactionModel(
      id: '3',
      title: 'Monthly Salary',
      amount: 3200.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Income',
      type: TransactionType.income,
      icon: Icons.attach_money,
      color: ColorsManager.successGreen,
    ),
    TransactionModel(
      id: '4',
      title: 'Netflix',
      amount: 15.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Entertainment',
      type: TransactionType.expense,
      icon: Icons.movie,
      color: Colors.purple,
    ),
    TransactionModel(
      id: '5',
      title: 'Uber Trip',
      amount: 24.50,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Transport',
      type: TransactionType.expense,
      icon: Icons.directions_car,
      color: Colors.yellow.shade700,
    ),
    TransactionModel(
      id: '6',
      title: "McDonald's",
      amount: 12.40,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: 'Food & Drink',
      type: TransactionType.expense,
      icon: Icons.fastfood,
      color: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Determine groupings if needed, for simplicity we list them.
    // In a real app we would group by Date (Today, Yesterday, Date).

    return Column(
      children: [
        // Search Bar
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w(0.04),
            vertical: context.h(0.01),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search transactions...",
              prefixIcon: const Icon(Icons.search),
              // TODO: make filter logic
            ),
          ),
        ),

        // Filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: context.w(0.04)),
          child: Row(
            children: [
              _buildFilterChip("Date", Icons.calendar_today, true),
              const SizedBox(width: 8),
              _buildFilterChip("Category", Icons.category, false),
              const SizedBox(width: 8),
              _buildFilterChip("Type", Icons.money, false),
            ],
          ),
        ),

        SizedBox(height: context.h(0.02)),

        // List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: context.w(0.04)),
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              final tx = _transactions[index];
              // Simple Header logic (Today/Yesterday) can be added here
              // matching user screenshot structure.
              return TransactionItem(
                title: tx.title,
                date: "${tx.category} • 10:00 AM", // Dummy time
                amount: tx.type == TransactionType.income
                    ? "+\$${tx.amount.toStringAsFixed(2)}"
                    : "-\$${tx.amount.toStringAsFixed(2)}",
                icon: tx.icon,
                iconBgColor: tx.color.withValues(alpha: 0.1),
                iconColor: tx.color,
                isNegative: tx.type == TransactionType.expense,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, IconData icon, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(0.04),
        vertical: context.h(0.01),
      ),
      decoration: BoxDecoration(
        color: isSelected ? ColorsManager.primaryBlue : ColorsManager.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: isSelected ? Colors.white : ColorsManager.textDark,
          ),
          SizedBox(width: context.w(0.02)),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isSelected ? Colors.white : ColorsManager.textDark,
            ),
          ),
          SizedBox(width: context.w(0.01)),
          Icon(
            Icons.keyboard_arrow_down,
            size: 16,
            color: isSelected ? Colors.white : ColorsManager.textDark,
          ),
        ],
      ),
    );
  }
}
