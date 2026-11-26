import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/models/contact_model.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_bottom_button.dart';
import '../../../common/widgets/custom_input.dart';
import '../../../core/constants/app_durations.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../../../core/utils/validator_utils.dart';
import '../data/models/bank_model.dart';
import '../widgets/bank_picker_sheet.dart';
import '../widgets/new_receiver_sheet.dart';

/// Transfer to New Receiver: pick the bank, type the account number, Next.
class NewReceiverPage extends StatefulWidget {
  const NewReceiverPage({super.key});

  @override
  State<NewReceiverPage> createState() => _NewReceiverPageState();
}

class _NewReceiverPageState extends State<NewReceiverPage> {
  final _formKey = GlobalKey<FormState>();
  final _bankController = TextEditingController();
  final _numberController = TextEditingController();
  BankModel? _bank;

  /// True while the (mock) account lookup is in flight.
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Rebuild so the clear button appears / disappears with the text.
    _numberController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _bankController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _pickBank() async {
    FocusScope.of(context).unfocus();
    final bank = await BankPickerSheet.show(context, selected: _bank);
    if (bank == null) return;
    _bank = bank;
    _bankController.text = bank.name;
  }

  String? _validateNumber(String? value) {
    final number = value?.trim() ?? '';
    if (number.isEmpty) return AppTexts.accountNumberEmpty;
    if (!ValidatorUtils.isValidAccountNumber(number)) {
      return AppTexts.accountNumberInvalid;
    }
    return null;
  }

  Future<void> _onNext() async {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    final bank = _bank!;
    final number = _numberController.text;
    setState(() => _isLoading = true);
    // Stand-in for the account-holder lookup request.
    await Future.delayed(AppDurations.mockRequest);
    if (!mounted) return;
    setState(() => _isLoading = false);
    final confirmed = await NewReceiverSheet.show(
      context,
      receiver: ContactModel.lookupResult,
      bank: bank,
      number: number,
    );
    if (confirmed != true || !mounted) return;
    // Replace, so Back on the amount step returns to Transfer Money.
    Go.replace(
      context,
      Pager.transferAmount(
        ContactModel.lookupResult.copyWith(
          cardNumber: number,
          bankName: bank.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppTexts.newReceiverTitle,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pagePaddingCompact.w,
            vertical: AppSizes.homeTop.h,
          ),
          children: [
            CustomInput(
              controller: _bankController,
              label: AppTexts.bankNameLabel,
              hintText: AppTexts.bankNameHint,
              readOnly: true,
              onTap: _pickBank,
              validator: (_) => _bank == null ? AppTexts.bankEmpty : null,
              suffixIcon: _suffix(Icons.chevron_right_rounded, _pickBank),
            ),
            SizedBox(height: AppSizes.homeSectionGap.h),
            CustomInput(
              controller: _numberController,
              label: AppTexts.accountNumberLabel,
              hintText: AppTexts.accountNumberHint,
              keyboardType: TextInputType.number,
              textInputAction: .done,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: _validateNumber,
              suffixIcon: _numberController.text.isEmpty
                  ? null
                  : _suffix(Icons.cancel_outlined, _numberController.clear),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomButton(
        text: AppTexts.next,
        onPressed: _onNext,
        isLoading: _isLoading,
      ),
    );
  }

  Widget _suffix(IconData icon, VoidCallback onTap) => Padding(
    padding: EdgeInsets.only(right: AppSizes.inputPadding.w),
    child: GestureDetector(
      onTap: onTap,
      behavior: .opaque,
      child: Icon(icon, size: AppSizes.icon.r, color: context.colors.icon),
    ),
  );
}
