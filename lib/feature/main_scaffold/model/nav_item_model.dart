import 'package:flutter/material.dart';

import '../../../core/localization/app_strings.dart';
import '../../home/home_screen.dart';
import '../../profile_settings/profile_and_settings_screen.dart';
import '../../stats/stats_screen.dart';
import '../../transactions/transactions_screen.dart';

class NavItemModel {
  final Widget page;
  final String appBarTitle;
  final String navLabel;
  final IconData icon;

  const NavItemModel({
    required this.page,
    required this.appBarTitle,
    required this.navLabel,
    required this.icon,
  });
}

class NavData {
  static List<NavItemModel> getNavItems() {
    return [
      NavItemModel(
        page: const HomeScreen(),
        appBarTitle: AppStrings.home,
        navLabel: AppStrings.home,
        icon: Icons.grid_view,
      ),
      NavItemModel(
        page: const TransactionsScreen(),
        appBarTitle: AppStrings.transactionsHistory,
        navLabel: AppStrings.history,
        icon: Icons.history,
      ),
      NavItemModel(
        page: const StatsScreen(),
        appBarTitle: AppStrings.statistics,
        navLabel: AppStrings.stats,
        icon: Icons.bar_chart,
      ),
      NavItemModel(
        page: const ProfileAndSettingsScreen(),
        appBarTitle: AppStrings.profileSettings,
        navLabel: AppStrings.profile,
        icon: Icons.person,
      ),
    ];
  }
}
