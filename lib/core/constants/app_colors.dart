import 'package:flutter/material.dart';

/// Raw colour palette. Widgets that must flip between light/dark mode should
/// NOT use these directly — read them through `context.colors` /
/// `context.colorScheme` instead (see `app_theme_colors.dart`).
class AppColors {
  AppColors._();

  static const transparent = Colors.transparent;
  static const white = Color(0xffFFFFFF);
  static const black = Color(0xff000000);

  // Primary (brand)
  static const primary50 = Color(0xffEEF3FF);
  static const primary100 = Color(0xffDCE6FF);
  static const primary300 = Color(0xff8FAEFF);
  static const primary500 = Color(0xff246BFD);
  static const primary700 = Color(0xff1A4FC4);
  static const primary900 = Color(0xff0F2E75);

  // Status
  static const success500 = Color(0xff12B76A);
  static const success100 = Color(0xffD1FADF);
  static const error500 = Color(0xffF04438);
  static const error100 = Color(0xffFEE4E2);
  static const warning500 = Color(0xffF79009);
  static const warning100 = Color(0xffFEF0C7);

  // Greyscale
  static const greyScale50 = Color(0xffFAFAFA);
  static const greyScale100 = Color(0xffF5F5F5);
  static const greyScale200 = Color(0xffEEEEEE);
  static const greyScale300 = Color(0xffE0E0E0);
  static const greyScale400 = Color(0xffBDBDBD);
  static const greyScale500 = Color(0xff9E9E9E);
  static const greyScale600 = Color(0xff757575);
  static const greyScale700 = Color(0xff616161);
  static const greyScale800 = Color(0xff424242);
  static const greyScale900 = Color(0xff111827);

  // Dark mode surfaces
  static const dark1 = Color(0xff121318);
  static const dark2 = Color(0xff1C1D24);
  static const dark3 = Color(0xff262833);
  static const dark4 = Color(0xff35374A);

  // Gradients
  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary500, primary900],
  );

  static const cardGradientBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff246BFD), Color(0xff5089FF)],
  );

  static const cardGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff1F2937), Color(0xff4B5563)],
  );

  static const cardGradientPurple = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff7F56D9), Color(0xffB692F6)],
  );
}
