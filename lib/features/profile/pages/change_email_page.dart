import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_bottom_button.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_button_style.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/formatter_utils.dart';
import '../../../core/utils/validator_utils.dart';

/// Change Email: one email field and Next → OTP sent to the phone → success
/// sheet. Pops with the new email once the OTP is right — open with
/// `Go.toForResult<String>`.
class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({super.key, required this.current});

  /// The email on file; typing it again is rejected.
  final String current;

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  /// True while the (mock) change-email request is in flight.
  bool _isLoading = false;

  bool get _hasText => _controller.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    // Rebuild so the button follows empty ↔ filled.
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return AppTexts.emailEmpty;
    if (!ValidatorUtils.isValidEmail(email)) return AppTexts.emailInvalid;
    if (email.toLowerCase() == widget.current.toLowerCase()) {
      return AppTexts.emailSame;
    }
    return null;
  }

  Future<void> _onNext() async {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // Stand-in for the change-email request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isLoading = false);
    final phone = FormatterUtils.maskPhone(UserModel.current.phone);
    final verified = await Go.toForResult<bool>(
      context,
      Pager.otp(
        title: AppTexts.changeEmailPageTitle,
        subtitle: '${AppTexts.otpPhonePrefix}$phone${AppTexts.otpPhoneSuffix}',
        successImage: AppAssets.emailChanged,
        successTitle: AppTexts.emailChangedTitle,
        successMessage: AppTexts.emailChangedMessage,
      ),
    );
    if (verified != true || !mounted) return;
    Navigator.pop(context, _controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.changeEmailPageTitle,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pagePaddingCompact.w,
            vertical: AppSizes.homeTop.h,
          ),
          children: [
            CustomInput(
              controller: _controller,
              label: AppTexts.enterEmailLabel,
              hintText: AppTexts.emailHint,
              keyboardType: TextInputType.emailAddress,
              textInputAction: .done,
              validator: _validate,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomButton(
        text: AppTexts.next,
        onPressed: _hasText ? _onNext : null,
        isLoading: _isLoading,
        style: _hasText ? null : AppButtonStyle.disabled(context),
      ),
    );
  }
}
