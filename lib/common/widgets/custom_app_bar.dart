import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/extensions/context_extension.dart';
import '../../core/navigation/go.dart';

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
    final canBack = showBack && Go.canBack(context);
    return AppBar(
      automaticallyImplyLeading: false,
      leading: canBack ? _buildBack(context) : null,
      centerTitle: centerTitle,
      titleSpacing: canBack ? 0 : 24.w,
      title: Text(title),
      actions: [...?actions, 12.horizontalSpace],
    );
  }

  Widget _buildBack(BuildContext context) => IconButton(
    onPressed: () => Go.back(context),
    icon: Icon(
      Icons.arrow_back_ios_new_rounded,
      size: 20.r,
      color: context.colors.icon,
    ),
  );

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
