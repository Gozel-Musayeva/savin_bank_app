import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/transaction_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_transaction_tile.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../widgets/transaction_type_tabs.dart';

/// History: Outcome / Income switch over the transaction list.
/// Used as the "History" bottom-nav tab and pushed from Home "See All".
class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  TransactionType _type = TransactionType.expense;

  List<TransactionModel> get _items =>
      TransactionModel.transactions.where((t) => t.type == _type).toList();

  @override
  Widget build(BuildContext context) {
    final items = _items;
    final padding = AppSizes.pagePaddingCompact.w;
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.historyTitle,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              padding,
              AppSizes.homeTop.h,
              padding,
              AppSizes.notificationPaddingV.h,
            ),
            child: TransactionTypeTabs(
              selected: _type,
              onChanged: (type) => setState(() => _type = type),
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? Center(
                    child: Text(
                      AppTexts.noTransactions,
                      style: AppTextStyles.bodyMediumRegular.copyWith(
                        color: context.colors.textTertiary,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (_, i) =>
                        CustomTransactionTile(transaction: items[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
