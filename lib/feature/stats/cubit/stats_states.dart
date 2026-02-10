import '../model/category_stats_model.dart';

sealed class StatsStates {}

class StatsInitial extends StatsStates {}

class StatsLoading extends StatsStates {}

class StatsSuccess extends StatsStates {
  final double totalExpense;
  final List<CategoryStatsModel> categoryItems;

  StatsSuccess({required this.totalExpense, required this.categoryItems});
}

class StatsError extends StatsStates {
  StatsError();
}
