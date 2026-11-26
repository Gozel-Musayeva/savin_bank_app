import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/transaction_model.dart';
import '../../../common/widgets/custom_section_header.dart';
import '../../../common/widgets/custom_search_input.dart';
import '../../../common/widgets/custom_transaction_tile.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

/// "Recent Transaction" header, search field and the filtered list.
class RecentTransactions extends StatefulWidget {
  const RecentTransactions({super.key});

  @override
  State<RecentTransactions> createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {
  String _query = '';

  List<TransactionModel> get _filtered {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return TransactionModel.transactions;
    return TransactionModel.transactions
        .where((t) => t.title.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppSizes.homeTitleGap.h,
      children: [
        CustomSectionHeader(
          title: AppTexts.recentTransaction,
          actionLabel: AppTexts.seeAll,
          onAction: () => Go.to(context, Pager.transactions),
        ),
        CustomSearchInput(
          hintText: AppTexts.searchTransaction,
          onChanged: (value) => setState(() => _query = value),
        ),
        if (items.isEmpty)
          Text(
            AppTexts.noTransactions,
            textAlign: .center,
            style: AppTextStyles.bodyMediumRegular.copyWith(
              color: context.colors.textTertiary,
            ),
          )
        else
          Column(
            children: [
              for (final (i, t) in items.indexed) ...[
                if (i > 0) const Divider(height: 1),
                CustomTransactionTile(transaction: t),
              ],
            ],
          ),
      ],
    );
  }
}
