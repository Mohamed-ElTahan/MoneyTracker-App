import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_tracker_app/core/data_source/hive_data_source.dart';
import '../model/transaction_model.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  final HiveDataSource hiveDataSource = HiveDataSource();

  double totalIncome = 0;
  double totalExpense = 0;

  void loadData() {
    emit(TransactionLoading());
    try {
      final List<TransactionModel> transactions = hiveDataSource
          .getTransactions();

      for (TransactionModel tx in transactions) {
        if (tx.isIncome) {
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
