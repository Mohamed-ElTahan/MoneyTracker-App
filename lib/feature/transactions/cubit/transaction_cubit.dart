import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/transaction_model.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  final Box<TransactionModel> box = Hive.box<TransactionModel>('transactions');
  final user = FirebaseAuth.instance.currentUser;
  double totalIncome = 0;
  double totalExpense = 0;

  void loadData() {
    emit(TransactionLoading());
    try {
      final List<TransactionModel> transactions = box.values
          .toList()
          .cast<TransactionModel>();

      for (var tx in transactions) {
        if (tx.type == TransactionType.income) {
          totalIncome += tx.amount;
        } else {
          totalExpense += tx.amount;
        }
      }

      final totalBalance = totalIncome - totalExpense;

      // Sort by date descending
      transactions.sort((a, b) => b.date.compareTo(a.date));

      final recentTransactions = transactions.take(5).toList();

      emit(
        TransactionSuccess(
          transactions: transactions,
          recentTransactions: recentTransactions,
          totalIncome: totalIncome,
          totalExpense: totalExpense,
          totalBalance: totalBalance,
        ),
      );
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
