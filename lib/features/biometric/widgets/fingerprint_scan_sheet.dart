import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_loading.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';

/// Figma "Biometric | Scan" sheet (104:64919). Tapping the fingerprint
/// stands in for a real sensor read; pops with `true` once "scanned".
class FingerprintScanSheet extends StatefulWidget {
  const FingerprintScanSheet({super.key});

  static Future<bool?> show(BuildContext context) => showModalBottomSheet<bool>(
    context: context,
    barrierColor: AppColors.barrier,
    backgroundColor: context.colors.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSizes.radiusSheet.r),
      ),
    ),
    builder: (_) => const FingerprintScanSheet(),
  );

  @override
  State<FingerprintScanSheet> createState() => _FingerprintScanSheetState();
}

class _FingerprintScanSheetState extends State<FingerprintScanSheet> {
  bool _isScanning = false;

  Future<void> _onScan() async {
    if (_isScanning) return;
    setState(() => _isScanning = true);
    // Stand-in for the fingerprint sensor.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSizes.pagePadding.w,
          AppSizes.sheetHandleTop.h,
          AppSizes.pagePadding.w,
          AppSizes.signUpSectionGap.h,
        ),
        child: Column(
          mainAxisSize: .min,
          children: [
            _handle,
            AppSizes.fingerprintTitleTop.verticalSpace,
            Text(
              AppTexts.scanFingerprintTitle,
              textAlign: .center,
              style: AppTextStyles.bodyLargeSemiBold.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            AppSizes.signUpHeaderGap.verticalSpace,
            SizedBox(
              width: AppSizes.successSheetMessageWidth.w,
              child: Text(
                AppTexts.scanFingerprintMessage,
                textAlign: .center,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ),
            AppSizes.fingerprintCircleTop.verticalSpace,
            _fingerprint,
          ],
        ),
      ),
    );
  }

  Widget get _fingerprint => GestureDetector(
    onTap: _onScan,
    child: Container(
      width: AppSizes.fingerprintCircle.r,
      height: AppSizes.fingerprintCircle.r,
      alignment: .center,
      decoration: const BoxDecoration(
        shape: .circle,
        color: AppColors.primary500,
      ),
      child: _isScanning
          ? const CustomLoading(
              size: AppSizes.pinLoader,
              color: AppColors.white,
            )
          : Icon(
              Icons.fingerprint,
              size: AppSizes.fingerprintIcon.r,
              color: AppColors.white,
            ),
    ),
  );

  Widget get _handle => Container(
    width: AppSizes.sheetHandleWidth.w,
    height: AppSizes.sheetHandleHeight.h,
    decoration: BoxDecoration(
      color: context.colors.border,
      borderRadius: BorderRadius.circular(AppSizes.radiusButton),
    ),
  );
}
