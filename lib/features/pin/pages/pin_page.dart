import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_loading.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../common/widgets/custom_pin_boxes.dart';
import '../widgets/pin_keypad.dart';

/// Transaction PIN check. Pops with `true` once the right PIN is typed;
/// a wrong PIN shows an error and clears the boxes.
class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  static final _expected = UserModel.current.pin;

  String _entered = '';
  bool _hasError = false;

  /// True while the (mock) PIN check is in flight; keypad is locked.
  bool _isVerifying = false;

  void _onDigit(String digit) {
    if (_isVerifying || _entered.length >= _expected.length) return;
    setState(() {
      _entered += digit;
      _hasError = false;
    });
    if (_entered.length == _expected.length) _verify();
  }

  void _onBackspace() {
    if (_isVerifying || _entered.isEmpty) return;
    setState(() {
      _entered = _entered.substring(0, _entered.length - 1);
      _hasError = false;
    });
  }

  Future<void> _verify() async {
    setState(() => _isVerifying = true);
    // Stand-in for the PIN verification request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    if (_entered == _expected) {
      Navigator.pop(context, true);
      return;
    }
    setState(() {
      _isVerifying = false;
      _entered = '';
      _hasError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.pinTitle, centerTitle: true),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSizes.homePadding.w,
            AppSizes.pinTop.h,
            AppSizes.homePadding.w,
            AppSizes.bottomButtonBottom.h,
          ),
          child: Column(
            children: [
              Text(
                AppTexts.enterPin,
                style: AppTextStyles.bodyLargeSemiBold.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              SizedBox(height: AppSizes.pinSubtitleGap.h),
              Text(
                AppTexts.enterPinSubtitle,
                textAlign: .center,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
              SizedBox(height: AppSizes.pinBoxesTop.h),
              CustomPinBoxes(
                length: _expected.length,
                filled: _entered.length,
                hasError: _hasError,
              ),
              if (_isVerifying) ...[
                SizedBox(height: AppSizes.helperGap.h),
                const CustomLoading(size: AppSizes.pinLoader),
              ] else if (_hasError) ...[
                SizedBox(height: AppSizes.helperGap.h),
                Text(
                  AppTexts.pinIncorrect,
                  style: AppTextStyles.bodySmallRegular.copyWith(
                    color: context.colorScheme.error,
                  ),
                ),
              ],
              SizedBox(height: AppSizes.pinForgotTop.h),
              GestureDetector(
                // No "forgot PIN" flow yet.
                onTap: () {},
                child: Text(
                  AppTexts.forgotPin,
                  style: AppTextStyles.bodySmallSemiBold.copyWith(
                    color: AppColors.primary500,
                  ),
                ),
              ),
              const Spacer(),
              PinKeypad(onDigit: _onDigit, onBackspace: _onBackspace),
            ],
          ),
        ),
      ),
    );
  }
}
