import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_bottom_button.dart';
import '../../../common/widgets/custom_info_sheet.dart';
import '../../../common/widgets/custom_loading.dart';
import '../../../common/widgets/custom_pin_boxes.dart';
import '../../../core/constants/app_button_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../data/models/otp_rules.dart';

/// "OTP Code Verification" step shared by flows (Add New Card, Change Email).
///
/// Digits come from the system number keyboard via an invisible field over
/// the boxes. The right code shows the success sheet, then pops with `true`
/// — open with `Go.toForResult<bool>`.
class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.successImage,
    required this.successTitle,
    required this.successMessage,
  });

  /// App-bar title — the flow's name ("Add New Card", "Change Email").
  final String title;

  /// Where the code was sent.
  final String subtitle;

  final String successImage;
  final String successTitle;
  final String successMessage;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  static const _length = OtpRules.code.length;

  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _timer;
  Duration _left = OtpRules.resendAfter;
  bool _hasError = false;

  /// True while the (mock) OTP check is in flight.
  bool _isVerifying = false;

  bool get _isComplete => _controller.text.length == _length;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _left = OtpRules.resendAfter);
    _timer = Timer.periodic(AppDurations.s1, (timer) {
      if (_left <= AppDurations.s1) timer.cancel();
      setState(() => _left -= AppDurations.s1);
    });
  }

  /// Mock "send the code again": clears the boxes and restarts the countdown.
  void _onResend() {
    if (_isVerifying) return;
    _controller.clear();
    _hasError = false;
    _startTimer();
  }

  Future<void> _onNext() async {
    if (_isVerifying || !_isComplete) return;
    _focusNode.unfocus();
    setState(() => _isVerifying = true);
    // Stand-in for the OTP verification request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    if (_controller.text == OtpRules.code) {
      setState(() => _isVerifying = false);
      // The change is done either way; "Ok" or a swipe both close the flow.
      await CustomInfoSheet.show(
        context,
        image: widget.successImage,
        title: widget.successTitle,
        message: widget.successMessage,
      );
      if (mounted) Navigator.pop(context, true);
      return;
    }
    _controller.clear();
    setState(() {
      _isVerifying = false;
      _hasError = true;
    });
  }

  /// 165 s → "( 02 : 45 )".
  String get _countdown {
    String two(int n) => n.toString().padLeft(2, '0');
    return '( ${two(_left.inMinutes)} : ${two(_left.inSeconds % 60)} )';
  }

  @override
  Widget build(BuildContext context) {
    final secondary = AppTextStyles.bodySmallRegular.copyWith(
      color: context.colors.textSecondary,
    );
    return Scaffold(
      appBar: CustomAppBar(title: widget.title, centerTitle: true),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        children: [
          Text(
            AppTexts.otpTitle,
            style: AppTextStyles.bodyLargeSemiBold.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          SizedBox(height: AppSizes.otpSubtitleGap.h),
          Text(widget.subtitle, style: secondary),
          SizedBox(height: AppSizes.otpBoxesTop.h),
          _boxes,
          if (_hasError) ...[
            SizedBox(height: AppSizes.helperGap.h),
            Text(
              AppTexts.otpIncorrect,
              textAlign: .center,
              style: secondary.copyWith(color: context.colorScheme.error),
            ),
          ],
          SizedBox(height: AppSizes.otpTimerTop.h),
          Text(
            '${AppTexts.codeNotSent} $_countdown',
            textAlign: .center,
            style: secondary,
          ),
          SizedBox(height: AppSizes.otpResendTop.h),
          Center(
            child: GestureDetector(
              onTap: _onResend,
              behavior: .opaque,
              child: Text(
                AppTexts.resend,
                style: AppTextStyles.bodySmallSemiBold.copyWith(
                  color: AppColors.primary500,
                ),
              ),
            ),
          ),
          if (_isVerifying) ...[
            SizedBox(height: AppSizes.otpLoaderTop.h),
            const CustomLoading(size: AppSizes.pinLoader),
          ],
        ],
      ),
      bottomNavigationBar: CustomBottomButton(
        text: AppTexts.next,
        onPressed: _isComplete && !_isVerifying ? _onNext : null,
        style: _isComplete ? null : AppButtonStyle.disabled(context),
      ),
    );
  }

  /// Boxes with a transparent number field on top: tapping anywhere on them
  /// opens the keyboard, and the field's text drives how many are filled.
  Widget get _boxes => Stack(
    children: [
      CustomPinBoxes(
        length: _length,
        filled: _controller.text.length,
        hasError: _hasError,
      ),
      Positioned.fill(
        child: Opacity(
          opacity: 0,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: true,
            readOnly: _isVerifying,
            keyboardType: TextInputType.number,
            showCursor: false,
            enableInteractiveSelection: false,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(_length),
            ],
            onChanged: (_) => setState(() => _hasError = false),
            onSubmitted: (_) => _onNext(),
            decoration: const InputDecoration.collapsed(hintText: null),
          ),
        ),
      ),
    ],
  );
}
