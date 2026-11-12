import 'package:flutter/material.dart';

/// Bottom navigation tabs. Swap `IconData` for `AppAssets` SVG paths once the
/// design icons are added.
class NavBarModel {
  const NavBarModel({
    required this.index,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final int index;
  final String label;
  final IconData icon;
  final IconData activeIcon;

  static const items = [
    NavBarModel(
      index: 0,
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    NavBarModel(
      index: 1,
      label: 'Cards',
      icon: Icons.credit_card_outlined,
      activeIcon: Icons.credit_card_rounded,
    ),
    NavBarModel(
      index: 2,
      label: 'Statistics',
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart_rounded,
    ),
    NavBarModel(
      index: 3,
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];
}
