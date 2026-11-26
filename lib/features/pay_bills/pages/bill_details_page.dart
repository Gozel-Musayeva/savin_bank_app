import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/receipt_model.dart';
import '../../../common/data/models/user_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
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
import '../data/models/bill_details_model.dart';
import '../widgets/bill_info_card.dart';

/// Bill check before paying: customer, summary with total, optional voucher,
/// then Pay Now → PIN → (mock) payment request → Payment Status.
class BillDetailsPage extends StatefulWidget {
  const BillDetailsPage({super.key, required this.details});

  final BillDetailsModel details;

  @override
  State<BillDetailsPage> createState() => _BillDetailsPageState();
}

class _BillDetailsPageState extends State<BillDetailsPage> {
  final _voucherController = TextEditingController();

  /// True while the (mock) payment request is in flight.
  bool _isLoading = false;

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  Future<void> _onPayNow() async {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    final verified = await Go.toForResult<bool>(context, Pager.pin);
    if (verified != true || !mounted) return;
    setState(() => _isLoading = true);
    // Stand-in for the bill payment request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isLoading = false);
    Go.toAboveRoot(
      context,
      Pager.paymentStatus(_receipt(), dashedDividers: true),
    );
  }

  ReceiptModel _receipt() {
    final d = widget.details;
    final now = DateTime.now();
    return ReceiptModel(
      title: AppTexts.paymentSuccess,
      refNumber: ReceiptModel.refFrom(now),
      date: now,
      details: [
        ReceiptLine(AppTexts.fundingSource, UserModel.current.fullName),
        ReceiptLine(AppTexts.transactionLabel, d.category.transactionName),
        ReceiptLine(AppTexts.customerIdLabel, d.customerId),
      ],
      amount: d.bill,
      fee: d.addCost,
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.details;
    return Scaffold(
      appBar: CustomAppBar(title: d.category.title, centerTitle: true),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePaddingCompact.w,
          vertical: AppSizes.homeTop.h,
        ),
        children: [
          _title(AppTexts.customerDetails),
          BillInfoCard(
            children: [
              BillInfoCard.row(AppTexts.customerName, d.customerName),
              BillInfoCard.row(AppTexts.customerIdLabel, d.customerId),
              BillInfoCard.row(AppTexts.customerCity, d.city),
            ],
          ),
          SizedBox(height: AppSizes.homeSectionGap.h),
          _title(AppTexts.summary),
          BillInfoCard(
            children: [
              BillInfoCard.row(
                AppTexts.transactionLabel,
                d.category.transactionName,
              ),
              BillInfoCard.row(AppTexts.bill, d.bill.toCurrency()),
              BillInfoCard.row(AppTexts.addCost, d.addCost.toCurrency()),
              BillInfoCard.dashed,
              BillInfoCard.row(AppTexts.total, d.total.toCurrency()),
            ],
          ),
          SizedBox(height: AppSizes.homeSectionGap.h),
          _title(AppTexts.voucherCode),
          // Optional; vouchers aren't applied to the total yet (no rules).
          CustomInput(
            controller: _voucherController,
            hintText: AppTexts.voucherHint,
            textCapitalization: .characters,
            textInputAction: .done,
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomButton(
        text: AppTexts.payNow,
        onPressed: _onPayNow,
        isLoading: _isLoading,
      ),
    );
  }

  Widget _title(String text) => Padding(
    padding: EdgeInsets.only(bottom: AppSizes.inputLabelGap.h),
    child: Text(
      text,
      style: AppTextStyles.bodyLargeSemiBold.copyWith(
        color: context.colors.textPrimary,
      ),
    ),
  );
}
