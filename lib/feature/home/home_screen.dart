import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/colors_manager.dart';
import '../main_scaffold/cubit/main_scaffold_cubit.dart';
import '../transactions/cubit/transaction_cubit.dart';
import '../transactions/cubit/transaction_state.dart';
import '../transactions/widgets/transaction_list_widget.dart';
import 'widgets/balance_card.dart';
import 'widgets/income_expense_row.dart';
import '../../../../core/extension/media_query_extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionCubit()..loadData(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.w(0.06)),
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is TransactionSuccess) {
              return Column(
                children: [
                  const SizedBox(height: 8),
                  BalanceCard(totalBalance: state.totalBalance),
                  SizedBox(height: context.h(0.03)),
                  IncomeExpenseRow(
                    income: state.totalIncome,
                    expense: state.totalExpense,
                  ),
                  SizedBox(height: context.h(0.03)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.translate(AppStrings.recentTransactions),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.primaryBlue,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            context.read<MainScaffoldCubit>().changeIndex(1),
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.translate(AppStrings.seeAll),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Transactions List
                  TransactionListWidget(transactions: state.recentTransactions),
                  SizedBox(height: context.h(0.1)),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
