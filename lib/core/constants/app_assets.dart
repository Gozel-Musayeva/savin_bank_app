/// Every asset path in the app. Drop the file into `assets/icons` or
/// `assets/images` (kebab-case), add one line here, use the constant.
class AppAssets {
  AppAssets._();

  static const _icons = 'assets/icons';
  static const _images = 'assets/images';

  // Icons
  static const logo = '$_icons/logo.svg';
  static const eyeShow = '$_icons/eye-show.svg';
  static const eyeHide = '$_icons/eye-hide.svg';
  static const arrowLeft = '$_icons/arrow-left.svg';
  static const flash = '$_icons/flash.svg';
  static const galleryAdd = '$_icons/gallery-add.svg';

  // Images
  static const onboardFirst = '$_images/onboard-first.png';
  static const onboardSecond = '$_images/onboard-second.png';
  static const accountCreated = '$_images/account-created.png';
  static const cardAdded = '$_images/card-added.png';
  static const changeEmail = '$_images/change-email.png';
  static const emailChanged = '$_images/email-changed.png';
  static const pinChanged = '$_images/pin-changed.png';
  static const cardVisaBlue = '$_images/card-visa-blue.png';
  static const merchantMcdonalds = '$_images/merchant-mcdonalds.png';

  /// Figma "Security-rafiki 1" (108:68288) — Enable Biometrics.
  static const biometric = '$_images/biometric.png';

  /// Figma "Illustration" (108:69026) — biometric success sheet.
  static const biometricSuccess = '$_images/biometric-success.png';
}
