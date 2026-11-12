import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// Placeholder — will be replaced with the real design.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Login'),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.pagePadding.w),
        child: Column(
          children: [
            const Spacer(),
            CustomButton(
              text: 'Sign In',
              onPressed: () => Go.removeAll(context, Pager.main),
            ),
          ],
        ),
      ),
    );
  }
}
