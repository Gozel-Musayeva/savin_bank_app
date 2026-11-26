import 'dart:ui';

class AppSizes {
  AppSizes._();

  /// Frame size of the Figma design. Update when the designs arrive.
  static const figmaDesignSize = Size(375, 812);

  // Page paddings
  static const double pagePadding = 20;

  // Radii
  static const double radiusSmall = 8;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusCard = 20;
  static const double radiusButton = 100;
  static const double radiusInput = 10;
  static const double radiusSheet = 20;
  static const double buttonHeight = 51.2;

  // Loading indicators
  static const double buttonLoader = 22;
  static const double pinLoader = 28;

  // Inputs
  static const double inputPadding = 16;
  static const double inputPasswordPaddingV = 14;
  static const double inputIcon = 20;
  static const double inputLabelGap = 8;
  static const double formFieldGap = 16;

  // Bottom sheet
  static const double sheetHandleWidth = 42;
  static const double sheetHandleHeight = 6;
  static const double sheetHandleTop = 8;
  static const double sheetIllustration = 140;

  // Logo
  static const double logoSize = 32;
  static const double logoSizeLarge = 40;
  static const double logoGap = 12;

  // Onboard (Figma frame coordinates, measured from the screen edges)
  static const double onboardLogoTop = 77;
  static const double onboardTitleGap = 4;
  static const double onboardActionsSpacing = 16;

  // Sign Up (Figma "Sign Up | Empty", 69:76732 — gaps between blocks)
  static const double signUpTop = 57;
  static const double signUpHeaderGap = 8;
  static const double signUpSubtitleWidth = 258;
  static const double signUpFormTop = 27;
  static const double signUpSectionGap = 24;

  // Sign In (Figma "Sign In | Empty", 104:64253 — header/form as Sign Up)
  static const double signInForgotTop = 20;
  static const double signInForgotTopError = 16; // "Sign In | Error"
  static const double signInButtonTop = 32;

  // Enable Biometrics (Figma "Biometric", 104:64741 · scan sheet 104:64919)
  static const double biometricImageTop = 63;
  static const double biometricImage = 252;
  static const double biometricTermsInset = 20;
  static const double biometricTermsGap = 16;
  static const double biometricButtonGap = 12;
  static const double biometricBottom = 15;
  static const double fingerprintTitleTop = 46;
  static const double fingerprintCircleTop = 16;
  static const double fingerprintCircle = 80;
  static const double fingerprintIcon = 48;

  // Success sheet (Figma 103:90739 — account created, card added)
  static const double successSheetTop = 24;
  static const double successSheetTitleTop = 20;
  static const double successSheetMessageWidth = 283;

  // Home (Figma "Home" frame)
  static const double homePadding = 24;
  static const double homeTop = 16;
  static const double homeSectionGap = 24;
  static const double homeTitleGap = 16;
  static const double avatar = 40;
  static const double iconButton = 40;
  static const double icon = 24;
  static const double iconSmall = 20;
  static const double bankCardHeight = 198;
  static const double bankCardPadding = 16;
  static const double bankCardGap = 12;
  static const double bankCardViewport = 0.84;

  // Bank card pattern: 10×10 grid of squares repeated over the card.
  static const double cardPatternCell = 7.7;
  static const double cardPatternOffsetX = 2.7;

  // My Cards (Figma "My Cards")
  static const double myCardHeight = 198;
  static const double myCardGap = 16;
  static const double addCardHeight = 60;

  // Add New Card: digit counts for the card-number / limit fields.
  static const int cardNumberLength = 16;
  static const int cardNumberGroup = 4;
  static const int dailyLimitMaxDigits = 12;
  static const double addCardFormTop = 20;
  static const double addCardAgreeTop = 16;
  static const double agreeDividerGap = 12;

  // OTP verification (Figma "Add New Card" OTP step)
  static const double otpSubtitleGap = 12;
  static const double otpBoxesTop = 32;
  static const double otpTimerTop = 20;
  static const double otpResendTop = 8;
  static const double otpLoaderTop = 40;
  static const double pageDot = 6;
  static const double pageDotActive = 18;
  static const double quickActionBox = 56;
  static const double contactAvatar = 56;
  static const double contactWidth = 64;
  static const double transactionIconBox = 54;
  static const double transactionPaddingV = 16;
  static const double transactionTextGap = 8;

