import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/extensions/context_extension.dart';
import '../../core/navigation/go.dart';
import '../../core/navigation/tab_back_scope.dart';

/// Figma page header: round grey back button on the left (only when the
/// route can pop), title next to it or centred.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.actions,
    this.centerTitle = false,
    this.showBack = true,
  });

  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final onBack = showBack ? _backAction(context) : null;
    final canBack = onBack != null;
    final padding = AppSizes.pagePaddingCompact.w;
    return AppBar(
      automaticallyImplyLeading: false,
      leading: canBack ? _buildBack(context, onBack) : null,
      leadingWidth: padding + AppSizes.iconButton.r,
      centerTitle: centerTitle,
      titleSpacing: canBack ? AppSizes.homeTitleGap.w : padding,
      title: Text(
        title,
        style: AppTextStyles.bodyXLargeSemiBold.copyWith(
          color: context.colors.textPrimary,
        ),
      ),
      actions: [...?actions, padding.horizontalSpace],
    );
  }

  /// Pop when the route can; inside a bottom-nav tab, go to the Home tab.
  VoidCallback? _backAction(BuildContext context) => Go.canBack(context)
      ? () => Go.back(context)
      : TabBackScope.maybeOf(context);

  Widget _buildBack(BuildContext context, VoidCallback onBack) => Padding(
    padding: EdgeInsets.only(left: AppSizes.pagePaddingCompact.w),
    child: Center(
      child: InkWell(
        onTap: onBack,
        customBorder: const CircleBorder(),
        child: Container(
          width: AppSizes.iconButton.r,
          height: AppSizes.iconButton.r,
          decoration: BoxDecoration(
            shape: .circle,
            color: context.colors.surfaceVariant,
          ),
          child: Icon(
            Icons.chevron_left_rounded,
            size: AppSizes.icon.r,
            color: context.colors.icon,
          ),
        ),
      ),
    ),
  );

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.appBarHeight.h);
}
