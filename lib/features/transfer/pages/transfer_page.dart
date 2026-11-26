import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/contact_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_bottom_button.dart';
import '../../../common/widgets/custom_search_input.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/receiver_tile.dart';
import '../widgets/recent_transfer_list.dart';

/// Transfer Money: recent recipients, searchable saved receivers and an
/// "Add New Receiver" button pinned to the bottom.
class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  String _query = '';

  List<ContactModel> get _receivers {
    final query = _query.trim().toLowerCase();
    return ContactModel.receivers
        .where(
          (r) =>
              r.name.toLowerCase().contains(query) ||
              r.cardNumber.contains(query),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final receivers = _receivers;
    final padding = AppSizes.pagePaddingCompact.w;
    final titleStyle = AppTextStyles.h6.copyWith(
      color: context.colors.textPrimary,
    );
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.transferMoneyTitle,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: AppSizes.homeTop.h),
        children: [
          const RecentTransferList(),
          Padding(
            padding: EdgeInsets.fromLTRB(
              padding,
              AppSizes.homeSectionGap.h,
              padding,
              0,
            ),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                CustomSearchInput(
                  hintText: AppTexts.searchList,
                  onChanged: (value) => setState(() => _query = value),
                ),
                SizedBox(height: AppSizes.homeSectionGap.h),
                Text(AppTexts.transferList, style: titleStyle),
                if (receivers.isEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: AppSizes.homeSectionGap.h),
                    child: Text(
                      AppTexts.noReceivers,
                      textAlign: .center,
                      style: AppTextStyles.bodyMediumRegular.copyWith(
                        color: context.colors.textTertiary,
                      ),
                    ),
                  )
                else
                  for (final receiver in receivers) ...[
                    ReceiverTile(
                      receiver: receiver,
                      onTap: () =>
                          Go.to(context, Pager.transferAmount(receiver)),
                    ),
                    const Divider(height: 1),
                  ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomButton(
        text: AppTexts.addNewReceiver,
        onPressed: () => Go.to(context, Pager.newReceiver),
      ),
    );
  }
}
