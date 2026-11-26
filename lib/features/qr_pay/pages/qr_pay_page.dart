import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/card_model.dart';
import '../../../common/data/models/receipt_model.dart';
import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_bottom_button.dart';
import '../../../common/widgets/custom_funding_card_tile.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../common/widgets/custom_section_header.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/num_extensions.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/currency_input_formatter.dart';
import '../data/models/merchant_model.dart';

/// QR Pay: the scanned merchant, the bill amount (prefilled from the QR,
/// editable) and the card it's paid from. Pay Now → PIN → (mock) payment
/// request → Payment Status.
class QrPayPage extends StatefulWidget {
  const QrPayPage({super.key, required this.merchant});

  final MerchantModel merchant;

  @override
  State<QrPayPage> createState() => _QrPayPageState();
}

class _QrPayPageState extends State<QrPayPage> {
  final _formKey = GlobalKey<FormState>();
  late final _amountController = TextEditingController(
    text: widget.merchant.billAmount.toCurrency(),
  );
  CardModel _card = CardModel.cards.first;

  /// True while the (mock) payment request is in flight.
  bool _isLoading = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? _validateAmount(String? value) {
    final amount = CurrencyInputFormatter.parse(value ?? '');
    if (amount == 0) return AppTexts.amountEmpty;
    if (amount > _card.balance) return AppTexts.amountTooHigh;
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
    // Stand-in for the QR payment request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isLoading = false);
    final now = DateTime.now();
    final receipt = ReceiptModel(
      title: AppTexts.paymentSuccess,
      refNumber: ReceiptModel.refFrom(now),
      date: now,
      details: [
        ReceiptLine(AppTexts.fundingSource, UserModel.current.fullName),
        const ReceiptLine(AppTexts.transactionLabel, AppTexts.qrPay),
        ReceiptLine(AppTexts.merchant, widget.merchant.name),
      ],
      amount: CurrencyInputFormatter.parse(_amountController.text),
      fee: 0,
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
      appBar: const CustomAppBar(title: AppTexts.qrPay, centerTitle: true),
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
                  Text(AppTexts.merchantInformation, style: titleStyle),
                  _merchant(context),
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
                  Text(AppTexts.billAmount, style: titleStyle),
                  SizedBox(height: AppSizes.inputLabelGap.h),
                  CustomInput(
                    controller: _amountController,
                    hintText: AppTexts.transferAmountHint,
                    keyboardType: TextInputType.number,
                    textInputAction: .done,
                    inputFormatters: const [
                      CurrencyInputFormatter(
                        maxDigits: MerchantModel.maxAmountDigits,
                      ),
                    ],
                    validator: _validateAmount,
                    style: AppTextStyles.bodyLargeSemiBold,
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

  Widget _merchant(BuildContext context) {
    final m = widget.merchant;
    final size = AppSizes.destinationAvatar.r;
    return Row(
      spacing: 12.w,
      children: [
        ClipOval(
          child: Image.asset(m.logo, width: size, height: size, fit: .cover),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 4.h,
            children: [
              Text(
                m.name,
                maxLines: 1,
                overflow: .ellipsis,
                style: AppTextStyles.bodyMediumSemiBold.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
              Text(
                m.location,
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
