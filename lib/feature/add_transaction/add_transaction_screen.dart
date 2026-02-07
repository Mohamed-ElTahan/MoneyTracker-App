import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/extension/media_query_extension.dart';
import '../auth/widgets/primary_button.dart';
import '../auth/widgets/custom_label_field.dart';
import 'widgets/transaction_amount_input.dart';
import 'widgets/transaction_type_toggle.dart';
import 'widgets/transaction_detail_tile.dart';
import 'widgets/select_category_sheet.dart';
import 'widgets/select_payment_method_sheet.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool _isExpense = true;
  late TextEditingController _amountController;
  late TextEditingController _noteController;

  // Category State
  String _selectedCategory = "Select Category";
  IconData _selectedCategoryIcon = Icons.category;
  Color _selectedCategoryColor = Colors.blue;

  // Date State
  DateTime _selectedDate = DateTime.now();

  // Payment Method State
  String _selectedPaymentMethod = "Main Visa Card";
  IconData _selectedPaymentIcon = Icons.credit_card;
  Color _selectedPaymentColor = Colors.green;

  void _showCategorySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectCategorySheet(
        onCategorySelected: (name, icon, color) {
          setState(() {
            _selectedCategory = name;
            _selectedCategoryIcon = icon;
            _selectedCategoryColor = color;
          });
        },
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsManager.primaryBlue,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showPaymentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SelectPaymentMethodSheet(
        onMethodSelected: (name, icon, color) {
          setState(() {
            _selectedPaymentMethod = name;
            _selectedPaymentIcon = icon;
            _selectedPaymentColor = color;
          });
        },
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel", style: Theme.of(context).textTheme.titleMedium),
        ),
        leadingWidth: 80,
        title: const Text("Add Transaction"),
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
              isExpense: _isExpense,
              onTypeChanged: (val) => setState(() => _isExpense = val),
            ),

            SizedBox(height: context.h(0.03)),

            // Fields
            TransactionDetailTile(
              icon: _selectedCategoryIcon,
              iconColor: _selectedCategoryColor,
              iconBgColor: _selectedCategoryColor.withValues(alpha: 0.1),
              label: "Category",
              value: _selectedCategory,
              onTap: _showCategorySheet,
            ),
            SizedBox(height: context.h(0.015)),
            TransactionDetailTile(
              icon: Icons.calendar_today,
              iconColor: Colors.orange,
              iconBgColor: Colors.orange.shade50,
              label: "Date",
              value: DateFormat('EEEE, MMM d').format(_selectedDate),
              trailingIcon: Icons.edit_calendar,
              onTap: _selectDate,
            ),
            SizedBox(height: context.h(0.015)),
            TransactionDetailTile(
              icon: _selectedPaymentIcon,
              iconColor: _selectedPaymentColor,
              iconBgColor: _selectedPaymentColor.withValues(alpha: 0.1),
              label: "Payment Method",
              value: _selectedPaymentMethod,
              onTap: _showPaymentSheet,
            ),

            SizedBox(height: context.h(0.03)),

            // Notes
            const Align(
              alignment: Alignment.centerLeft,
              child: CustomLabelField(label: "Notes"),
            ),
            SizedBox(height: context.h(0.015)),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What was this for?",
                hintStyle: const TextStyle(color: ColorsManager.textGrey),
                filled: true,
                fillColor: ColorsManager.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: context.h(0.03)),

            PrimaryButton(
              text: "Save Transaction",
              onPressed: () {
                // TODO: Save logic
                Navigator.pop(context);
              },
            ),
            SizedBox(height: context.h(0.03)),
          ],
        ),
      ),
    );
  }
}
