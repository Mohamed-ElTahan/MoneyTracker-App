import 'package:flutter/material.dart';
import '../../core/theme/colors_manager.dart';
import '../../core/extension/media_query_extension.dart';
import '../../core/utils/app_routes.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/localization/app_strings.dart';
import 'cubit/profile/profile_cubit.dart';
import 'cubit/profile/profile_state.dart';
import 'cubit/setting/setting_cubit.dart';
import 'cubit/setting/setting_state.dart';
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
      create: (context) => ProfileCubit()..getUserModel(),
      child: const _ProfileAndSettingsScreen(),
    );
  }
}

class _ProfileAndSettingsScreen extends StatelessWidget {
  const _ProfileAndSettingsScreen();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLogoutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        } else if (state is ProfileLogoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(
                  context,
                )!.translate(AppStrings.logoutFailed),
              ),
              backgroundColor: ColorsManager.expenseRed,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            // Profile Header
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileSuccess) {
                  return ProfileHeader(
                    name: state.userModel.name,
                    email: state.userModel.email,
                    onEditPressed: () {},
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),

            SizedBox(height: context.h(0.04)),

            // Preferences
            SectionHeader(
              title: AppLocalizations.of(
                context,
              )!.translate(AppStrings.preferences),
            ),
            SizedBox(height: context.h(0.02)),
            BlocBuilder<SettingCubit, SettingState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SettingsTile(
                      icon: Icons.dark_mode,
                      title: AppLocalizations.of(
                        context,
                      )!.translate(AppStrings.darkMode),
                      onTap: () => context.read<SettingCubit>().toggleTheme(),
                      trailing: Switch(
                        value: state.settingModel.isDarkMode,
                        onChanged: (_) =>
                            context.read<SettingCubit>().toggleTheme(),
                        activeThumbColor: ColorsManager.primaryBlue,
                      ),
                    ),
                    SizedBox(height: context.h(0.015)),
                    SettingsTile(
                      icon: Icons.currency_exchange,
                      title: AppLocalizations.of(
                        context,
                      )!.translate(AppStrings.currency),
                      subtitle: state.settingModel.currency,
                      onTap: () =>
                          context.read<SettingCubit>().toggleCurrency(),
                    ),
                    SizedBox(height: context.h(0.015)),
                    SettingsTile(
                      icon: Icons.language,
                      title: AppLocalizations.of(
                        context,
                      )!.translate(AppStrings.language),
                      subtitle: state.settingModel.language,
                      onTap: () =>
                          context.read<SettingCubit>().toggleLanguage(),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: context.h(0.015)),
            SettingsTile(
              icon: Icons.help_outline,
              title: AppLocalizations.of(
                context,
              )!.translate(AppStrings.helpSupport),
              onTap: () {},
            ),

            SizedBox(height: context.h(0.04)),

            // Logout Button
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return state is ProfileLogoutLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomLogoutButton(
                        onTap: () => context.read<ProfileCubit>().logout(),
                      );
              },
            ),

            SizedBox(height: context.h(0.03)),
            Text(
              AppLocalizations.of(context)!.translate(AppStrings.appVersion),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: context.h(0.01)),
          ],
        ),
      ),
    );
  }
}
