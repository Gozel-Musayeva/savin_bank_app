import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_switch_prompt.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  String? _credentialsError;

  bool _isLoading = false;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSignIn() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);
    // Stand-in for the sign-in request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    final ok = UserModel.current.matches(
      username: _usernameController.text,
      password: _passwordController.text,
    );
    if (!ok) {
      _credentialsError = AppTexts.invalidCredentials;
      _isLoading = false;
      setState(() {});
      return;
    }
    Go.removeAll(context, Pager.biometric);
  }

  void _onEdited(String _) {
    if (_credentialsError == null) return;
    _credentialsError = null;
    setState(() {});
  }

  void _onSignUp() => Go.replace(context, Pager.signUp);

  String? _validateUsername(String? v) =>
      (v == null || v.trim().isEmpty) ? AppTexts.usernameEmpty : null;

  String? _validatePassword(String? v) =>
      (v == null || v.isEmpty) ? AppTexts.passwordEmpty : null;

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
              const AuthHeader(subtitle: AppTexts.signInSubtitle),
              AppSizes.signUpFormTop.verticalSpace,
              _form,
              (_credentialsError == null
                      ? AppSizes.signInForgotTop
                      : AppSizes.signInForgotTopError)
                  .verticalSpace,
              _forgotPassword,
              AppSizes.signInButtonTop.verticalSpace,
              CustomButton(
                text: AppTexts.signIn,
                onPressed: _onSignIn,
                isLoading: _isLoading,
              ),
              AppSizes.signUpSectionGap.verticalSpace,
              AuthSwitchPrompt(
                question: AppTexts.noAccount,
                action: AppTexts.signUp,
                onTap: _onSignUp,
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
          controller: _usernameController,
          label: AppTexts.usernameLabel,
          hintText: AppTexts.usernameHint,
          keyboardType: .emailAddress,
          textInputAction: .next,
          validator: _validateUsername,
          onChanged: _onEdited,
        ),
        CustomInput(
          controller: _passwordController,
          label: AppTexts.passwordLabel,
          hintText: AppTexts.passwordHint,
          isPassword: true,
          textInputAction: .done,
          validator: _validatePassword,
          errorText: _credentialsError,
          onChanged: _onEdited,
        ),
      ],
    ),
  );

  Widget get _forgotPassword => Align(
    alignment: .centerRight,
    child: Text(
      AppTexts.forgotPassword,
      style: AppTextStyles.bodyMediumSemiBold.copyWith(
        color: context.colorScheme.primary,
      ),
    ),
  );
}
