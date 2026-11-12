import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../data/models/nav_bar_model.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final NavBarModel item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? AppColors.primary500
        : context.colors.navBarInactive;
    return Expanded(
      child: InkResponse(
        onTap: onTap,
        radius: 32.r,
        child: Column(
          mainAxisSize: .min,
          spacing: 4.h,
          children: [
            Icon(
              isSelected ? item.activeIcon : item.icon,
              size: 24.r,
              color: color,
            ),
            Text(
              item.label,
              style:
                  (isSelected
                          ? AppTextStyles.bodyXSmallBold
                          : AppTextStyles.bodyXSmallMedium)
                      .copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
