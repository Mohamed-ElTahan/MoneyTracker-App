import 'package:equatable/equatable.dart';
import '../model/transaction_model.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final List<TransactionModel> transactions;
  final List<TransactionModel> recentTransactions;
  final double totalIncome;
  final double totalExpense;
  final double totalBalance;

  const TransactionSuccess({
    required this.transactions,
    required this.recentTransactions,
    required this.totalIncome,
    required this.totalExpense,
    required this.totalBalance,
  });

  @override
  List<Object> get props => [
    transactions,
    recentTransactions,
    totalIncome,
    totalExpense,
    totalBalance,
  ];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}
