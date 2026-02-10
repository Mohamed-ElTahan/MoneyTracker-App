import 'package:flutter/material.dart';

class CategoryStatsModel {
  final String category;
  final double amount;
  final double percentage; // 0 → 1
  final Color color;
  final IconData icon;

  CategoryStatsModel({
    required this.category,
    required this.amount,
    required this.percentage,
    required this.color,
    required this.icon,
  });
}
