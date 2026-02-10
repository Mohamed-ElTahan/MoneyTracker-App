import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'transaction_model.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int iconCodePoint;

  @HiveField(2)
  final int colorValue;

  @HiveField(3)
  final TransactionType type;

  CategoryModel({
    required this.name,
    required this.iconCodePoint,
    required this.colorValue,
    required this.type,
  });

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');
  Color get color => Color(colorValue);
}
