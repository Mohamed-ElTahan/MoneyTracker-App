import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';

class SelectPaymentMethodSheet extends StatelessWidget {
  final Function(String, IconData, Color) onMethodSelected;

  const SelectPaymentMethodSheet({super.key, required this.onMethodSelected});

  final List<Map<String, dynamic>> methods = const [
    {
      'name': 'Main Visa Card',
      'icon': Icons.credit_card,
      'color': Colors.green,
    },
    {
      'name': 'Cash Wallet',
      'icon': Icons.account_balance_wallet,
      'color': Colors.amber,
    },
    {
      'name': 'Bank Account',
      'icon': Icons.account_balance,
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ColorsManager.lightGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Select Payment Method",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: methods.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final method = methods[index];
                return GestureDetector(
                  onTap: () {
                    onMethodSelected(
                      method['name'],
                      method['icon'],
                      method['color'],
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorsManager.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ColorsManager.lightGrey.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (method['color'] as Color).withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            method['icon'] as IconData,
                            color: method['color'] as Color,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          method['name'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.textDark,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          color: ColorsManager.textGrey,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
