import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_style.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/validator_utils.dart';
import '../data/models/bill_category_model.dart';
import '../data/models/bill_details_model.dart';
import '../data/models/bill_payment_model.dart';
import '../widgets/bill_payment_tile.dart';

/// One bill category (Water, Electricity…): type the customer ID, Next;
/// below it the recent payments — tapping one refills the ID.
class BillPaymentPage extends StatefulWidget {
  const BillPaymentPage({super.key, required this.category});

  final BillCategoryModel category;

  @override
  State<BillPaymentPage> createState() => _BillPaymentPageState();
}

class _BillPaymentPageState extends State<BillPaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  late final _recent = BillPaymentModel.of(widget.category);

  /// True while the (mock) bill lookup is in flight.
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Rebuild so the clear button appears / disappears with the text.
    _idController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  String? _validateId(String? value) {
    final id = value?.trim() ?? '';
    if (id.isEmpty) return AppTexts.customerIdEmpty;
    if (!ValidatorUtils.isValidCustomerId(id)) {
      return AppTexts.customerIdInvalid;
    }
    return null;
  }

  Future<void> _onNext() async {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // Stand-in for the bill lookup request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isLoading = false);
    final details = BillDetailsModel.lookup(
      widget.category,
      _idController.text.trim(),
    );
    Go.to(context, Pager.billDetails(details));
  }

  void _useRecent(BillPaymentModel payment) {
    _idController.text = payment.customerId;
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: AppSizes.pagePaddingCompact.w,
    );
    return Scaffold(
      appBar: CustomAppBar(title: widget.category.title, centerTitle: true),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: AppSizes.homeTop.h),
        children: [
          Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                _form,
                SizedBox(height: AppSizes.homeSectionGap.h),
                CustomButton(
                  text: AppTexts.next,
                  onPressed: _onNext,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
          if (_recent.isNotEmpty) ...[
            SizedBox(height: AppSizes.homeSectionGap.h),
            Container(
              height: AppSizes.sectionBand.h,
              color: context.colors.surfaceVariant,
            ),
            SizedBox(height: AppSizes.homeSectionGap.h),
            Padding(padding: padding, child: _recentList),
          ],
        ],
      ),
    );
  }

  Widget get _form => Form(
    key: _formKey,
    child: CustomInput(
      controller: _idController,
      label: AppTexts.customerIdLabel,
      hintText: AppTexts.customerIdHint,
      keyboardType: TextInputType.number,
      textInputAction: .done,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: _validateId,
      suffixIcon: _idController.text.isEmpty ? null : _clearButton,
    ),
  );

  Widget get _clearButton => Padding(
    padding: EdgeInsets.only(right: AppSizes.inputPadding.w),
    child: GestureDetector(
      onTap: _idController.clear,
      behavior: .opaque,
      child: Icon(
        Icons.cancel_outlined,
        size: AppSizes.icon.r,
        color: context.colors.icon,
      ),
    ),
  );

  Widget get _recentList => Column(
    crossAxisAlignment: .stretch,
    children: [
      Text(
        AppTexts.recent,
        style: AppTextStyles.h6.copyWith(color: context.colors.textPrimary),
      ),
      // No gap here: the first tile's own top padding spaces it from the title.
      for (final (i, payment) in _recent.indexed) ...[
        if (i > 0) const Divider(height: 1),
        BillPaymentTile(payment: payment, onTap: () => _useRecent(payment)),
      ],
    ],
  );
}
