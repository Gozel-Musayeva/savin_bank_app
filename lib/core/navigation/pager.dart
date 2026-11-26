import 'package:flutter/widgets.dart';

import '../../common/data/models/card_model.dart';
import '../../common/data/models/contact_model.dart';
import '../../common/data/models/receipt_model.dart';
import '../../features/all_features/pages/all_features_page.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/sign_up_page.dart';
import '../../features/biometric/pages/biometric_page.dart';
import '../../features/cards/pages/add_card_page.dart';
import '../../features/cards/pages/cards_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/main/pages/main_page.dart';
import '../../features/notification/pages/notification_page.dart';
import '../../features/onboard/pages/onboard_auth_page.dart';
import '../../features/onboard/pages/onboard_page.dart';
import '../../features/otp/pages/otp_page.dart';
import '../../features/payment_status/pages/payment_status_page.dart';
import '../../features/pay_bills/data/models/bill_category_model.dart';
import '../../features/pay_bills/data/models/bill_details_model.dart';
import '../../features/pay_bills/pages/bill_details_page.dart';
import '../../features/pay_bills/pages/bill_payment_page.dart';
import '../../features/pay_bills/pages/pay_bills_page.dart';
import '../../features/pin/pages/change_pin_page.dart';
import '../../features/pin/pages/pin_page.dart';
import '../../features/profile/pages/change_email_page.dart';
import '../../features/profile/pages/change_password_page.dart';
import '../../features/profile/pages/contact_us_page.dart';
import '../../features/profile/pages/detail_account_page.dart';
import '../../features/profile/pages/language_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/qr_pay/data/models/merchant_model.dart';
import '../../features/qr_pay/pages/qr_pay_page.dart';
import '../../features/qr_scan/pages/qr_scan_page.dart';
import '../../features/splash/pages/splash_page.dart';
import '../../features/statistics/pages/statistics_page.dart';
import '../../features/transactions/pages/transactions_page.dart';
import '../../features/transfer/pages/funding_source_page.dart';
import '../../features/transfer/pages/new_receiver_page.dart';
import '../../features/transfer/pages/transfer_amount_page.dart';
import '../../features/transfer/pages/transfer_page.dart';

/// Single registry of every screen. Navigate with `Go.to(context, Pager.x)`.
class Pager {
  Pager._();

  static const splash = SplashPage();
  static const onboard = OnboardPage();
  static const onboardAuth = OnboardAuthPage();
  static const login = LoginPage();
  static const signUp = SignUpPage();

  /// Right after Sign In: enable fingerprint login, then Home.
  static const biometric = BiometricPage();
  static const main = MainPage();

  // Bottom nav tabs
  static const home = HomePage();
  static const cards = CardsPage();
  static const statistics = StatisticsPage();
  static const profile = ProfilePage();

  // Pushed screens
  static const transfer = TransferPage();
  static const transactions = TransactionsPage();
  static const allFeatures = AllFeaturesPage();
  static const notification = NotificationPage();
  static const newReceiver = NewReceiverPage();
  static const payBills = PayBillsPage();
  static const qrScan = QrScanPage();
  static const addCard = AddCardPage();
  static const detailAccount = DetailAccountPage();
  static const language = LanguagePage();
  static const changePin = ChangePinPage();
  static const changePassword = ChangePasswordPage();
  static const contactUs = ContactUsPage();

  /// Pops with `true` on the right PIN — open with `Go.toForResult<bool>`.
  static const pin = PinPage();

  // Screens that need arguments
  static Widget transferAmount(ContactModel receiver) =>
      TransferAmountPage(receiver: receiver);

  /// Open with `Go.toAboveRoot` so Back lands on Home.
  static Widget paymentStatus(
    ReceiptModel receipt, {
    bool dashedDividers = false,
  }) => PaymentStatusPage(receipt: receipt, dashedDividers: dashedDividers);

  /// Pops with the chosen card — open with `Go.toForResult<CardModel>`.
  static Widget fundingSource(CardModel selected) =>
      FundingSourcePage(selected: selected);

  static Widget billPayment(BillCategoryModel category) =>
      BillPaymentPage(category: category);

  static Widget billDetails(BillDetailsModel details) =>
      BillDetailsPage(details: details);

  static Widget qrPay(MerchantModel merchant) => QrPayPage(merchant: merchant);

  /// OTP step of a flow; shows the success sheet, then pops with `true` —
  /// open with `Go.toForResult<bool>`.
  static Widget otp({
    required String title,
    required String subtitle,
    required String successImage,
    required String successTitle,
    required String successMessage,
  }) => OtpPage(
    title: title,
    subtitle: subtitle,
    successImage: successImage,
    successTitle: successTitle,
    successMessage: successMessage,
  );

  /// Pops with the new email — open with `Go.toForResult<String>`.
  static Widget changeEmail(String current) =>
      ChangeEmailPage(current: current);
}
