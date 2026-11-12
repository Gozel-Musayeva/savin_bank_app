import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/num_extensions.dart';

/// Placeholder — will be replaced with the real design.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const user = UserModel.current;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pagePadding.w),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 8.h,
            children: [
              Text(
                'Hello, ${user.firstName}',
                style: context.textTheme.bodyLarge,
              ),
              Text(
                user.totalBalance.toCurrency(),
                style: AppTextStyles.h3.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
