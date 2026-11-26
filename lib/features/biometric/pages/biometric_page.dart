import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_info_sheet.dart';
import '../../../common/widgets/custom_terms_checkbox.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_button_style.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../auth/widgets/auth_header.dart';
import '../widgets/fingerprint_scan_sheet.dart';

/// Figma "Biometric" (104:64741) — shown right after Sign In.
/// Enable → scan sheet (104:64919) → success sheet (108:69018) → Home.
class BiometricPage extends StatefulWidget {
  const BiometricPage({super.key});

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  bool _agreed = true;

  Future<void> _onEnable() async {
    final scanned = await FingerprintScanSheet.show(context);
    if (scanned != true || !mounted) return;
    await CustomInfoSheet.show(
      context,
      image: AppAssets.biometricSuccess,
      title: AppTexts.biometricSuccessTitle,
      message: AppTexts.biometricSuccessMessage,
    );
    if (!mounted) return;
    _goHome();
  }

  void _goHome() => Go.removeAll(context, Pager.main);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSizes.pagePadding.w,
            AppSizes.signUpTop.h,
            AppSizes.pagePadding.w,
            AppSizes.biometricBottom.h,
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              const AuthHeader(
                title: AppTexts.enableBiometrics,
                subtitle: AppTexts.enableBiometricsSubtitle,
              ),
              AppSizes.biometricImageTop.verticalSpace,
              Center(
                child: Image.asset(
                  AppAssets.biometric,
                  width: AppSizes.biometricImage.r,
                  height: AppSizes.biometricImage.r,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.biometricTermsInset.w,
                ),
                child: CustomTermsCheckbox(
                  value: _agreed,
                  onChanged: (v) => setState(() => _agreed = v),
                ),
              ),
              AppSizes.biometricTermsGap.verticalSpace,
              CustomButton(
                text: AppTexts.enable,
                style: _agreed ? null : AppButtonStyle.disabled(context),
                onPressed: _agreed ? _onEnable : null,
              ),
              AppSizes.biometricButtonGap.verticalSpace,
              CustomButton(
                text: AppTexts.later,
                style: AppButtonStyle.outlined(context),
                onPressed: _goHome,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
