import 'package:flutter/material.dart';
import '../../core/theme/colors_manager.dart';
import 'model/nav_item_model.dart';

class MainBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<NavItemModel> navItems;
  final Function(int) onItemTapped;

  const MainBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.navItems,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: ColorsManager.white,
      notchMargin: 8,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navItems.length; i++)
            _buildNavItem(
              navItem: navItems[i],
              isSelected: selectedIndex == i,
              index: i,
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required NavItemModel navItem,
    required bool isSelected,
    required int index,
  }) {
    return InkWell(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            navItem.icon,
            color: isSelected ? ColorsManager.primaryBlue : ColorsManager.grey,
          ),

          Text(
            navItem.navLabel,
            style: TextStyle(
              fontSize: 12,
              color: isSelected
                  ? ColorsManager.primaryBlue
                  : ColorsManager.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
