import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/extension/media_query_extension.dart';
import 'cubit/stats_cubit.dart';
import 'cubit/stats_states.dart';
import 'widgets/donut_chart.dart';
import 'widgets/category_spending_item.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsCubit()..getStatsData(),
      child: const _StatsScreen(),
    );
  }
}

class _StatsScreen extends StatelessWidget {
  const _StatsScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsCubit, StatsStates>(
      builder: (context, state) {
        if (state is StatsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StatsError) {
          return const Center(child: Text('Error'));
        } else if (state is StatsSuccess) {
          final categoryItems = state.categoryItems;
          return categoryItems.isNotEmpty
              ? SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.w(0.05)),
                    child: Column(
                      children: [
                        SizedBox(height: context.h(0.02)),
                        SizedBox(
                          height: context.h(0.3),
                          child: DonutChart(
                            totalAmount:
                                "\$${state.totalExpense.toStringAsFixed(0)}",
                            data: state.categoryItems,
                          ),
                        ),

                        SizedBox(height: context.h(0.02)),

                        // Section Header
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(
                              context,
                            )!.translate(AppStrings.spendingByCategory),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),

                        SizedBox(height: context.h(0.01)),

                        // List Items
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.categoryItems.length,
                            itemBuilder: (context, index) {
                              final item = state.categoryItems[index];
                              return CategorySpendingItem(
                                category: item.category,
                                amount: "\$${item.amount.toStringAsFixed(0)}",
                                percentage:
                                    "${(item.percentage * 100).toStringAsFixed(0)}%",
                                progress: item.percentage,
                                color: item.color,
                                icon: item.icon,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    AppLocalizations.of(
                      context,
                    )!.translate(AppStrings.noExpenses),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
        }

        return const SizedBox();
      },
    );
  }
}
