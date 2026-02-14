import 'package:flutter/material.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/localization/app_strings.dart';
import 'model/member_model.dart';
import 'widget/member_card.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  final List<MemberModel> teamMembers = const [
    MemberModel(
      name: 'Mohamed Sherif Abbass',
      role: 'Flutter Developer',
      email: 'mosherieltahan@gmail.com',
      imagePath: 'assets/team_image/mohamed.png',
    ),
    MemberModel(
      name: 'Amir Ashraf Gad',
      role: 'Flutter Developer',
      email: 'amirashraf7620@gmail.com',
      imagePath: 'assets/team_image/amir.png',
    ),
    MemberModel(
      name: 'Abdelrahman Medhat Eldaly',
      role: 'Flutter Developer',
      email: '[EMAIL_ADDRESS]',
      imagePath: 'assets/profileIcon.png',
    ),
    MemberModel(
      name: 'Mahmoud Osama Abo Elhassan',
      role: 'Flutter Developer',
      email: 'mahmoudossama523@gmail.com',
      imagePath: 'assets/team_image/mahmoud.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.translate(AppStrings.aboutUs),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the width and height available for each item
          // 32 is horizontal padding (16 left + 16 right)
          // 10 is crossAxisSpacing
          // Total width available for items = constraints.maxWidth - 32 - 10
          final double itemWidth = (constraints.maxWidth - 32 - 10) / 2;

          // 32 is vertical padding (16 top + 16 bottom)
          // 10 is mainAxisSpacing
          // Total height available for items = constraints.maxHeight - 32 - 10
          final double itemHeight = (constraints.maxHeight - 32 - 10) / 2;

          final double childAspectRatio = itemWidth / itemHeight;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: teamMembers.length,
            physics: const NeverScrollableScrollPhysics(), // Prevent scrolling
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return MemberCard(member: teamMembers[index]);
            },
          );
        },
      ),
    );
  }
}
