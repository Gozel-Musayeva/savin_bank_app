import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/card_model.dart';
import '../../../common/data/models/contact_model.dart';
import '../../../common/data/models/receipt_model.dart';
import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_section_header.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../common/widgets/custom_bottom_button.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/num_extensions.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/currency_input_formatter.dart';
import '../data/models/transfer_rules.dart';
import '../../../common/widgets/custom_funding_card_tile.dart';

/// Transfer Money amount step: who receives it, how much, from which card.
class TransferAmountPage extends StatefulWidget {
  const TransferAmountPage({super.key, required this.receiver});

  /// Carries the destination bank and account number.
  final ContactModel receiver;

  @override
  State<TransferAmountPage> createState() => _TransferAmountPageState();
}

class _TransferAmountPageState extends State<TransferAmountPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  CardModel _card = CardModel.cards.first;

  /// True while the (mock) transfer request is in flight.
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? _validateAmount(String? value) {
    final amount = CurrencyInputFormatter.parse(value ?? '');
    if (amount == 0) return AppTexts.amountEmpty;
    if (amount < TransferRules.minAmount) return AppTexts.amountTooLow;
    if (amount + TransferRules.adminFee > _card.balance) {
      return AppTexts.amountTooHigh;
    }
    return null;
  }

  Future<void> _chooseCard() async {
    final card = await Go.toForResult<CardModel>(
      context,
      Pager.fundingSource(_card),
    );
    if (card == null || !mounted) return;
    setState(() => _card = card);
  }

  Future<void> _onPayNow() async {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    final verified = await Go.toForResult<bool>(context, Pager.pin);
    if (verified != true || !mounted) return;
    setState(() => _isLoading = true);
    // Stand-in for the transfer request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isLoading = false);
    final now = DateTime.now();
    final r = widget.receiver;
    final receipt = ReceiptModel(
      title: AppTexts.transferSuccess,
      refNumber: ReceiptModel.refFrom(now),
      date: now,
      details: [
        ReceiptLine(AppTexts.fundingSource, UserModel.current.fullName),
        const ReceiptLine(
          AppTexts.transactionLabel,
          AppTexts.transferMoneyTitle,
        ),
        ReceiptLine(AppTexts.destinationNumber, r.cardNumber),
        ReceiptLine(AppTexts.destination, r.name),
      ],
      amount: CurrencyInputFormatter.parse(_amountController.text),
      fee: TransferRules.adminFee,
    );
    Go.toAboveRoot(context, Pager.paymentStatus(receipt));
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: AppSizes.pagePaddingCompact.w,
    );
    final titleStyle = AppTextStyles.bodyLargeSemiBold.copyWith(
      color: context.colors.textPrimary,
    );
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.transferMoneyTitle,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: AppSizes.homeTop.h),
          children: [
            Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: .start,
                spacing: AppSizes.homeTitleGap.h,
                children: [
                  Text(AppTexts.destinationNumber, style: titleStyle),
                  _destination(context),
                ],
              ),
            ),
            SizedBox(height: AppSizes.homeSectionGap.h),
            Container(
              height: AppSizes.sectionBand.h,
              color: context.colors.surfaceVariant,
            ),
            SizedBox(height: AppSizes.homeSectionGap.h),
            Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: .stretch,
                children: [
                  Text(AppTexts.transferAmount, style: titleStyle),
                  SizedBox(height: AppSizes.inputLabelGap.h),
                  CustomInput(
                    controller: _amountController,
                    hintText: AppTexts.transferAmountHint,
                    keyboardType: TextInputType.number,
                    textInputAction: .done,
                    inputFormatters: const [
                      CurrencyInputFormatter(
                        maxDigits: TransferRules.maxAmountDigits,
                      ),
                    ],
                    validator: _validateAmount,
                    style: AppTextStyles.bodyLargeSemiBold,
                  ),
                  SizedBox(height: AppSizes.helperGap.h),
                  Text(
                    '${AppTexts.minimalTransfers} '
                    '${TransferRules.minAmount.toCurrency()}',
                    style: AppTextStyles.bodyXSmallRegular.copyWith(
                      color: context.colors.textTertiary,
                    ),
                  ),
                  SizedBox(height: AppSizes.homeSectionGap.h),
                  CustomSectionHeader(
                    title: AppTexts.fundingSource,
                    actionLabel: AppTexts.seeAll,
                    onAction: _chooseCard,
                  ),
                  SizedBox(height: AppSizes.sheetButtonGap.h),
                  CustomFundingCardTile(card: _card, onTap: _chooseCard),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomButton(
        text: AppTexts.payNow,
        onPressed: _onPayNow,
        isLoading: _isLoading,
      ),
    );
  }

  Widget _destination(BuildContext context) {
    final r = widget.receiver;
    return Row(
      spacing: 12.w,
      children: [
        CustomAvatar(url: r.avatarUrl, size: AppSizes.destinationAvatar),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 4.h,
            children: [
              Text(
                r.name,
                style: AppTextStyles.bodyMediumSemiBold.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              Text(
                '${r.bankName} - ${r.cardNumber}',
                maxLines: 1,
                overflow: .ellipsis,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
