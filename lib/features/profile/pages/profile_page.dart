import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/cubits/theme/theme_cubit.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_tile.dart';

/// Account tab: profile banner, then Settings / Password & Security /
/// Information groups. Rows without a designed screen yet do nothing.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  /// Mock preference — no biometric auth behind it yet.
  bool _biometric = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.accountTitle,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        children: [
          ProfileHeader(
            user: UserModel.current,
            onTap: () => Go.to(context, Pager.detailAccount),
          ),
          _section(AppTexts.settings, [
            SettingsTile.toggle(
              icon: Icons.fingerprint_rounded,
              label: AppTexts.biometricLogin,
              switchValue: _biometric,
              onChanged: (v) => setState(() => _biometric = v),
            ),
            SettingsTile(
              icon: Icons.language_rounded,
              label: AppTexts.language,
              onTap: () => Go.to(context, Pager.language),
            ),
            SettingsTile.toggle(
              icon: Icons.dark_mode_outlined,
              label: AppTexts.darkMode,
              switchValue: context.isDark,
              onChanged: (isDark) => context.read<ThemeCubit>().setMode(
                isDark ? ThemeMode.dark : ThemeMode.light,
              ),
            ),
          ]),
          _section(AppTexts.passwordSecurity, [
            SettingsTile(
              icon: Icons.shield_outlined,
              label: AppTexts.pin,
              onTap: () => Go.to(context, Pager.changePin),
            ),
            SettingsTile(
              icon: Icons.lock_outline_rounded,
              label: AppTexts.password,
              onTap: () => Go.to(context, Pager.changePassword),
            ),
          ]),
          _section(AppTexts.information, [
            SettingsTile(
              icon: Icons.call_outlined,
              label: AppTexts.contactUs,
              onTap: () => Go.to(context, Pager.contactUs),
            ),
            const SettingsTile.value(
              icon: Icons.star_border_rounded,
              label: AppTexts.appVersion,
              value: AppTexts.appVersionNumber,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> tiles) => Padding(
    padding: EdgeInsets.only(top: AppSizes.settingsSectionTop.h),
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: AppSizes.settingsTileGap.h,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyLargeSemiBold.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        ...tiles,
      ],
    ),
  );
}