  // App bar / page side padding (every Figma screen: content 20 from edge)
  static const double appBarHeight = 56;
  static const double pagePaddingCompact = 20;

  // Features (Figma "Features" frame)
  static const double featureIconBox = 52;
  static const double featureLabelGap = 8;
  static const double featureRowGap = 20;
  static const double featureColumns = 4;

  // Notification (Figma "Notification" frame)
  static const double notificationPaddingV = 16;
  static const double notificationIconGap = 12;
  static const double notificationTextGap = 4;

  // Search field (pill, Figma "Search")
  static const double searchHeight = 46;

  // Transfer Money (Figma "Transfer Money" frame)
  static const double recentAvatar = 60;
  static const double recentItemWidth = 72;
  static const double recentItemGap = 14;
  static const double receiverAvatar = 50;
  static const double receiverPaddingV = 16;
  static const double bottomButtonPadding = 16;

  /// Gap under a page's pinned button, above the safe-area inset.
  static const double bottomButtonBottom = 44;

  // New Receiver sheet (Figma "New Receiver")
  static const double receiverCardPadding = 20;
  static const double receiverCardAvatar = 52;
  static const double receiverCardRing = 4;
  static const double sheetButtonGap = 12;

  // Transfer amount (Figma "Transfer Money" amount step)
  static const double destinationAvatar = 48;
  static const double sectionBand = 8;
  static const double fundingCardPadding = 14;
  static const double fundingBrandWidth = 70;
  static const double fundingVerifiedIcon = 16;
  static const double helperGap = 8;

  // Segmented tabs (History Outcome / Income)
  static const double segmentHeight = 50;
  static const double segmentPadding = 4;

  // Payment status (Figma "Payment Status" frame)
  static const double statusIcon = 56;
  static const double statusIconRing = 12;
  static const double statusCheckIcon = 32;
  static const double statusTitleTop = 16;
  static const double receiptPadding = 16;
  static const double receiptRowGap = 14;

  // Dashed separator (bill summary)
  static const double dashWidth = 6;
  static const double dashGap = 4;
  static const double dashedLinePaddingV = 2;

  // PIN (Figma "PIN" frame)
  static const double pinTop = 24;
  static const double pinBoxesTop = 48;
  static const double pinBoxHeight = 64;
  static const double pinBoxGap = 16;
  static const double pinDot = 12;
  static const double pinForgotTop = 20;
  static const double keypadKeyHeight = 60;
  static const double keypadRowGap = 16;
  static const double changePinFieldTop = 34;
  static const double pinSubtitleGap = 12;

  // Account (Figma "Account" frame)
  static const double profileHeaderPadding = 20;
  static const double profileHeaderPaddingV = 22;
  static const double profileNameGap = 8;
  static const double profileAvatar = 56;
  static const double profileAvatarGap = 12;
  static const double settingsTileHeight = 60;
  static const double settingsIconBox = 38;
  static const double settingsToggleWidth = 40;
  static const double settingsToggleHeight = 24;
  static const double settingsTileGap = 16;
  static const double settingsIconGap = 12;
  static const double settingsSectionTop = 24;
  static const double settingsTitleGap = 16;

  // Detail Account (Figma "Detail Account" frame)
  static const double detailAvatar = 80;
  static const double detailNameGap = 8;
  static const double detailFormTop = 24;

  // Change Password (Figma "Change Password" frame)
  static const double changePasswordSaveTop = 32;

  // Language (Figma "Language" frame)
  static const double languageFlag = 32;
  static const double languageFlagGap = 16;
  static const double languageRadio = 24;
  static const double languageRadioDot = 12;

  // Bottom nav
  static const double navBarHeight = 64;
  static const double navScanButton = 72;
  static const double navScanIcon = 32;

  // QR scanner
  static const double scanWindow = 250;
  static const double scanWindowRadius = 20;
  static const double scanCornerLength = 40;
  static const double scanCornerStroke = 4;

  /// Gap between the gallery button and the top of the pay-options panel.
  static const double scanGalleryBottom = 20;
  static const double scanPanelPaddingV = 24;
  static const double scanOptionButton = 44;

  /// How far the scan button rises above the top edge of the bar.
  static const double navScanRaise = 44;
}
