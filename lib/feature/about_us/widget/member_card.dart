import 'package:flutter/material.dart';

import '../model/member_model.dart';

class MemberCard extends StatelessWidget {
  final MemberModel member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 65,
              backgroundImage: AssetImage(member.imagePath),
              backgroundColor: Colors.grey.shade200,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            member.name,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(member.role, style: Theme.of(context).textTheme.bodyMedium),

          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              member.email,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
