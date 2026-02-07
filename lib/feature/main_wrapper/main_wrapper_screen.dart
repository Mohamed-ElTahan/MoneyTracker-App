import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/widgets/custom_bottom_app_bar.dart';
import '../add_transaction/add_transaction_screen.dart';
import '../home/home_screen.dart';
import '../profile_settings/profile_and_settings_screen.dart';
import '../stats/stats_screen.dart';
import '../transactions/transactions_screen.dart';
import 'cubit/main_wrapper_cubit.dart';

class MainWrapperScreen extends StatelessWidget {
  const MainWrapperScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    TransactionsScreen(),
    StatsScreen(),
    ProfileAndSettingsScreen(),
  ];

  final List<String> _appBar = const [
    "Home",
    "Transactions History",
    "Statistics",
    "Profile & Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainWrapperCubit(),
      child: BlocBuilder<MainWrapperCubit, MainWrapperState>(
        builder: (context, state) {
          // Show FAB only on Home (0) and History (1)
          final bool showFab =
              state.selectedIndex == 0 || state.selectedIndex == 1;

          return Scaffold(
            appBar: state.selectedIndex == 0
                ? AppBar(
                    centerTitle: false,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back,",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          "Mohamed ElTahan",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileAndSettingsScreen(),
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xFFE0F7FA),
                            child: Icon(Icons.person, color: Color(0xFF006064)),
                          ),
                        ),
                      ),
                    ],
                  )
                : AppBar(title: Text(_appBar[state.selectedIndex])),
            body: _screens[state.selectedIndex],
            floatingActionButton: showFab
                ? FloatingActionButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddTransactionScreen(),
                      ),
                    ),
                    child: const Icon(Icons.add),
                  )
                : null,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: CustomBottomAppBar(
              selectedIndex: state.selectedIndex,
              onItemTapped: (index) {
                context.read<MainWrapperCubit>().changeIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
