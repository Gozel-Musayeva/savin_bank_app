---
name: flutter-design-tokens
description: Use when setting up or touching a Flutter app's design system — the AppColors / AppTextStyles / AppThemes / AppAssets / AppButtonStyle constants layer, the typography ladder, light+dark theming through ColorScheme, and the rule that no colour, size, string or asset path is ever written inline. Trigger on "add a colour", "text style", "theme", "dark mode", "new icon/asset", "button style", or any hex code appearing in a widget.
---

# Design tokens

Every visual value in the app has exactly one name, in exactly one file under
`core/constants/`. A widget never invents a value — it spends one.

## The token files

| File | Holds | Access |
|---|---|---|
| `app_colors.dart` | every colour + gradient in the palette | `AppColors.primary500` |
| `app_text_style.dart` | the type ladder | `AppTextStyles.h4` |
| `app_themes.dart` | light + dark `ThemeData` | `context.theme…` |
| `app_assets.dart` | every asset path | `AppAssets.search` |
| `app_button_style.dart` | `ButtonStyle` variants | `AppButtonStyle.primary` |
| `app_sizes.dart` | the Figma design size, global metrics | `AppSizes.figmaDesignSize` |
| `app_texts.dart` | app name, strings with no home yet | `AppTexts.appName` |
| `app_durations.dart` | named animation / delay durations | `AppDurations.s2` |

Every one of them is a namespace, never an instance:

```dart
class AppColors {
  AppColors._();          // private ctor — cannot be constructed
  static const primary500 = Color(0xffFF4D67);
}
```

## Colours: name by role and step, not by appearance

```dart
static const primary100 = Color(0xffFFEDF0);
static const primary500 = Color(0xffFF4D67);   // the brand
static const greyScale50 … greyScale900;       // one ramp, 50→900
static const dark1, dark2, dark3;              // dark-mode surfaces
```

`primary500` survives a rebrand; `pink` does not. The numeric step tells you
where it sits in the ramp without opening the file.

**A gradient is a token too.** Three files repeating
`LinearGradient(colors: [Color(0xffFF4D67), Color(0xffFF8A9B)])` means the
brand gradient can now be changed in two places and forgotten in the third:

```dart
// app_colors.dart
static const primaryGradient = LinearGradient(
  colors: [primary500, Color(0xffFF8A9B)],
);
```

Same for one-off tints — `Color.fromRGBO(255, 77, 103, 0.08)` inline is
`primary500.withValues(alpha: 0.08)` at best, a named `primary500Subtle` at
worst.

## Typography: a private scale, a builder, public getters

```dart
class AppTextStyles {
  const AppTextStyles._();

  static const _fontFamily = 'Urbanist';
  static const double _lineHeight = 1.4;

  static const double _h4 = 24;              // the scale is private
  static const double _bodyMedium = 14;

  static const FontWeight _bold = .w700;     // the weights are private
  static const FontWeight _semiBold = .w600;

  static TextStyle get h4 => _text(_h4, _bold);
  static TextStyle get bodyMediumSemiBold => _text(_bodyMedium, _semiBold);

  static TextStyle _text(double size, FontWeight weight) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: size.sp,          // .sp, so the whole ladder scales at once
    fontWeight: weight,
    height: _lineHeight,
  );
}
```

Why this shape:

- **`get`, not `const`** — `.sp` needs `ScreenUtil` initialised at runtime.
- Sizes and weights are private, so nobody can pull `_bodyMedium` out and build
  a rogue style. The only way in is a named rung of the ladder.
- Naming is `<scale><Weight>`: `bodyLargeBold`, `bodySmallRegular`. Headlines
  are bold by definition, so `h1`–`h6` take no weight suffix.
- Colour is **not** in the style — callers add it:
  `AppTextStyles.h4.copyWith(color: AppColors.greyScale900)`. One ladder serves
  both themes.

Register the font in `pubspec.yaml` with real weights (400/500/600/700) rather
than shipping one file and letting Flutter fake the bold.

## Themes: map tokens onto `ColorScheme` roles

```dart
static final lightTheme = ThemeData(
  colorScheme: .fromSeed(
    seedColor: AppColors.primary500,
    primary: AppColors.primary500,
    secondary: AppColors.primary100,
    onSecondary: AppColors.primary500,
    surface: AppColors.white,
    surfaceDim: AppColors.greyScale300,
    onSurfaceVariant: AppColors.greyScale100,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColors.white,
  textTheme: TextTheme(
    headlineLarge: AppTextStyles.h3.copyWith(color: AppColors.greyScale900),
    bodyLarge: AppTextStyles.bodyLargeRegular.copyWith(color: AppColors.greyScale700),
  ),
);
```

`darkTheme` is the same structure with the dark tokens. `MaterialApp` gets both
plus `themeMode: ThemeMode.system`.

**The choice that decides whether dark mode works:**

| Use | When |
|---|---|
| `context.theme.colorScheme.surface` | the value must flip between themes |
| `AppColors.white` directly | the value is the same in both themes — a logo, an always-white icon on brand |

Shipping a `darkTheme` and then writing `color: AppColors.white` on every card
gives you a dark app with white cards. If a widget is meant to work in both
themes, every colour in it comes from `context.theme`. Text is the usual
offender: `AppTextStyles.h4.copyWith(color: AppColors.greyScale900)` is
invisible on `dark1` — reach for `context.theme.textTheme.headlineLarge` there.

Put the shared shell values in the theme once — `appBarTheme`,
`bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent)` —
instead of repeating them per screen.

## Assets: private base paths, one member per file

```dart
class AppAssets {
  AppAssets._();
  static const _icons = 'assets/icons';
  static const _images = 'assets/images';

  static const search = '$_icons/search.svg';
  static const profileAvatar = '$_images/profile-avatar.png';
}
```

Files stay `kebab-case.svg`, members `camelCase`. Adding an asset = drop the
file in, add one line here, use the constant. A raw `'assets/icons/x.svg'` in a
widget is a runtime crash waiting for a typo — the constant is checked at
compile time.

## Button styles: one base, variants by `copyWith`

```dart
static final primary = ButtonStyle(
  backgroundColor: AppColors.primary500.wspAll,
  minimumSize: Size(1.sw, 55.h).wspAll,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)).wspAll,
);

static ButtonStyle get tertiary => primary.copyWith(minimumSize: Size(73.w, 32.h).wspAll);

static ButtonStyle secondary(BuildContext context) => primary.copyWith(
  backgroundColor: context.theme.colorScheme.secondary.wspAll,
  foregroundColor: context.theme.colorScheme.onSecondary.wspAll,
);
```

`.wspAll` is the `WidgetStatePropertyAll` extension from `core/extensions/` —
without it every line doubles in width. A variant that needs the theme takes
`BuildContext` and becomes a method; the rest stay fields.

Note: fields using `.h`/`.w` are `static final`, evaluated once at first
access. That is fine on phones. If the app supports window resizing or tablets
that rotate, make them getters so they re-read `ScreenUtil`.

## Working rule

Before typing a literal in a widget, ask: does this value have a name yet?

- Yes → use the token.
- No, and the design defines it → add the token, then use it.
- No, and it is genuinely one-off geometry (a `Positioned` offset, one
  `SizedBox`) → inline is fine. Tokens are for the palette, the ladder, and
  anything that repeats.

Hardcoded values do not fail the analyzer. They fail three months later when
the brand colour changes and one screen stays pink.
