import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/onboard_model.dart';

/// Placeholder — will be replaced with the real design.
class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final page = OnboardModel.pages.first;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.pagePadding.w),
          child: Column(
            spacing: 16.h,
            children: [
              const Spacer(),
              Text(
                page.title,
                textAlign: .center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                page.description,
                textAlign: .center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              CustomButton(
                text: 'Get Started',
                onPressed: () => Go.replace(context, Pager.login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
