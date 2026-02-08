import 'package:flutter/material.dart';
import '../../core/theme/colors_manager.dart';
import '../../core/extension/media_query_extension.dart';
import '../auth/login/login_screen.dart';
import 'cubit/profile_cubit.dart';
import 'cubit/profile_state.dart';
import 'widgets/custom_logout_button.dart';
import 'widgets/profile_header.dart';
import 'widgets/section_header.dart';
import 'widgets/settings_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAndSettingsScreen extends StatelessWidget {
  const ProfileAndSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileSettingsCubit()..getUserName(),
      child: BlocListener<ProfileSettingsCubit, ProfileState>(
        listener: (context, state) {
          if (state.logoutSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else if (state.logoutError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Logout failed: ${state.logoutError}'),
                backgroundColor: ColorsManager.expenseRed,
              ),
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Profile Header
                BlocBuilder<ProfileSettingsCubit, ProfileState>(
                  builder: (context, state) {
                    if (state.userModel == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ProfileHeader(
                      name: state.userModel!.name,
                      email: state.userModel!.email,
                      onEditPressed: () {},
                    );
                  },
                ),

                SizedBox(height: context.h(0.04)),

                // Preferences
                const SectionHeader(title: "PREFERENCES"),
                SizedBox(height: context.h(0.02)),
                BlocBuilder<ProfileSettingsCubit, ProfileState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        SettingsTile(
                          icon: Icons.dark_mode,
                          title: "Dark Mode",
                          onTap: () => context
                              .read<ProfileSettingsCubit>()
                              .toggleTheme(),
                          trailing: Switch(
                            value: state.isDarkMode,
                            onChanged: (val) {
                              context
                                  .read<ProfileSettingsCubit>()
                                  .toggleTheme();
                            },
                            activeThumbColor: ColorsManager.primaryBlue,
                          ),
                        ),
                        SizedBox(height: context.h(0.015)),
                        SettingsTile(
                          icon: Icons.currency_exchange,
                          title: "Currency",
                          subtitle: state.currency,
                          onTap: () => context
                              .read<ProfileSettingsCubit>()
                              .toggleCurrency(),
                        ),
                        SizedBox(height: context.h(0.015)),
                        SettingsTile(
                          icon: Icons.language,
                          title: "Language",
                          subtitle: state.language,
                          onTap: () => context
                              .read<ProfileSettingsCubit>()
                              .toggleLanguage(),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: context.h(0.015)),
                SettingsTile(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  onTap: () {},
                ),

                SizedBox(height: context.h(0.04)),

                // Logout Button
                BlocBuilder<ProfileSettingsCubit, ProfileState>(
                  builder: (context, state) {
                    return state.isLoggingOut
                        ? const Center(child: CircularProgressIndicator())
                        : CustomLogoutButton(
                            onTap: () {
                              context.read<ProfileSettingsCubit>().logout();
                            },
                          );
                  },
                ),

                SizedBox(height: context.h(0.03)),
                Text(
                  "MoneyWise App v1.0.0",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: context.h(0.01)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
