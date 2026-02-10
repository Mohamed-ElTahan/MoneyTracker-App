import 'package:flutter/material.dart';

class NavItemModel {
  final Widget page;
  final String appBarTitle;
  final String navLabel;
  final IconData icon;

  const NavItemModel({
    required this.page,
    required this.appBarTitle,
    required this.navLabel,
    required this.icon,
  });
}
