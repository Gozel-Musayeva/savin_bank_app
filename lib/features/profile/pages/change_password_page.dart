import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/app_button_style.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/utils/validator_utils.dart';

/// Change Password: old + new password (eye toggles), a hint under the new
/// one, and Save right below the form. Errors replace the hint.
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  static final _current = UserModel.current.password;

  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  String? _oldError;
  String? _newError;

  /// True while the (mock) change-password request is in flight.
  bool _isLoading = false;

  bool get _isFilled =>
      _oldController.text.isNotEmpty && _newController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    // Rebuild so the button follows the fields, and clear stale errors.
    _oldController.addListener(() => setState(() => _oldError = null));
    _newController.addListener(() => setState(() => _newError = null));
  }

  @override
  void dispose() {
    _oldController.dispose();
    _newController.dispose();
    super.dispose();
  }

  String? _validateOld(String old) {
    if (old.isEmpty) return AppTexts.passwordEmpty;
    if (old != _current) return AppTexts.oldPasswordIncorrect;
    return null;
  }

  String? _validateNew(String value) {
    if (value.isEmpty) return AppTexts.passwordEmpty;
    if (!ValidatorUtils.isValidPassword(value)) return AppTexts.passwordShort;
    if (value == _current) return AppTexts.passwordSameAsOld;
    return null;
  }

  Future<void> _onSave() async {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);
    // Stand-in for the change-password request (it checks the old one).
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    final oldError = _validateOld(_oldController.text);
    final newError = _validateNew(_newController.text);
    setState(() {
      _isLoading = false;
      _oldError = oldError;
      _newError = newError;
    });
    if (oldError != null || newError != null) return;
    // Mock data is const, so the new password isn't stored.
    Go.back(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.changePasswordTitle,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        children: [
          CustomInput(
            controller: _oldController,
            label: AppTexts.oldPasswordLabel,
            hintText: AppTexts.passwordHint,
            isPassword: true,
            textInputAction: .next,
            errorText: _oldError,
          ),
          SizedBox(height: AppSizes.formFieldGap.h),
          CustomInput(
            controller: _newController,
            label: AppTexts.newPasswordLabel,
            hintText: AppTexts.passwordHint,
            isPassword: true,
            textInputAction: .done,
            errorText: _newError,
          ),
          if (_newError == null) ...[
            SizedBox(height: AppSizes.helperGap.h),
            Text(
              AppTexts.newPasswordHelper,
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: context.colors.textTertiary,
              ),
            ),
          ],
          SizedBox(height: AppSizes.changePasswordSaveTop.h),
          CustomButton(
            text: AppTexts.save,
            onPressed: _isFilled ? _onSave : null,
            isLoading: _isLoading,
            style: _isFilled ? null : AppButtonStyle.disabled(context),
          ),
        ],
      ),
    );
  }
}
