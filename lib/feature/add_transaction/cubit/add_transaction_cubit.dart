import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../core/data_source/hive_data_source.dart';
import '../../transactions/model/transaction_model.dart';
import 'add_transaction_state.dart';
import '../../../../core/localization/app_strings.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  AddTransactionCubit() : super(AddTransactionState.initial());

  final HiveDataSource _hiveDataSource = HiveDataSource();

  void changeType(bool isExpense) {
    if (!isExpense) {
      // Income default: Salary
      emit(
        state.copyWith(
          isExpense: false,
          selectedCategory: AppStrings.salary,
          selectedCategoryIcon: Icons.attach_money,
          selectedCategoryColor: Colors.green,
        ),
      );
    } else {
      // Expense default: Reset or keep existing if it was expense
      // For now, let's reset to "Select Category" if switching back to expense
      // or keep it if it's already expense.
      if (!state.isExpense) {
        emit(
          state.copyWith(
            isExpense: true,
            selectedCategory: AppStrings.selectCategory,
            selectedCategoryIcon: Icons.category,
            selectedCategoryColor: Colors.blue,
          ),
        );
      } else {
        emit(state.copyWith(isExpense: isExpense));
      }
    }
  }

  void changeCategory(String name, IconData icon, Color color) {
    emit(
      state.copyWith(
        selectedCategory: name,
        selectedCategoryIcon: icon,
        selectedCategoryColor: color,
      ),
    );
  }

  void changeDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  Future<void> saveTransaction({
    required String amountStr,
    required String? note,
  }) async {
    emit(state.copyWith(status: AddTransactionStatus.loading));

    try {
      final double? amount = double.tryParse(amountStr);
      if (amount == null || amount <= 0) {
        emit(
          state.copyWith(
            status: AddTransactionStatus.failure,
            errorMessage: "Please enter a valid amount",
          ),
        );
        return;
      }

      if (state.selectedCategory == AppStrings.selectCategory) {
        emit(
          state.copyWith(
            status: AddTransactionStatus.failure,
            errorMessage: "Please select a category",
          ),
        );
        return;
      }

      final transaction = TransactionModel.create(
        id: const Uuid().v4(),
        title: note?.isNotEmpty == true ? note! : state.selectedCategory,
        amount: amount,
        date: state.selectedDate,
        category: state.selectedCategory,
        type: state.isExpense
            ? TransactionType.expense
            : TransactionType.income,
        icon: state.selectedCategoryIcon,
        color: state.selectedCategoryColor,
      );

      await _hiveDataSource.addTransaction(transaction: transaction);

      emit(state.copyWith(status: AddTransactionStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: AddTransactionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
