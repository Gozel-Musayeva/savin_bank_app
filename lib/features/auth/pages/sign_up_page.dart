import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_info_sheet.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/validator_utils.dart';

import '../widgets/auth_header.dart';
import '../widgets/auth_switch_prompt.dart';

/// Figma "Sign Up" (69:76732 empty · 73:76846 typing · 103:90669 activate).
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;

  /// True while the (mock) create-account request is in flight.
  bool _isLoading = false;

  static final _phoneFormatter = FilteringTextInputFormatter.allow(
    RegExp(r'[0-9+]'),
  );

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _onSignUp() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);
    // Stand-in for the create-account request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isLoading = false);
    final confirmed = await CustomInfoSheet.show(
      context,
      image: AppAssets.accountCreated,
      title: AppTexts.accountCreatedTitle,
      message: AppTexts.accountCreatedMessage,
    );
    if (confirmed != true || !mounted) return;
    Go.replace(context, Pager.login);
  }

  void _onSignIn() => Go.replace(context, Pager.login);

  // Validators: empty first, format second.
  String? _validateName(String? v) =>
      (v == null || v.trim().isEmpty) ? AppTexts.fullNameEmpty : null;

  String? _validateEmail(String? v) {
    if (v == null || v.isEmpty) return AppTexts.emailEmpty;
    if (!ValidatorUtils.isValidEmail(v)) return AppTexts.emailInvalid;
    return null;
  }

  String? _validatePhone(String? v) {
    if (v == null || v.isEmpty) return AppTexts.phoneEmpty;
    if (!ValidatorUtils.isValidPhone(v)) return AppTexts.phoneInvalid;
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return AppTexts.passwordEmpty;
    if (!ValidatorUtils.isValidPassword(v)) return AppTexts.passwordShort;
    return null;
  }

  String? _validateConfirm(String? v) {
    if (v == null || v.isEmpty) return AppTexts.passwordEmpty;
    if (v != _passwordController.text) return AppTexts.passwordMismatch;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            AppSizes.pagePadding.w,
            AppSizes.signUpTop.h,
            AppSizes.pagePadding.w,
            AppSizes.signUpSectionGap.h,
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              const AuthHeader(subtitle: AppTexts.signUpSubtitle),
              AppSizes.signUpFormTop.verticalSpace,
              _form,
              AppSizes.signUpSectionGap.verticalSpace,
              CustomButton(
                text: AppTexts.signUp,
                onPressed: _onSignUp,
                isLoading: _isLoading,
              ),
              AppSizes.signUpSectionGap.verticalSpace,
              AuthSwitchPrompt(
                question: AppTexts.alreadyHaveAccount,
                action: AppTexts.signIn,
                onTap: _onSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _form => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: AppSizes.formFieldGap.h,
      children: [
        CustomInput(
          controller: _nameController,
          label: AppTexts.fullNameLabel,
          hintText: AppTexts.fullNameHint,
          keyboardType: .name,
          textCapitalization: .words,
          textInputAction: .next,
          validator: _validateName,
        ),
        CustomInput(
          controller: _emailController,
          label: AppTexts.emailLabel,
          hintText: AppTexts.emailHint,
          keyboardType: .emailAddress,
          textInputAction: .next,
          validator: _validateEmail,
        ),
        CustomInput(
          controller: _phoneController,
          label: AppTexts.phoneLabel,
          hintText: AppTexts.phoneHint,
          keyboardType: .phone,
          textInputAction: .next,
          inputFormatters: [_phoneFormatter],
          validator: _validatePhone,
        ),
        CustomInput(
          controller: _passwordController,
          label: AppTexts.passwordLabel,
          hintText: AppTexts.passwordHint,
          isPassword: true,
          textInputAction: .next,
          validator: _validatePassword,
        ),
        CustomInput(
          controller: _confirmController,
          label: AppTexts.confirmPasswordLabel,
          hintText: AppTexts.passwordHint,
          isPassword: true,
          textInputAction: .done,
          validator: _validateConfirm,
        ),
      ],
    ),
  );
}
