import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

/// Platform-adaptive spinner (Material ring on Android, activity indicator
/// on iOS / macOS). Only for places that actually wait on something.
class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.size = 32,
    this.color = AppColors.primary500,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // `.adaptive` paints the Cupertino ticks with `backgroundColor`, but on
    // Material that same property is the track — so pass it on Apple only.
    final isApple = switch (Theme.of(context).platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => true,
      _ => false,
    };
    return Center(
      child: SizedBox.square(
        dimension: size.r,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(color),
          backgroundColor: isApple ? color : null,
        ),
      ),
    );
  }
}
