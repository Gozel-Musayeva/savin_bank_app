---
name: flutter-feature-first-structure
description: Use when starting a Flutter app or deciding where a new file belongs — the core/common/features layout, whether a widget is shared or feature-local, folder and class naming, import style, and the checklist for adding a feature. Trigger on "new project", "scaffold the app", "where should this go", "add a new screen/feature", "project structure", or when creating the first file of a screen.
---

# Feature-first Flutter structure

For UI-led apps built screen-by-screen from a design (Figma → Flutter), with
local state and no server layer yet. If the project already has `dio`,
`get_it` or `go_router` in `pubspec.yaml`, it is a Clean-Architecture app —
use `flutter-clean-architecture` instead; the two layouts do not mix.

## The layout

```
lib/
├── main.dart                     # ScreenUtilInit + MaterialApp + themes only
├── core/                         # knows nothing about any feature
│   ├── constants/                # app_colors, app_text_style, app_themes,
│   │                             # app_assets, app_sizes, app_texts,
│   │                             # app_durations, app_button_style
│   ├── extensions/               # context_extension, color_extensions
│   ├── navigation/               # go.dart (verbs), pager.dart (page registry)
│   └── utils/                    # validator_utils, image_picker_util
├── common/
│   └── widgets/                  # widgets used by 2+ features
└── features/
    └── <feature>/
        ├── pages/                # one file per screen: <name>_page.dart
        ├── widgets/              # widgets only this feature uses
        ├── cubits/<name>/        # <name>_cubit.dart (+ _state.dart if needed)
        └── data/models/          # <name>_model.dart
```

`main.dart` stays tiny: `ScreenUtilInit(designSize: AppSizes.figmaDesignSize)`
wrapping a `MaterialApp` that reads `AppThemes.lightTheme` / `darkTheme` and
opens `Pager.splash`. Nothing else belongs there.

## The one rule that keeps it clean

**Dependencies point inward: `features/` → `common/` → `core/`. Never back.**

`core/` and `common/` must be droppable into the next project untouched. The
moment a file in `common/widgets/` imports something from `features/`, the
layering is broken — pass a callback instead.

## Where does this file go?

| Situation | Location |
|---|---|
| A whole screen | `features/<f>/pages/<name>_page.dart` |
| Piece of one screen, used once | `features/<f>/widgets/` |
| Used by a second feature | move it to `common/widgets/` — at the *second* caller, not before |
| Static list of demo/config data | `features/<f>/data/models/` as a `static const` on the model |
| Colour, size, string, asset path, duration | `core/constants/` — never inline |
| Dialog / bottom sheet | `features/<f>/widgets/`, with a `static void show(context)` |
| Pure function on a type you don't own | `core/extensions/` |
| Wrapper over a plugin (`image_picker`, …) | `core/utils/<name>_util.dart` |

Promote to `common/` on the second caller. One caller is not shared code — a
"shared" widget with a single user is just a file in the wrong folder.

## Naming

- Files `snake_case`, suffixed by role: `_page`, `_cubit`, `_model`, `_util`,
  `_extension`. The suffix is how you find things without opening them.
- Class name mirrors the file: `login_page.dart` → `LoginPage`.
- Feature folder is the domain noun, not the screen: `auth/`, not `login/` —
  register, OTP and reset all live there.
- Prefix feature-local widgets with the feature when the bare name would
  collide with a shared one: `HomeAppBar` wraps `CustomAppBar`.
- Shared widgets take the `Custom` prefix (`CustomButton`, `CustomInput`) so
  a reader instantly knows it is the project's, not Flutter's.
- Spell it right the first time. Typos calcify: `figmaDesigSize`,
  `AppButtonStyle.tetriary` — both shipped, both now cost a rename everywhere.

## Imports

**Relative inside `lib/`. `package:` only for real third-party packages.**

```dart
import '../../core/constants/app_colors.dart';        // yes
import 'package:tok_tok_social_app/core/...';         // no — self-import
```

Mixing both styles makes the same file look like two different dependencies to
a reader and to some tooling. Pick relative, apply everywhere.

**Case must match the file exactly.** `import 'core/utils/Validator_utils.dart'`
for a file named `validator_utils.dart` compiles on macOS and Windows and
**fails the build on Linux CI**. `flutter analyze` will not catch it — the
case-insensitive filesystem hides it locally.

## Adding a feature — the order

1. `features/<f>/` with `pages/`, and `widgets/` when the screen needs parts.
2. Static data → `data/models/<name>_model.dart` with a `static const` list.
3. New design values → `core/constants/` **first**, then use the token.
4. Page as `const <Name>Page()` in `core/navigation/pager.dart`.
5. Build the screen from `common/widgets/` — check what already exists before
   writing a new widget.
6. Only a widget on its third occurrence, or one two features share, moves to
   `common/widgets/`.

## Consistency beats preference

Pick one shape and repeat it. Drift is what makes a codebase feel unowned:

- `features/home/models/` next to `features/onboard/data/models/` — two names
  for one concept. Choose `data/models/` and move the odd one.
- `features/bottom_nav_bar/main_page.dart` sitting outside `pages/` while every
  other screen is inside one.
- A folder invented for a single file (`auth/alerts/`) — a dialog is a widget;
  it goes in `widgets/`.

None of these are bugs. All of them cost a few seconds every time someone
looks for a file, forever.
