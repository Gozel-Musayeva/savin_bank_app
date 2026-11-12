---
name: flutter-reusable-widgets
description: Use when writing or reviewing a shared/custom Flutter widget — named-constructor variants vs boolean flags, the controlled-widget contract (value in, callback out), private Widget getters for sub-parts, dialogs with a static show(), PreferredSizeWidget app bars, and the coupling rules for anything in common/widgets. Trigger on "create a custom widget", "make this reusable", "extract this widget", "add a variant", "custom app bar", "show a dialog", or a widget gaining its third boolean parameter.
---

# Writing reusable widgets

A shared widget is an API. Once three screens call it, its signature is harder
to change than the screens are. Design it like an API from the first line.

## Variants: named constructors, not flags

```dart
class SocialButton extends StatelessWidget {
  const SocialButton.google({
    super.key,
    this.iconSvg = AppAssets.google,
    this.text = 'Continue with Google',
    this.buttonType = SocialButtonType.onlyIcon,
    required this.onTap,
  });

  const SocialButton.apple({ … });
  const SocialButton.facebook({ … });
}
```

The call site reads as the thing itself — `SocialButton.google(onTap: …)`,
`AuthTitle.login()`, `DividerWithText.orContinueWith()`,
`HaveAnAccountWidget.no(onTap: …)` — and there is no way to construct a
nonsense combination.

For variants that differ by a fixed value rather than a parameter, set it in
the **initializer list** so it cannot be overridden:

```dart
const ProfilePhoto({super.key, this.radius = 24, this.imageUrl})
    : showEditPen = false;

const ProfilePhoto.withEditPen({super.key, this.radius = 70, this.imageUrl})
    : showEditPen = true;
```

`showEditPen` is now derived from *which constructor you called*. Callers
cannot pass it, so `ProfilePhoto.withEditPen(showEditPen: false)` can't exist.

Use an `enum` instead when the variant changes *layout* and both forms are
legitimate for every named constructor — `SocialButtonType.withText` /
`.onlyIcon` applies to google, apple and facebook alike. Two orthogonal axes:
constructor for identity, enum for shape.

**The rule:** boolean parameters are fine to *read* internally, but a caller
should never be choosing behaviour by passing `true`. Two booleans is the
warning sign; three means the widget is two widgets.

## The controlled contract: value in, callback out

A shared widget renders what it is given and reports what happened. It does not
own the answer:

```dart
class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({super.key, required this.isChecked, required this.onChanged, this.text});

  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final String? text;
}
```

A checkbox that keeps `_isChecked` in its own `State` with no `onChanged` looks
correct on screen and is useless: the form submitting it has no way to read it.
Same trap in a row widget that flips its own `isSelected` while the required
`onTap` it was given is never called — the parent thinks it is wired up.

Internal state is for things the parent genuinely does not care about:
password visibility, whether a field is focused, a local animation flag.
Anything the parent would need to submit, validate or persist goes out through
a callback.

Test: **could the parent answer "what is the current value?"** If not, the
widget is holding state it should not own.

## Keep `common/` decoupled from `features/`

```dart
// common/widgets/custom_input.dart — wrong
onTap: () => Go.to(context, Pager.selectCountry(context)),
```

A shared input now knows a specific feature's page, imports its Cubit
transitively, and cannot be dropped into the next project. Take a callback:

```dart
const CustomInput({… this.onCountryTap});
final VoidCallback? onCountryTap;
```

The page wires it. Anything in `common/widgets/` may import `core/` and other
`common/` widgets — never `features/`.

## Structure inside the widget

Split `build` with **private getters or methods returning `Widget?`**, not with
section comments:

```dart
Widget? get _prefixIcon {
  if (widget.prefixSvg == null) return null;
  return Row(mainAxisSize: .min, children: [...]);
}

Widget? _buildLeading(BuildContext context) {
  if (showLeadingAppIcon) return …;
  if (!Go.canBack(context)) return null;
  return …;
}
```

A getter when it needs nothing from outside; a method when it needs `context`
or an argument. Guard clauses first, `null` for "render nothing" — `null` slots
into `prefixIcon:`/`leading:` directly, so the caller needs no conditional.

A 60-line flat `build` is fine. A 60-line `build` with three conditional
branches is three getters.

## Named forms of the same widget

Ordering builders read best as a small resolver:

```dart
ImageProvider get _buildProfileAvatar {
  if (imageUrl != null) return NetworkImage(imageUrl!);
  if (imageFile != null) return FileImage(imageFile!);
  return const AssetImage(AppAssets.profileAvatar);
}
```

Precedence is explicit and there is always a fallback — no `!` on a nullable
the caller might not have set, no blank circle.

## Dialogs and sheets own their presentation

```dart
class CreateNewPasswordSuccessAlert extends StatelessWidget {
  const CreateNewPasswordSuccessAlert({super.key});

  static void show(BuildContext context) => showDialog(
    context: context,
    builder: (_) => const Dialog(child: CreateNewPasswordSuccessAlert()),
  );
}
```

Callers write `CreateNewPasswordSuccessAlert.show(context)` and never repeat
`showDialog` plumbing, `barrierDismissible`, or the wrapper. When it needs to
return a choice: `static Future<bool?> show(BuildContext context)`.

## App bars

```dart
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(48.h);
}
```

`implements PreferredSizeWidget` is required for `Scaffold.appBar` to accept
it. Feature-specific bars **wrap** the shared one rather than rebuilding it —
`HomeAppBar` returns a `CustomAppBar` with its own `actions`. Wrap, don't fork.

## Theme-safe by default

A widget with `color: AppColors.white` hardcoded will be a white card on a dark
background the day dark mode ships. In anything reusable, colours come from
`context.theme` unless the value is intentionally identical in both themes.

## Checklist before calling a shared widget done

- [ ] Variants are named constructors or an enum — not three booleans
- [ ] Every piece of state the parent cares about leaves via a callback
- [ ] No import from `features/`
- [ ] `const` constructor, `super.key` first
- [ ] Colours/sizes/styles come from tokens, and it survives dark mode
- [ ] Conditional sub-parts are private `Widget?` getters
- [ ] It is used by two or more callers — otherwise it belongs to the feature
