import 'package:flutter/material.dart';

/// Raw colour palette. Widgets that must flip between light/dark mode should
/// NOT use these directly — read them through `context.colors` /
/// `context.colorScheme` instead (see `app_theme_colors.dart`).
class AppColors {
  AppColors._();

  static const transparent = Colors.transparent;
  static const white = Color(0xffFFFFFF);
  static const black = Color(0xff000000);

  /// Secondary text on the gradient bank cards — white at 70 %.
  static const white70 = Color(0xB3FFFFFF);

  /// Modal barrier behind sheets/dialogs — Black 500 at 50 %.
  static const barrier = Color(0x80171717);

  // QR scanner (camera screen — same in both themes)
  /// Dim layer over the camera outside the scan window — black at 55 %.
  static const scanOverlay = Color(0x8C000000);

  /// Round tool buttons over the camera (back, gallery, flash).
  static const scanButton = greyScale100;
  static const scanButtonIcon = greyScale900;

  /// Placeholder behind the scan window until a camera feed is wired in.
  static const scanCamera = Color(0xff2B2B2B);

  // Primary (brand)
  static const primary50 = Color(0xffEFEFFE);
  static const primary100 = Color(0xffDEE0FD);
  static const primary300 = Color(0xff9DA1F9);
  static const primary500 = Color(0xff5A63F6);
  static const primary700 = Color(0xff3F45C8);
  static const primary900 = Color(0xff252A80);

  // Status
  static const success500 = Color(0xff12B76A);
  static const success100 = Color(0xffD1FADF);
  static const error500 = Color(0xffFF3939);
  static const error100 = Color(0xffFEE4E2);
  static const warning500 = Color(0xffF79009);
  static const warning100 = Color(0xffFEF0C7);

  // Greyscale
  static const greyScale50 = Color(0xffFAFAFA);
  static const greyScale100 = Color(0xffF6F6F6);
  static const greyScale200 = Color(0xffEDEDED);
  static const greyScale300 = Color(0xffE0E0E0);
  static const greyScale400 = Color(0xffBDBDBD);
  static const greyScale500 = Color(0xff9E9E9E);
  static const greyScale600 = Color(0xff757575);
  static const greyScale700 = Color(0xff575757);
  static const greyScale800 = Color(0xff424242);
  static const greyScale900 = Color(0xff171717);

  // Dark mode surfaces (Figma "Dark Mode/01-03")
  static const dark1 = Color(0xff0D131C);
  static const dark2 = Color(0xff151D29);
  static const dark3 = Color(0xff1D2634);
  static const dark4 = Color(0xff35374A);

  // Bank cards (Figma "My Cards") — flat fill + lighter square pattern
  static const cardBlue = primary500;
  static const cardBluePattern = Color(0xff6A73F6);
  static const cardTeal = Color(0xff00838F);
  static const cardTealPattern = Color(0xff0095A2);
  static const cardPurple = Color(0xff7F56D9);
  static const cardPurplePattern = Color(0xff8C67DD);
  static const cardBlack = greyScale900;
  static const cardBlackPattern = Color(0xff262626);

  // Gradients
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary500, primary900],
  );
}
