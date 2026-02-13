import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/app_strings.dart';
import '../../profile_settings/cubit/profile/profile_cubit.dart';
import '../../profile_settings/cubit/profile/profile_state.dart';
import '../cubit/main_scaffold_cubit.dart';
import '../model/nav_item_model.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int index;
  final NavItemModel navItem;
  const MainAppBar({super.key, required this.index, required this.navItem});

  @override
  Widget build(BuildContext context) {
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
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess) {
                  return Text(
                    state.userModel.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => context.read<MainScaffoldCubit>().changeIndex(3),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/profileIcon.png'),
                radius: 25,
                backgroundColor: Color(0xFFE0F7FA),
              ),
            ),
          ),
        ],
      );
    }

    return AppBar(
      title: Text(AppLocalizations.of(context)!.translate(navItem.appBarTitle)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
