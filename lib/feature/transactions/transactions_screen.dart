import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/extension/media_query_extension.dart';
import 'cubit/transaction_cubit.dart';
import 'cubit/transaction_state.dart';
import 'widgets/transaction_list_widget.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionCubit()..loadData(),
      child: const _TransactionsScreenBody(),
    );
  }
}

class _TransactionsScreenBody extends StatelessWidget {
  const _TransactionsScreenBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(0.04),
        vertical: context.h(0.02),
      ),
      child: Column(
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(
                context,
              )!.translate(AppStrings.searchTransactions),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) {
              // TODO: Implement search logic in Cubit
            },
          ),

          SizedBox(height: context.h(0.02)),

          // List
          Expanded(
            child: BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TransactionError) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is TransactionSuccess) {
                  if (state.transactions.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(
                          context,
                        )!.translate(AppStrings.noTransactions),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }

                  return TransactionListWidget(
                    transactions: state.transactions,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
