import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/app_strings.dart';
import '../../core/utils/app_routes.dart';
import 'cubit/main_scaffold_cubit.dart';
import 'cubit/main_scaffold_state.dart';
import 'main_bottom_nav_bar.dart';
import '../home/home_screen.dart';
import '../profile_settings/profile_and_settings_screen.dart';
import '../stats/stats_screen.dart';
import '../transactions/transactions_screen.dart';
import 'model/nav_item_model.dart';

class MainScaffoldScreen extends StatelessWidget {
  const MainScaffoldScreen({super.key});

  static List<NavItemModel> _getNavItems(BuildContext context) {
    return [
      NavItemModel(
        page: const HomeScreen(),
        appBarTitle: AppLocalizations.of(context)!.translate(AppStrings.home),
        navLabel: AppLocalizations.of(context)!.translate(AppStrings.home),
        icon: Icons.grid_view,
      ),
      NavItemModel(
        page: const TransactionsScreen(),
        appBarTitle: AppLocalizations.of(
          context,
        )!.translate(AppStrings.transactionsHistory),
        navLabel: AppLocalizations.of(context)!.translate(AppStrings.history),
        icon: Icons.history,
      ),
      NavItemModel(
        page: const StatsScreen(),
        appBarTitle: AppLocalizations.of(
          context,
        )!.translate(AppStrings.statistics),
        navLabel: AppLocalizations.of(context)!.translate(AppStrings.stats),
        icon: Icons.bar_chart,
      ),
      NavItemModel(
        page: const ProfileAndSettingsScreen(),
        appBarTitle: AppLocalizations.of(
          context,
        )!.translate(AppStrings.profileSettings),
        navLabel: AppLocalizations.of(context)!.translate(AppStrings.profile),
        icon: Icons.person,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // bloc provider
    return BlocProvider<MainScaffoldCubit>(
      create: (context) => MainScaffoldCubit(),
      child: BlocBuilder<MainScaffoldCubit, MainScaffoldState>(
        builder: (context, state) {
          final int index = state.selectedIndex;
          final navItems = _getNavItems(context);
          return Scaffold(
            appBar: _buildAppBar(
              context: context,
              index: index,
              navItem: navItems[index],
            ),

            // body
            body: navItems[index].page,

            // floating action button
            floatingActionButton: index < 3
                ? FloatingActionButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.addTransaction),
                    child: const Icon(Icons.add),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,

            // bottom navigation bar
            bottomNavigationBar: MainBottomNavBar(
              selectedIndex: index,
              navItems: navItems,
              onItemTapped: (index) =>
                  context.read<MainScaffoldCubit>().changeIndex(index),
            ),
          );
        },
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar({
  required BuildContext context,
  required int index,
  required NavItemModel navItem,
}) {
  if (index == 0) {
    return AppBar(
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.translate(AppStrings.welcomeBack),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            // TODO: get user name from firebase
            "Mohamed ElTahan",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: InkWell(
            onTap: () => context.read<MainScaffoldCubit>().changeIndex(3),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profileIcon.png'),
              radius: 25,
              backgroundColor: Color(0xFFE0F7FA),
            ),
          ),
        ),
      ],
    );
  }

  return AppBar(title: Text(navItem.appBarTitle));
}
