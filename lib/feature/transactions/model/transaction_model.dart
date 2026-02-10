import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final String category; // Could be enum or class
  @HiveField(5)
  final TransactionType type;

  // Hive doesn't support IconData directly, store codePoint
  @HiveField(6)
  final int iconCodePoint;

  // Hive doesn't support Color directly, store ARGB int
  @HiveField(7)
  final int colorValue;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    required this.iconCodePoint,
    required this.colorValue,
  });

  factory TransactionModel.create({
    required String id,
    required String title,
    required double amount,
    required DateTime date,
    required String category,
    required TransactionType type,
    required IconData icon,
    required Color color,
  }) {
    return TransactionModel(
      id: id,
      title: title,
      amount: amount,
      date: date,
      category: category,
      type: type,
      iconCodePoint: icon.codePoint,
      colorValue: color.toARGB32(),
    );
  }

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');
  Color get color => Color(colorValue);
}
