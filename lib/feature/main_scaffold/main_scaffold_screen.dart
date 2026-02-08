import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  static const List<NavItemModel> _navItems = [
    NavItemModel(
      page: HomeScreen(),
      title: "Home",
      navLabel: "Home",
      icon: Icons.grid_view,
    ),
    NavItemModel(
      page: TransactionsScreen(),
      title: "Transactions History",
      navLabel: "History",
      icon: Icons.history,
    ),
    NavItemModel(
      page: StatsScreen(),
      title: "Statistics",
      navLabel: "Stats",
      icon: Icons.bar_chart,
    ),
    NavItemModel(
      page: ProfileAndSettingsScreen(),
      title: "Profile & Settings",
      navLabel: "Profile",
      icon: Icons.person,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // bloc provider
    return BlocProvider<MainScaffoldCubit>(
      create: (context) => MainScaffoldCubit(),
      child: BlocBuilder<MainScaffoldCubit, MainScaffoldState>(
        builder: (context, state) {
          final int index = state.selectedIndex;
          return Scaffold(
            appBar: _buildAppBar(
              context: context,
              index: index,
              navItem: _navItems[index],
            ),

            // body
            body: _navItems[index].page,

            // floating action button
            floatingActionButton: index < 2
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
              navItems: _navItems,
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
          Text("Welcome back,", style: Theme.of(context).textTheme.bodyMedium),
          Text(
            // TODO: get user name from Hive
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
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFE0F7FA),
              child: Icon(Icons.person, color: Color(0xFF006064)),
            ),
          ),
        ),
      ],
    );
  }

  return AppBar(title: Text(navItem.title));
}
