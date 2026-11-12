# Project skills — `tok_tok_social_app`

Skills scoped to **this project only** (`.claude/skills/`). They are extracted
from this codebase's own conventions and load automatically when working here.
They are deliberately **not** in `~/.claude/skills/`, because they describe one
particular Flutter stack and would contradict the global set elsewhere.

## Two Flutter stacks — know which one you are in

| `pubspec.yaml` has | Stack | Skills |
|---|---|---|
| `dio`, `get_it`, `go_router`, `freezed` | Clean Architecture, backend-driven | **global** (`~/.claude/skills/`) |
| only `flutter_bloc`, `flutter_screenutil`, `flutter_svg` | UI-led, feature-first, local state | **this folder** |

This project is the second kind. The two families disagree on purpose —
routing, state and folder layout are different answers to different problems —
so do not apply the global `flutter-clean-architecture`,
`flutter-api-integration` or `flutter-testing` conventions here.

## The skills

| Skill | Covers |
|---|---|
| `flutter-project-bootstrap` | day-one setup: dependencies, lints, assets, fonts, `main.dart`, the ordered checklist |
| `flutter-feature-first-structure` | `core` / `common` / `features` layout, where a file goes, naming, import style |
| `flutter-design-tokens` | `AppColors` / `AppTextStyles` / `AppThemes` / `AppAssets` / `AppButtonStyle`, light + dark theming |
| `flutter-responsive-sizing` | `flutter_screenutil`: `.w` `.h` `.r` `.sp`, what never scales, spacing idioms |
| `flutter-navigation-pager` | `Go` verbs + `Pager` registry, push/replace/removeAll, Cubits across routes |
| `flutter-reusable-widgets` | named-constructor variants, controlled widgets, private `Widget?` getters, dialogs |
| `flutter-local-state-and-forms` | `setState` vs Cubit, controller lifecycle, `Form` validation, pickers, filtering |
| `dart-modern-syntax` | Dart 3.x dot-shorthands, `spacing:`, wildcards, spreads, extensions, what to stop writing |

Still global and applying everywhere, including here: `dart-clean-code`,
`figma-to-flutter`, `handoff`.

## Typical order on a screen

`figma-to-flutter` → `flutter-responsive-sizing` → `flutter-reusable-widgets` →
`flutter-local-state-and-forms`, with `dart-clean-code` and `dart-modern-syntax`
on review.

## Reusing these in the next project

Copy this folder into the new repo's `.claude/skills/`. Nothing here is
tok-tok-specific except the examples — the conventions are the point. Promote a
skill to `~/.claude/skills/` only once a second project has actually adopted it
and it no longer conflicts with the Clean Architecture family.

## Maintaining these

- One skill = one topic someone would ask about by name. Two unrelated triggers
  means two skills.
- The `description` is the whole trigger mechanism. Write it as *when to use
  this*, with the literal phrases you would type — not as a summary.
- Prefer rules with a reason and a real code example over checklists.
- Contradicting another skill is a bug. Either scope it ("if the project has X,
  use the other one") or fix the older skill.
- Plain markdown, no rebuild — edits are picked up next session.
