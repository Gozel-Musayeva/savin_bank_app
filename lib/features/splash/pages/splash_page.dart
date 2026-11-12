import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_loading.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _waitThenGo();
  }

  Future<void> _waitThenGo() async {
    await Future.delayed(AppDurations.s2);
    if (!mounted) return;
    Go.replace(context, Pager.onboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Stack(
          children: [
            Center(
              child: Text(
                AppTexts.appName,
                style: AppTextStyles.h2.copyWith(color: AppColors.white),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 80.h,
              child: const CustomLoading(),
            ),
          ],
        ),
      ),
    );
  }
}
