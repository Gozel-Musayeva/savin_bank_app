---
name: flutter-project-bootstrap
description: Use on day one of a Flutter app — the dependency baseline and what each package is for, analysis_options lints, assets and custom font registration in pubspec.yaml, the main.dart shape, and the ordered checklist that gets from `flutter create` to the first real screen. Trigger on "new Flutter project", "set up the app", "which packages should I use", "add fonts/assets", "flutter create", or an empty lib/ folder.
---

# Bootstrapping a Flutter app

Day-one setup for a UI-led app built from a design. Ten minutes here removes a
class of decisions from every screen afterwards.

## Dependency baseline

Add what the design demands, in this order of certainty:

```yaml
dependencies:
  flutter_screenutil: ^5.9.3      # Figma pixels → every device. Always.
  flutter_svg: ^2.3.0             # SVG icons. Always, if the design ships SVGs.
  flutter_bloc: ^9.1.1            # Cubit for state that outlives one screen.

  cached_network_image: ^3.4.1    # any remote image in a list
  flutter_spinkit: ^5.2.2         # branded loaders instead of the stock spinner
  image_picker: ^1.2.3            # avatar / upload flows
  pinput: ^6.0.2                  # OTP screens
  story_view: ^0.16.6             # story viewers

dev_dependencies:
  flutter_lints: ^6.0.0
```

The first three are near-universal for this style of app. The rest are
feature-triggered — add each when the screen that needs it exists, not
speculatively. A dependency you don't use is a dependency you still have to
upgrade.

**Do not add** `dio`, `get_it`, `go_router`, `freezed` to a UI-only app.
Adding any of them means you have chosen Clean Architecture, and the whole
layout changes — that is a deliberate decision, not a package install.

## `analysis_options.yaml`

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_const_literals_to_create_immutables
    - prefer_const_constructors_in_immutables
```

The four `const` rules are the ones that pay: every `const` widget is a subtree
Flutter skips rebuilding. Turn them on before the first screen, while the
codebase is small enough to fix in one pass.

`flutter analyze` must be clean before any work is called done — and know the
baseline, so a **new** warning is always visible.

## Assets and fonts

```yaml
flutter:
  uses-material-design: true

  assets:
    - assets/icons/
    - assets/images/

  fonts:
    - family: Urbanist
      fonts:
        - asset: assets/fonts/Urbanist-Regular.ttf
          weight: 400
        - asset: assets/fonts/Urbanist-Medium.ttf
          weight: 500
        - asset: assets/fonts/Urbanist-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Urbanist-Bold.ttf
          weight: 700
```

- Register **folders**, not individual files — one line covers every asset you
  add later.
- Ship a real file per weight. Declaring only Regular and asking for `w700`
  makes Flutter synthesise a fake bold that looks wrong next to the design.
- `weight:` must match the file. A `SemiBold.ttf` registered as `700` will
  never be reachable by `FontWeight.w600`.
- Asset filenames `kebab-case`; they become `camelCase` members in
  `AppAssets`. Never reference a path as a string literal in a widget.
- After editing `pubspec.yaml`: `flutter pub get`, then a **full restart** —
  hot reload does not pick up new assets or fonts.

## `main.dart` — and nothing more

```dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppSizes.figmaDesignSize,
      minTextAdapt: true,
      builder: (_, child) => MaterialApp(
        title: AppTexts.appName,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.system,
        home: child,
      ),
      child: Pager.splash,
    );
  }
}
```

Everything is a reference to a constant — no literals, no logic. If `main.dart`
starts growing, whatever is growing belongs somewhere else.

Add `debugShowCheckedModeBanner: false` when screenshots matter. Add
`WidgetsFlutterBinding.ensureInitialized()` in `main` only once something async
runs before `runApp`.

## The order

1. `flutter create`, then delete the counter app and `test/widget_test.dart`'s
   default body.
2. `pubspec.yaml`: the three core packages, lints, `assets/`, fonts.
3. `analysis_options.yaml` lint rules.
4. Folder skeleton — `core/{constants,extensions,navigation,utils}`,
   `common/widgets/`, `features/`. See `flutter-feature-first-structure`.
5. **Tokens before screens**: `app_colors`, `app_text_style`, `app_themes`,
   `app_assets`, `app_sizes` (with the real Figma frame size). See
   `flutter-design-tokens`.
6. `core/extensions/`: `context.theme`, `toColorFilter`, `wspAll`.
7. `core/navigation/`: `go.dart`, then `pager.dart` with the splash page.
8. `main.dart` as above.
9. First screen — splash. It proves tokens, sizing, assets and navigation all
   work end to end before any real feature depends on them.
10. `common/widgets/` fills up as the second caller for each widget appears.

Steps 5–7 feel like overhead on a one-screen app. They are what stops screen
twelve from being a pile of hex codes.

## Before the first commit

- [ ] `flutter analyze` — no issues
- [ ] `dart format .`
- [ ] `.gitignore` covers `build/`, `.dart_tool/`, `*.iml`, `.idea/`, `.DS_Store`
- [ ] `pubspec.yaml` `description` and `name` are real, `publish_to: "none"`
- [ ] App name, bundle id and launcher icon set for both platforms
- [ ] `main.dart` opens the splash page, not whichever screen you were debugging
