import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../common/widgets/custom_info_sheet.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// Detail Account: avatar, name, then the account fields read-only.
/// The pen on Email asks for confirmation before changing it.
class DetailAccountPage extends StatefulWidget {
  const DetailAccountPage({super.key});

  @override
  State<DetailAccountPage> createState() => _DetailAccountPageState();
}

class _DetailAccountPageState extends State<DetailAccountPage> {
  static const _user = UserModel.current;

  final _nameController = TextEditingController(text: _user.fullName);
  final _emailController = TextEditingController(text: _user.email);
  final _phoneController = TextEditingController(text: _user.phone);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _onChangeEmail() async {
    final confirmed = await CustomInfoSheet.show(
      context,
      image: AppAssets.changeEmail,
      title: AppTexts.changeEmailTitle,
      message: AppTexts.changeEmailMessage,
      primaryText: AppTexts.continueText,
      secondaryText: AppTexts.cancel,
    );
    if (confirmed != true || !mounted) return;
    final email = await Go.toForResult<String>(
      context,
      Pager.changeEmail(_emailController.text),
    );
    // Mock data is const, so the new email only lives on this screen.
    if (email != null && mounted) _emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.detailAccountTitle,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        children: [
          Center(
            child: CustomAvatar(
              url: _user.avatarUrl,
              size: AppSizes.detailAvatar,
            ),
          ),
          SizedBox(height: AppSizes.detailNameGap.h),
          Text(
            _user.fullName,
            textAlign: .center,
            style: AppTextStyles.bodyLargeSemiBold.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
          SizedBox(height: AppSizes.detailFormTop.h),
          _field(_nameController, AppTexts.fullNameLabel),
          SizedBox(height: AppSizes.formFieldGap.h),
          _field(_emailController, AppTexts.emailLabel, suffix: _editButton()),
          SizedBox(height: AppSizes.formFieldGap.h),
          _field(_phoneController, AppTexts.phoneLabel),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    Widget? suffix,
  }) => CustomInput(
    controller: controller,
    label: label,
    readOnly: true,
    highlightFilled: false,
    suffixIcon: suffix,
  );

  Widget _editButton() => Padding(
    padding: EdgeInsets.only(right: AppSizes.inputPadding.w),
    child: GestureDetector(
      onTap: _onChangeEmail,
      behavior: .opaque,
      child: Icon(
        Icons.edit_square,
        size: AppSizes.inputIcon.r,
        color: AppColors.primary500,
      ),
    ),
  );
}
