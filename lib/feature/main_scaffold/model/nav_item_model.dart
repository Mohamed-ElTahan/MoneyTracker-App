import 'package:flutter/material.dart';

class NavItemModel {
  final Widget page;
  final String title;
  final String navLabel;
  final IconData icon;

  const NavItemModel({
    required this.page,
    required this.title,
    required this.navLabel,
    required this.icon,
  });
}
