import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Typography ladder. Colour is intentionally NOT part of the style — callers
/// add it (`AppTextStyles.h4.copyWith(color: context.colors.textPrimary)`),
/// so one ladder serves both light and dark mode.
class AppTextStyles {
  const AppTextStyles._();

  static const _fontFamily = 'Urbanist';
  static const double _lineHeight = 1.4;

  // Size scale
  static const double _h1 = 48;
  static const double _h2 = 40;
  static const double _h3 = 32;
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

  // Headline
  static TextStyle get h1 => _text(_h1, _bold);
  static TextStyle get h2 => _text(_h2, _bold);
  static TextStyle get h3 => _text(_h3, _bold);
  static TextStyle get h4 => _text(_h4, _bold);
  static TextStyle get h5 => _text(_h5, _bold);
  static TextStyle get h6 => _text(_h6, _bold);

  // Body
  static TextStyle get bodyXLargeBold => _text(_bodyXLarge, _bold);
  static TextStyle get bodyXLargeSemiBold => _text(_bodyXLarge, _semiBold);
  static TextStyle get bodyXLargeMedium => _text(_bodyXLarge, _medium);
  static TextStyle get bodyXLargeRegular => _text(_bodyXLarge, _regular);

  static TextStyle get bodyLargeBold => _text(_bodyLarge, _bold);
  static TextStyle get bodyLargeSemiBold => _text(_bodyLarge, _semiBold);
  static TextStyle get bodyLargeMedium => _text(_bodyLarge, _medium);
  static TextStyle get bodyLargeRegular => _text(_bodyLarge, _regular);

  static TextStyle get bodyMediumBold => _text(_bodyMedium, _bold);
  static TextStyle get bodyMediumSemiBold => _text(_bodyMedium, _semiBold);
  static TextStyle get bodyMediumMedium => _text(_bodyMedium, _medium);
  static TextStyle get bodyMediumRegular => _text(_bodyMedium, _regular);

  static TextStyle get bodySmallBold => _text(_bodySmall, _bold);
  static TextStyle get bodySmallSemiBold => _text(_bodySmall, _semiBold);
  static TextStyle get bodySmallMedium => _text(_bodySmall, _medium);
  static TextStyle get bodySmallRegular => _text(_bodySmall, _regular);

  static TextStyle get bodyXSmallBold => _text(_bodyXSmall, _bold);
  static TextStyle get bodyXSmallSemiBold => _text(_bodyXSmall, _semiBold);
  static TextStyle get bodyXSmallMedium => _text(_bodyXSmall, _medium);
  static TextStyle get bodyXSmallRegular => _text(_bodyXSmall, _regular);

  static TextStyle _text(double size, FontWeight weight) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: size.sp,
    fontWeight: weight,
    height: _lineHeight,
  );
}
