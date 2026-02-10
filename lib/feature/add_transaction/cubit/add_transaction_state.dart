import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../core/localization/app_strings.dart';

enum AddTransactionStatus { initial, loading, success, failure }

class AddTransactionState extends Equatable {
  final AddTransactionStatus status;
  final bool isExpense;
  final String selectedCategory;
  final IconData selectedCategoryIcon;
  final Color selectedCategoryColor;
  final DateTime selectedDate;
  final String? errorMessage;

  const AddTransactionState({
    this.status = AddTransactionStatus.initial,
    this.isExpense = true,
    this.selectedCategory = AppStrings.selectCategory,
    this.selectedCategoryIcon = Icons.category,
    this.selectedCategoryColor = Colors.blue,
    required this.selectedDate,
    this.errorMessage,
  });

  factory AddTransactionState.initial() {
    return AddTransactionState(selectedDate: DateTime.now());
  }

  AddTransactionState copyWith({
    AddTransactionStatus? status,
    bool? isExpense,
    String? selectedCategory,
    IconData? selectedCategoryIcon,
    Color? selectedCategoryColor,
    DateTime? selectedDate,
    String? errorMessage,
  }) {
    return AddTransactionState(
      status: status ?? this.status,
      isExpense: isExpense ?? this.isExpense,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCategoryIcon: selectedCategoryIcon ?? this.selectedCategoryIcon,
      selectedCategoryColor:
          selectedCategoryColor ?? this.selectedCategoryColor,
      selectedDate: selectedDate ?? this.selectedDate,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isExpense,
    selectedCategory,
    selectedCategoryIcon,
    selectedCategoryColor,
    selectedDate,
    errorMessage,
  ];
}
