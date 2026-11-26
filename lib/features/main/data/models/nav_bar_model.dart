import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../core/constants/app_texts.dart';

/// Bottom navigation tabs (the scan button in the middle is not a tab).
/// Icons are Iconsax (Figma uses Vuesax): `x_copy` = Linear, `x` = Bold.
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
      label: AppTexts.navHome,
      icon: Iconsax.home_2_copy,
      activeIcon: Iconsax.home_2,
    ),
    NavBarModel(
      index: 1,
      label: AppTexts.navCard,
      icon: Iconsax.card_copy,
      activeIcon: Iconsax.card,
    ),
    NavBarModel(
      index: 2,
      label: AppTexts.navHistory,
      icon: Iconsax.receipt_2_copy,
      activeIcon: Iconsax.receipt_2,
    ),
    NavBarModel(
      index: 3,
      label: AppTexts.navAccount,
      icon: Iconsax.profile_circle_copy,
      activeIcon: Iconsax.profile_circle,
    ),
  ];
}
