import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_info_sheet.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../common/widgets/custom_loading.dart';
import '../../../common/widgets/custom_pin_boxes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../widgets/pin_keypad.dart';

/// Change PIN, fed by the in-app keypad:
/// 1. "Enter Old PIN" — masked field with an eye toggle.
/// 2. "Set Your New PIN" — PIN boxes + "Forgot PIN?".
/// Each step checks itself once the last digit is typed; the new PIN ends
/// with the "Pin Successfully Changed" sheet, then returns to Account.
class ChangePinPage extends StatefulWidget {
  const ChangePinPage({super.key});

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

enum _Step {
  old(AppTexts.enterOldPin, AppTexts.enterOldPinSubtitle),
  fresh(AppTexts.setNewPin, AppTexts.setNewPinSubtitle);

  const _Step(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

class _ChangePinPageState extends State<ChangePinPage> {
  static final _current = UserModel.current.pin;
  static final _length = _current.length;

  final _controller = TextEditingController();
  _Step _step = _Step.old;
  String? _error;

  /// True while the (mock) check is in flight; keypad is locked.
  bool _isBusy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDigit(String digit) {
    if (_isBusy || _controller.text.length >= _length) return;
    _controller.text += digit;
    setState(() => _error = null);
    if (_controller.text.length == _length) _submit();
  }

  void _onBackspace() {
    final text = _controller.text;
    if (_isBusy || text.isEmpty) return;
    _controller.text = text.substring(0, text.length - 1);
    setState(() => _error = null);
  }

  Future<void> _submit() async {
    final pin = _controller.text;
    setState(() => _isBusy = true);
    // Stand-in for the PIN request of each step.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isBusy = false);
    switch (_step) {
      case _Step.old:
        _controller.clear();
        if (pin != _current) {
          setState(() => _error = AppTexts.pinIncorrect);
          return;
        }
        setState(() => _step = _Step.fresh);
      case _Step.fresh:
        if (pin == _current) {
          _controller.clear();
          setState(() => _error = AppTexts.pinSameAsOld);
          return;
        }
        // Boxes stay filled under the sheet, as in Figma. Mock data is
        // const, so the new PIN isn't stored.
        await CustomInfoSheet.show(
          context,
          image: AppAssets.pinChanged,
          title: AppTexts.pinChangedTitle,
          message: AppTexts.pinChangedMessage,
        );
        if (mounted) Go.back(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.changePinTitle,
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSizes.pagePaddingCompact.w,
            AppSizes.pinTop.h,
            AppSizes.pagePaddingCompact.w,
            AppSizes.bottomButtonBottom.h,
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Text(
                _step.title,
                textAlign: .center,
                style: AppTextStyles.bodyLargeSemiBold.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              SizedBox(height: AppSizes.pinSubtitleGap.h),
              Text(
                _step.subtitle,
                textAlign: .center,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
              SizedBox(height: AppSizes.changePinFieldTop.h),
              ...switch (_step) {
                _Step.old => _oldPinField(),
                _Step.fresh => _newPinBoxes(context),
              },
              const Spacer(),
              PinKeypad(onDigit: _onDigit, onBackspace: _onBackspace),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _oldPinField() => [
    CustomInput(
      controller: _controller,
      label: AppTexts.oldPinLabel,
      isPassword: true,
      readOnly: true,
      errorText: _error,
    ),
    if (_isBusy) ...[
      SizedBox(height: AppSizes.helperGap.h),
      const CustomLoading(size: AppSizes.pinLoader),
    ],
  ];

  List<Widget> _newPinBoxes(BuildContext context) => [
    CustomPinBoxes(
      length: _length,
      filled: _controller.text.length,
      hasError: _error != null,
    ),
    if (_isBusy) ...[
      SizedBox(height: AppSizes.helperGap.h),
      const CustomLoading(size: AppSizes.pinLoader),
    ] else if (_error case final error?) ...[
      SizedBox(height: AppSizes.helperGap.h),
      Text(
        error,
        textAlign: .center,
        style: AppTextStyles.bodySmallRegular.copyWith(
          color: context.colorScheme.error,
        ),
      ),
    ],
    SizedBox(height: AppSizes.pinForgotTop.h),
    Center(
      child: GestureDetector(
        // No "forgot PIN" flow yet.
        onTap: () {},
        child: Text(
          AppTexts.forgotPin,
          style: AppTextStyles.bodySmallSemiBold.copyWith(
            color: AppColors.primary500,
          ),
        ),
      ),
    ),
  ];
}
