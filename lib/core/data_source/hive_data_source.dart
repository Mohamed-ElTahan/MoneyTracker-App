import 'package:hive_flutter/hive_flutter.dart';
import '../../feature/transactions/model/transaction_model.dart';

class HiveDataSource {
  final _transactionsBox = Hive.box<TransactionModel>("transactions");

  // add transaction
  Future<void> addTransaction({required TransactionModel transaction}) async {
    await _transactionsBox.add(transaction);
  }

  // get transactions
  List<TransactionModel> getTransactions() => _transactionsBox.values.toList();
}
