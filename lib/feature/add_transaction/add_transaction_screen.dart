import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/extension/media_query_extension.dart';
import '../auth/widgets/primary_button.dart';
import '../auth/widgets/custom_label_field.dart';
import 'widgets/transaction_amount_input.dart';
import 'widgets/transaction_type_toggle.dart';
import 'widgets/transaction_detail_tile.dart';
import 'widgets/select_category_sheet.dart';
import 'cubit/add_transaction_cubit.dart';
import 'cubit/add_transaction_state.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  late TextEditingController _amountController;
  late TextEditingController _noteController;

  @override
  void initState() {
    _amountController = TextEditingController(text: "0.00");
    _noteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _showCategorySheet(BuildContext context, bool isExpense) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectCategorySheet(
        isExpense: isExpense,
        onCategorySelected: (name, icon, color) {
          context.read<AddTransactionCubit>().changeCategory(name, icon, color);
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, DateTime currentDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && context.mounted) {
      context.read<AddTransactionCubit>().changeDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTransactionCubit(),
      child: BlocConsumer<AddTransactionCubit, AddTransactionState>(
        listener: (context, state) {
          if (state.status == AddTransactionStatus.success) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(
                    context,
                  )!.translate(AppStrings.transactionAdded),
                ),
              ),
            );
          } else if (state.status == AddTransactionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ??
                      AppLocalizations.of(
                        context,
                      )!.translate(AppStrings.errorAddingTransaction),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.translate(AppStrings.cancel),
                ),
              ),
              leadingWidth: context.w(0.2),
              title: Text(
                AppLocalizations.of(
                  context,
                )!.translate(AppStrings.addTransaction),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: context.w(0.04)),
              child: Column(
                children: [
                  SizedBox(height: context.h(0.02)),

                  // Amount
                  TransactionAmountInput(controller: _amountController),

                  SizedBox(height: context.h(0.03)),

                  // Toggle
                  TransactionTypeToggle(
                    isExpense: state.isExpense,
                    onTypeChanged: (val) {
                      context.read<AddTransactionCubit>().changeType(val);
                    },
                  ),

                  SizedBox(height: context.h(0.03)),

                  // Fields
                  TransactionDetailTile(
                    icon: state.selectedCategoryIcon,
                    iconColor: state.selectedCategoryColor,
                    label: AppLocalizations.of(
                      context,
                    )!.translate(AppStrings.category),
                    value: AppLocalizations.of(
                      context,
                    )!.translate(state.selectedCategory),
                    onTap: () => _showCategorySheet(context, state.isExpense),
                  ),
                  SizedBox(height: context.h(0.015)),
                  TransactionDetailTile(
                    icon: Icons.calendar_today,
                    iconColor: Colors.orange,
                    label: AppLocalizations.of(
                      context,
                    )!.translate(AppStrings.date),
                    value: DateFormat(
                      'EEEE, MMM d',
                      Localizations.localeOf(context).toString(),
                    ).format(state.selectedDate),
                    trailingIcon: Icons.edit_calendar,
                    onTap: () => _selectDate(context, state.selectedDate),
                  ),

                  SizedBox(height: context.h(0.03)),

                  // Notes
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomLabelField(
                      label: AppLocalizations.of(
                        context,
                      )!.translate(AppStrings.notes),
                    ),
                  ),
                  SizedBox(height: context.h(0.015)),
                  TextField(
                    controller: _noteController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.translate(AppStrings.whatWasThisFor),
                      hintStyle: const TextStyle(color: ColorsManager.textGrey),
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).inputDecorationTheme.fillColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(height: context.h(0.03)),

                  PrimaryButton(
                    text: state.status == AddTransactionStatus.loading
                        ? AppLocalizations.of(
                            context,
                          )!.translate(AppStrings.saving)
                        : AppLocalizations.of(
                            context,
                          )!.translate(AppStrings.saveTransaction),
                    onPressed: state.status == AddTransactionStatus.loading
                        ? () {}
                        : () {
                            context.read<AddTransactionCubit>().saveTransaction(
                              amountStr: _amountController.text,
                              note: _noteController.text,
                            );
                          },
                  ),
                  SizedBox(height: context.h(0.03)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
