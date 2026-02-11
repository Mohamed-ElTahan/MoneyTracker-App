import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/data_source/hive_data_source.dart';
import '../../transactions/model/transaction_model.dart';
import '../model/category_stats_model.dart';
import 'stats_states.dart';
import '../../../core/theme/app_icons.dart';

class StatsCubit extends Cubit<StatsStates> {
  StatsCubit() : super(StatsInitial());

  final HiveDataSource _hiveDataSource = HiveDataSource();

  void getStatsData() {
    emit(StatsLoading());

    try {
      final allTransactions = _hiveDataSource.getTransactions();

      double totalExpense = 0;
      final Map<String, double> totals = {};
      final Map<String, TransactionModel> meta = {};

      for (TransactionModel tx in allTransactions) {
        if (!tx.isIncome) {
          totalExpense += tx.amount;
          totals[tx.category] = (totals[tx.category] ?? 0) + tx.amount;
          // Store a representative transaction for icon/color lookup
          meta.putIfAbsent(tx.category, () => tx);
        }
      }

      final List<CategoryStatsModel> items = [];

      totals.forEach((category, amount) {
        final txMeta = meta[category]!;
        final double percent = totalExpense == 0 ? 0 : amount / totalExpense;

        items.add(
          CategoryStatsModel(
            category: category,
            amount: amount,
            percentage: percent,
            color: AppIcons.getColor(txMeta.category),
            icon: AppIcons.getIcon(txMeta.category),
          ),
        );
      });

      // sort biggest first
      items.sort((a, b) => b.amount.compareTo(a.amount));

      emit(StatsSuccess(totalExpense: totalExpense, categoryItems: items));
    } catch (e) {
      emit(StatsError());
    }
  }
}
