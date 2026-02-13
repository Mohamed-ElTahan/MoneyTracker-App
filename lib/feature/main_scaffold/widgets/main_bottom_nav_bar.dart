import 'package:flutter/material.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/colors_manager.dart';
import '../model/nav_item_model.dart';

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
      color: Theme.of(context).cardColor,
      notchMargin: 8,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navItems.length; i++)
            _BuildNavItem(
              navItem: navItems[i],
              isSelected: selectedIndex == i,
              index: i,
              onItemTapped: (int index) => onItemTapped(index),
            ),
        ],
      ),
    );
  }
}

class _BuildNavItem extends StatelessWidget {
  final NavItemModel navItem;
  final bool isSelected;
  final int index;
  final Function(int) onItemTapped;

  const _BuildNavItem({
    required this.navItem,
    required this.isSelected,
    required this.index,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
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
            AppLocalizations.of(context)!.translate(navItem.navLabel),
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
