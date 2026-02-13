import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/app_routes.dart';
import '../profile_settings/cubit/profile/profile_cubit.dart';
import 'cubit/main_scaffold_cubit.dart';
import 'cubit/main_scaffold_state.dart';
import 'widgets/main_bottom_nav_bar.dart';
import 'model/nav_item_model.dart';
import 'widgets/main_app_bar.dart';

class MainScaffoldScreen extends StatelessWidget {
  const MainScaffoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainScaffoldCubit>(
          create: (context) => MainScaffoldCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit()..getUserModel(),
        ),
      ],
      child: const _MainScaffoldScreen(),
    );
  }
}

class _MainScaffoldScreen extends StatelessWidget {
  const _MainScaffoldScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScaffoldCubit, MainScaffoldState>(
      builder: (context, state) {
        final int index = state.index;
        final navItems = NavData.getNavItems();
        return Scaffold(
          appBar: MainAppBar(index: index, navItem: navItems[index]),

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
    );
  }
}
