import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';

class SelectCategorySheet extends StatelessWidget {
  final Function(String, IconData, Color) onCategorySelected;

  const SelectCategorySheet({super.key, required this.onCategorySelected});

  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'Food & Drink',
      'icon': Icons.fastfood,
      'color': ColorsManager.expenseRed,
    },
    {'name': 'Shopping', 'icon': Icons.shopping_bag, 'color': Colors.blue},
    {
      'name': 'Transport',
      'icon': Icons.directions_car,
      'color': ColorsManager.successGreen,
    },
    {'name': 'Entertainment', 'icon': Icons.movie, 'color': Colors.orange},
    {
      'name': 'Bills & Utilities',
      'icon': Icons.receipt_long,
      'color': Colors.purple,
    },
    {'name': 'Health', 'icon': Icons.medical_services, 'color': Colors.teal},
    {
      'name': 'Others',
      'icon': Icons.more_horiz,
      'color': ColorsManager.textGrey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      // Half screen height
      height: MediaQuery.of(context).size.height * 0.5,
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
            "Select Category",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final cat = categories[index];
                return GestureDetector(
                  onTap: () {
                    onCategorySelected(cat['name'], cat['icon'], cat['color']);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ColorsManager.lightGrey.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: (cat['color'] as Color).withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            cat['icon'] as IconData,
                            color: cat['color'] as Color,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cat['name'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
