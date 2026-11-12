---
name: dart-modern-syntax
description: Use when writing or modernising Dart 3.x Flutter code — enum/static dot-shorthands, the Row/Column spacing parameter, wildcard parameters, collection-if and spreads in widget trees, extensions that cut boilerplate, and which older idioms to stop writing. Trigger on "modernise this", "cleaner syntax", "is there a shorter way", verbose enum-heavy widget code, or setting the SDK constraint on a new project.
---

# Modern Dart syntax in Flutter

Language features that measurably shorten widget code. Use them consistently or
not at all — half-adopted syntax is worse than either.

Everything here needs `sdk: ^3.9.0` or newer in `pubspec.yaml`; dot-shorthands
need `^3.12.0`. Check the constraint before using them, and do not sprinkle
them into a codebase written in the older style — convert a file at a time.

## Dot-shorthands (Dart 3.12)

When the type is already known from context, drop the type name:

```dart
Row(
  mainAxisSize: .min,                       // MainAxisSize.min
  crossAxisAlignment: .center,              // CrossAxisAlignment.center
)

static const FontWeight _bold = .w700;      // FontWeight.w700

ThemeData(
  colorScheme: .fromSeed(seedColor: …),     // ColorScheme.fromSeed
)
```

Works for enum values, static constants, and static constructors alike. It is
at its best in dense widget trees where `MainAxisAlignment.spaceBetween` is
half the line.

**Where not to use it:** when the type is *not* obvious at a glance — a
variable declared far from its use, an argument whose parameter name doesn't
hint at the type. `mainAxisSize: .min` reads fine; `value: .medium` does not.
The reader must be able to name the type without scrolling.

## `spacing` on Row / Column / Flex

```dart
Row(spacing: 20.w, children: [a, b, c])              // one gap value
Column(spacing: 24.h, children: [x, y])
```

Replaces interleaved `SizedBox`es when every gap is equal. Uneven rhythm still
uses explicit spacers — see `flutter-responsive-sizing`.

Note `spacing` does not apply inside `Wrap` (`Wrap` has its own `spacing` /
`runSpacing`) and has no effect with a single child.

## Wildcard parameters

`_` is a true throwaway now, and repeatable:

```dart
separatorBuilder: (_, _) => 24.verticalSpace,       // both args unused
builder: (_, child) => MaterialApp(home: child),
itemBuilder: (_, i) => PostCard(post: posts[i]),
```

Name only what you use. Two `_`s in one signature is legal and is the point —
before Dart 3.7 you had to invent `__`.

## Collection-if and spreads

Build the tree declaratively instead of pushing onto a list:

```dart
Row(children: [
  SvgPicture.asset(icon),
  if (withText) ...[                       // spread a whole group
    12.horizontalSpace,
    Text(text, style: …),
  ],
])

actions: [...?actions, 8.horizontalSpace], // null-aware spread
```

`...?` is the one to remember: it spreads a nullable list and contributes
nothing when it is `null`, so an optional `List<Widget>?` parameter needs no
`?? []` and no branch.

For a fixed repeat, a `for` in a collection literal beats `List.generate`:

```dart
children: [
  for (var i = 0; i < 3; i++) _Dot(isActive: i == currentPage),
  for (final item in NavBarModel.navList)
    if (item.index != addButtonIndex) _NavItem(item) else const AddButton(),
]
```

## Extensions that remove real noise

Keep them tiny and in `core/extensions/`:

```dart
extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ColorExtensions on Color {
  ColorFilter get toColorFilter => ColorFilter.mode(this, BlendMode.srcIn);
}

extension WidgetStatePropertyAllX<T> on T {
  WidgetStatePropertyAll<T> get wspAll => WidgetStatePropertyAll<T>(this);
}
```

Each earns its place by cutting a construction that appears dozens of times —
`AppColors.primary500.toColorFilter` instead of the full `ColorFilter.mode(…)`
on every `SvgPicture`. A generic extension on `T` like `wspAll` applies to
everything, so keep the name unmistakable and the count near zero.

Do **not** add extensions that merely rename something (`context.push` for
`Navigator.push`) — that is indirection, not brevity.

## Records for small groupings

```dart
({double width, double height}) get _pinSize => (width: 78.w, height: 61.h);
```

Good for a pair returned from a private helper or passed to a builder. Once it
crosses a layer boundary or gains behaviour, promote it to a class.

## Patterns instead of chained `is` / `if`

```dart
final message = switch (status) {
  Status.loading => 'Loading…',
  Status.empty   => 'Nothing here yet',
  Status.error   => 'Something went wrong',
};
```

An exhaustive `switch` expression over an enum or sealed type makes adding a
case a **compile error at every handler** — the reason to prefer it over
`if`-chains, which just silently take the last branch.

## Stop writing these

| Old | New |
|---|---|
| `SizedBox(height: 24)` between siblings | `24.verticalSpace`, or `spacing:` |
| `MainAxisSize.min` | `.min` |
| `(context, index) => …` with both unused | `(_, _) => …` |
| `color.withOpacity(0.5)` | `color.withValues(alpha: 0.5)` — `withOpacity` is deprecated and loses precision |
| `List.generate(3, (i) => …)` inside `children` | `for (var i = 0; i < 3; i++)` |
| `if (list != null) ...list` | `...?list` |
| `Theme.of(context)` repeated in one build | `context.theme` |
| `MediaQuery.of(context).size.width` | `1.sw` (with screenutil) |

## Guardrails

- `analysis_options.yaml` should enable at least `prefer_const_constructors`,
  `prefer_const_declarations`, `prefer_const_literals_to_create_immutables`,
  `prefer_const_constructors_in_immutables`. `const` in a widget tree is a real
  rebuild saving, not style.
- `flutter analyze` clean and `dart format` run before any work is called done.
- New syntax is not a licence to be clever. If a reader has to pause, write the
  longer form.
