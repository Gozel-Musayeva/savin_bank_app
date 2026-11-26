import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Typography ladder. Colour is intentionally NOT part of the style — callers
/// add it (`AppTextStyles.h4.copyWith(color: context.colors.textPrimary)`),
/// so one ladder serves both light and dark mode.
///
/// Line heights follow the Figma styles: headings and semibold/bold body
/// text use 120 %, regular/medium paragraphs use 150 %.
class AppTextStyles {
  const AppTextStyles._();

  static const fontFamily = 'PlusJakartaSans';

  static const double _headingHeight = 1.2;
  static const double _paragraphHeight = 1.5;

  // Size scale
  static const double _h1 = 48;
  static const double _h2 = 40;
  static const double _h3 = 32;
  static const double _display = 28;
  static const double _h4 = 24;
  static const double _h5 = 20;
  static const double _h6 = 18;

  static const double _bodyXLarge = 18;
  static const double _bodyLarge = 16;
  static const double _bodyMedium = 14;
  static const double _bodySmall = 12;
  static const double _bodyXSmall = 10;

  static const FontWeight _bold = .w700;
  static const FontWeight _semiBold = .w600;
  static const FontWeight _medium = .w500;
  static const FontWeight _regular = .w400;

  // Display — Figma "Eh-28 SemiBold" (large onboarding copy, 150 %)
  static TextStyle get display =>
      _text(_display, _semiBold, height: _paragraphHeight);

  // Headline
  static TextStyle get h1 => _heading(_h1, _bold);
  static TextStyle get h2 => _heading(_h2, _bold);
  static TextStyle get h3 => _heading(_h3, _bold);
  static TextStyle get h4 => _heading(_h4, _bold);
  static TextStyle get h4SemiBold => _heading(_h4, _semiBold);

  /// PIN keypad digits (Figma: 24 / Lh 120%).
  static TextStyle get h4Medium => _heading(_h4, _medium);
  static TextStyle get h5 => _heading(_h5, _bold);
  static TextStyle get h5SemiBold => _heading(_h5, _semiBold);
  static TextStyle get h6 => _heading(_h6, _bold);

  // Body
  static TextStyle get bodyXLargeBold => _heading(_bodyXLarge, _bold);
  static TextStyle get bodyXLargeSemiBold => _heading(_bodyXLarge, _semiBold);
  static TextStyle get bodyXLargeMedium => _paragraph(_bodyXLarge, _medium);
  static TextStyle get bodyXLargeRegular => _paragraph(_bodyXLarge, _regular);

  static TextStyle get bodyLargeBold => _heading(_bodyLarge, _bold);
  static TextStyle get bodyLargeSemiBold => _heading(_bodyLarge, _semiBold);
  static TextStyle get bodyLargeMedium => _paragraph(_bodyLarge, _medium);
  static TextStyle get bodyLargeRegular => _paragraph(_bodyLarge, _regular);

  static TextStyle get bodyMediumBold => _heading(_bodyMedium, _bold);
  static TextStyle get bodyMediumSemiBold => _heading(_bodyMedium, _semiBold);
  static TextStyle get bodyMediumMedium => _paragraph(_bodyMedium, _medium);
  static TextStyle get bodyMediumRegular => _paragraph(_bodyMedium, _regular);

  /// Figma "Secondary/14 Regular - Lh 120%" — form error messages.
  static TextStyle get bodyMediumRegularTight =>
      _heading(_bodyMedium, _regular);

  static TextStyle get bodySmallBold => _heading(_bodySmall, _bold);
  static TextStyle get bodySmallSemiBold => _heading(_bodySmall, _semiBold);
  static TextStyle get bodySmallMedium => _paragraph(_bodySmall, _medium);
  static TextStyle get bodySmallRegular => _paragraph(_bodySmall, _regular);

  /// Figma "Secondary/12 Regular - Lh 120%" — input text and hints.
  static TextStyle get bodySmallRegularTight => _heading(_bodySmall, _regular);

  static TextStyle get bodyXSmallBold => _heading(_bodyXSmall, _bold);
  static TextStyle get bodyXSmallSemiBold => _heading(_bodyXSmall, _semiBold);
  static TextStyle get bodyXSmallMedium => _paragraph(_bodyXSmall, _medium);
  static TextStyle get bodyXSmallRegular => _paragraph(_bodyXSmall, _regular);

  static TextStyle _heading(double size, FontWeight weight) =>
      _text(size, weight, height: _headingHeight);

  static TextStyle _paragraph(double size, FontWeight weight) =>
      _text(size, weight, height: _paragraphHeight);

  static TextStyle _text(
    double size,
    FontWeight weight, {
    required double height,
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: size.sp,
    fontWeight: weight,
    height: height,
  );
}
