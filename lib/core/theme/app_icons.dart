import 'package:flutter/material.dart';
import '../localization/app_strings.dart';
import 'colors_manager.dart';

class AppIcons {
  static const Map<String, IconData> _icons = {
    // Expense
    AppStrings.foodDrink: Icons.fastfood,
    AppStrings.shopping: Icons.shopping_bag,
    AppStrings.transport: Icons.directions_car,
    AppStrings.entertainment: Icons.movie,
    AppStrings.billsUtilities: Icons.receipt_long,
    AppStrings.health: Icons.medical_services,
    AppStrings.others: Icons.more_horiz,

    // Income
    AppStrings.salary: Icons.attach_money,
    AppStrings.business: Icons.business,
    AppStrings.investment: Icons.trending_up,
    AppStrings.gift: Icons.card_giftcard,
    AppStrings.other: Icons.more_horiz,
  };

  static final Map<String, Color> _colors = {
    // Expense
    AppStrings.foodDrink: ColorsManager.expenseRed,
    AppStrings.shopping: Colors.blue,
    AppStrings.transport: ColorsManager.successGreen,
    AppStrings.entertainment: Colors.orange,
    AppStrings.billsUtilities: Colors.purple,
    AppStrings.health: Colors.teal,
    AppStrings.others: ColorsManager.textGrey,

    // Income
    AppStrings.salary: Colors.green,
    AppStrings.business: Colors.blue,
    AppStrings.investment: Colors.purple,
    AppStrings.gift: Colors.orange,
    AppStrings.other: Colors.teal,
  };

  static IconData getIcon(String category) {
    return _icons[category] ?? Icons.category;
  }

  static Color getColor(String category) {
    return _colors[category] ?? Colors.grey;
  }
}
