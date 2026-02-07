import 'package:flutter/material.dart';
import '../../../../core/theme/colors_manager.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback onEditPressed;
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundColor: Color(0xFFE0F7FA),
              backgroundImage: AssetImage('assets/profileIcon.png'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: ColorsManager.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: onEditPressed,
                  icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(name, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 4),
        Text(email, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
