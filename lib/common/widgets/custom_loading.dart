import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.size = 32});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: size.r,
        child: const CircularProgressIndicator(
          strokeWidth: 3,
          color: AppColors.primary500,
        ),
      ),
    );
  }
}
