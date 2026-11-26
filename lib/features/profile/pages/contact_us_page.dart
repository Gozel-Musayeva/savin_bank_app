import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/contact_channel_model.dart';
import '../widgets/contact_row.dart';

/// Contact Us: one labelled row per channel. Tapping copies the value —
/// opening mail / phone / browser needs `url_launcher`, not added yet.
class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  Future<void> _copy(BuildContext context, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text(AppTexts.copied)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.contactUs, centerTitle: true),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        itemCount: ContactChannelModel.channels.length,
        separatorBuilder: (_, _) => SizedBox(height: AppSizes.formFieldGap.h),
        itemBuilder: (context, i) {
          final channel = ContactChannelModel.channels[i];
          return ContactRow(
            channel: channel,
            onTap: () => _copy(context, channel.value),
          );
        },
      ),
    );
  }
}
