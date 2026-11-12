# Savin Bank App

UI-only Flutter bank app. **No backend, no API** — all data is static mock data.
Architecture is feature-first (core / common / features), modelled on
`tok_tok_social_app`. Detailed conventions live in `.claude/skills/`.

## Layout

```
lib/
├── main.dart                 # ThemeCubit + ScreenUtilInit + MaterialApp only
├── core/                     # knows nothing about features
│   ├── constants/            # app_colors, app_theme_colors (ThemeExtension),
│   │                         # app_themes, app_text_style, app_button_style,
│   │                         # app_assets, app_sizes, app_texts, app_durations
│   ├── cubits/theme/         # ThemeCubit (light / dark / system)
│   ├── extensions/           # context (theme, colors, isDark), color, num (currency), date_time
│   ├── navigation/           # go.dart (verbs), pager.dart (page registry)
│   └── utils/                # validator_utils, formatter_utils
├── common/
│   ├── data/models/          # shared mock data: user, card, transaction
│   └── widgets/              # Custom* widgets used by 2+ features
└── features/<feature>/
    ├── pages/                # <name>_page.dart
    ├── widgets/              # feature-only widgets
    ├── cubits/<name>/        # only when local setState is not enough
    └── data/models/          # feature-only mock data (static const lists)
```

Features: splash, onboard, auth, main (bottom nav), home, cards, transfer,
transactions, statistics, profile. Pages marked "Placeholder" get replaced
as real designs arrive.

## Rules

- Light + dark: every colour that must flip comes from `context.colors.*`
  (AppThemeColors) or `context.colorScheme.*`. Use `AppColors.*` directly only
  for values identical in both themes (brand blue, white text on gradients).
- Text: `AppTextStyles.<rung>.copyWith(color: context.colors.textPrimary)`.
- No inline hex colours, asset paths or magic strings — add a token first.
- Sizes via flutter_screenutil (`.w .h .r .sp`), design frame in `AppSizes.figmaDesignSize`.
- Navigation: `Go.to(context, Pager.x)`; register every page in `Pager`.
- Relative imports inside `lib/`.
- Mock data = `static const` lists on the model class.
- Run `flutter analyze` after changes — must stay at "No issues found".
