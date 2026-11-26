import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_bottom_button.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_button_style.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/card_input_formatters.dart';
import '../../../core/utils/currency_input_formatter.dart';
import '../../../core/utils/validator_utils.dart';
import '../widgets/card_preview.dart';
import '../widgets/save_agree_box.dart';

/// Add New Card: live card preview over number / expiry / daily limit.
/// The button stays grey until every field has a value and the terms are
/// accepted.
class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _limitController = TextEditingController();

  /// True while the (mock) add-card request is in flight.
  bool _isLoading = false;

  /// Terms & Conditions checkbox in the Save & Agree box.
  bool _agreed = false;

  bool get _isFilled =>
      _numberController.text.isNotEmpty &&
      _expiryController.text.isNotEmpty &&
      _limitController.text.isNotEmpty;

  /// Full number + well-formed date → the preview turns into the real card.
  bool get _isCardComplete =>
      ValidatorUtils.isValidCardNumber(_numberController.text) &&
      ValidatorUtils.isValidExpiry(_expiryController.text);

  bool get _canSubmit => _isFilled && _agreed;

  @override
  void initState() {
    super.initState();
    // Rebuild so the preview and the button follow the typed values.
    for (final c in [_numberController, _expiryController, _limitController]) {
      c.addListener(_onChanged);
    }
  }

  void _onChanged() => setState(() {});

  @override
  void dispose() {
    _numberController.dispose();
    _expiryController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  String? _validateNumber(String? value) {
    final number = value ?? '';
    if (number.isEmpty) return AppTexts.cardNumberEmpty;
    if (!ValidatorUtils.isValidCardNumber(number)) {
      return AppTexts.cardNumberInvalid;
    }
    return null;
  }

  String? _validateExpiry(String? value) {
    final expiry = value ?? '';
    if (expiry.isEmpty) return AppTexts.expiryEmpty;
    if (!ValidatorUtils.isValidExpiry(expiry)) return AppTexts.expiryInvalid;
    return null;
  }

  String? _validateLimit(String? value) =>
      CurrencyInputFormatter.parse(value ?? '') <= 0
      ? AppTexts.dailyLimitEmpty
      : null;

  Future<void> _onAdd() async {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // Stand-in for the add-card request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isLoading = false);
    final verified = await Go.toForResult<bool>(
      context,
      Pager.otp(
        title: AppTexts.addNewCard,
        subtitle: AppTexts.otpSubtitle,
        successImage: AppAssets.cardAdded,
        successTitle: AppTexts.cardAddedTitle,
        successMessage: AppTexts.cardAddedMessage,
      ),
    );
    if (verified != true || !mounted) return;
    Go.back(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.addNewCard, centerTitle: true),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pagePaddingCompact.w,
            vertical: AppSizes.homeTop.h,
          ),
          children: [
            CardPreview(
              number: _numberController.text,
              expiry: _expiryController.text,
              filled: _isCardComplete,
            ),
            SizedBox(height: AppSizes.addCardFormTop.h),
            CustomInput(
              controller: _numberController,
              label: AppTexts.cardNumberLabel,
              hintText: AppTexts.cardNumberHint,
              keyboardType: TextInputType.number,
              textInputAction: .next,
              inputFormatters: const [CardNumberInputFormatter()],
              validator: _validateNumber,
            ),
            SizedBox(height: AppSizes.formFieldGap.h),
            CustomInput(
              controller: _expiryController,
              label: AppTexts.expiryLabel,
              hintText: AppTexts.expiryHint,
              keyboardType: TextInputType.number,
              textInputAction: .next,
              inputFormatters: const [ExpiryInputFormatter()],
              validator: _validateExpiry,
            ),
            SizedBox(height: AppSizes.formFieldGap.h),
            CustomInput(
              controller: _limitController,
              label: AppTexts.dailyLimitLabel,
              hintText: AppTexts.dailyLimitHint,
              keyboardType: TextInputType.number,
              textInputAction: .done,
              inputFormatters: const [
                CurrencyInputFormatter(maxDigits: AppSizes.dailyLimitMaxDigits),
              ],
              validator: _validateLimit,
            ),
            // Figma: the agreement appears once the form has values.
            if (_isFilled) ...[
              SizedBox(height: AppSizes.addCardAgreeTop.h),
              SaveAgreeBox(
                value: _agreed,
                onChanged: (v) => setState(() => _agreed = v),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomButton(
        text: AppTexts.addNewCard,
        onPressed: _canSubmit ? _onAdd : null,
        isLoading: _isLoading,
        style: _canSubmit ? null : AppButtonStyle.disabled(context),
      ),
    );
  }
}
