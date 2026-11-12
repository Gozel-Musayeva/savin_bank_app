---
name: flutter-responsive-sizing
description: Use when sizing or spacing anything in a Flutter app that uses flutter_screenutil — choosing between .w, .h, .r and .sp, what must never be scaled, spacing with .verticalSpace/.horizontalSpace vs the Row/Column spacing parameter, and the ScreenUtilInit setup. Trigger on "make it responsive", "the layout breaks on small screens", pasted Figma pixel values, overflow errors, or any width/height/padding being written.
---

# Responsive sizing with flutter_screenutil

The design is drawn at one device size. `flutter_screenutil` scales those exact
numbers to every other device, so **Figma numbers go into the code unchanged**
and only pick up a suffix.

## Setup

```dart
// app_sizes.dart
static const figmaDesignSize = Size(428, 926);   // read it off the Figma frame

// main.dart
ScreenUtilInit(
  designSize: AppSizes.figmaDesignSize,
  minTextAdapt: true,
  builder: (_, child) => MaterialApp(…, home: child),
  child: Pager.splash,
)
```

`designSize` must match the Figma frame the design was drawn on. Guess it and
every screen is subtly off. Passing the root page as `child` builds it once
instead of on every `ScreenUtilInit` rebuild.

## Which suffix

| Suffix | Scales by | Use for |
|---|---|---|
| `.w` | screen width | widths, horizontal padding/margin/gaps |
| `.h` | screen height | heights, vertical padding/margin/gaps |
| `.r` | the smaller ratio | **anything square or circular** — icons, avatars, `EdgeInsets.all` |
| `.sp` | text scale | font sizes — and only inside `AppTextStyles` |
| `.sw` / `.sh` | fraction of screen | `1.sw` = full width, `0.5.sh` = half height |

The rule that prevents most bugs: **a square stays square only with `.r`.**

```dart
SvgPicture.asset(AppAssets.search, height: 24.r, width: 24.r);  // circle stays round
SvgPicture.asset(AppAssets.search, height: 24.h, width: 24.w);  // oval on tall phones
```

Same for `EdgeInsets.all(24.r)` — `.all` is symmetric, so it needs the
symmetric unit. Asymmetric padding splits:
`EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h)`.

## What never gets a suffix

- **Border radii** — `BorderRadius.circular(100)`, not `100.r`. A scaled radius
  on a scaled box changes the corner's *proportion*; keep it constant and the
  shape stays the same on every device.
- **Border widths** — `Border.all(width: 2)`. Sub-pixel borders shimmer.
- **Elevations, opacities, flex factors, `Duration`s.**
- **`.sp` outside the type ladder.** Font sizes live in `AppTextStyles` and
  nowhere else; a widget writing `fontSize: 14.sp` has just left the ladder.

## Spacing

Two idioms, one choice rule:

```dart
// Between siblings inside a Row/Column — equal gaps
Row(spacing: 20.w, children: [...])

// Uneven, design-specific rhythm — a spacer per gap
Column(children: [
  53.verticalSpace,
  const AuthTitle.login(),
  53.verticalSpace,
  CustomInput(…),
  24.verticalSpace,
])
```

`spacing:` when every gap is the same, `N.verticalSpace` / `N.horizontalSpace`
when they differ. Never `SizedBox(height: 24.h)` — the extension is the same
thing, shorter, and already width/height-correct.

In lists, the gap belongs to `separatorBuilder`, not to the item:

```dart
ListView.separated(
  separatorBuilder: (_, _) => 24.verticalSpace,
  itemBuilder: (_, i) => …,
)
```

## Common failures

**Overflow on small screens.** Fixed `.h` heights plus a keyboard is the usual
cause. Wrap the body in `SingleChildScrollView` for any form-bearing screen —
every input screen in a well-built app has one.

**Content under the notch or home indicator.** `SafeArea` around bottom-pinned
buttons and bottom nav bars. `SafeArea(top: false, bottom: true, …)` when only
one edge matters.

**A `Spacer` inside a `SingleChildScrollView`** — unbounded height, hard crash.
Use `Spacer` only in a `Column` with a bounded parent (`Center`, `Expanded`).

**`static final` sizes captured before `ScreenUtil` is ready.** Constants that
call `.w`/`.h` at field-initialisation time freeze the first device's values.
Inside `AppTextStyles` and `AppButtonStyle` they are getters or lazily-read
`static final` — keep it that way.

## Reading a design

Take the number from Figma exactly, then classify it:

| Figma says | Code |
|---|---|
| width 88 | `88.w` |
| height 60 | `60.h` |
| icon 24×24 | `24.r` |
| padding 24 all round | `EdgeInsets.all(24.r)` |
| padding 24 left/right | `EdgeInsets.symmetric(horizontal: 24.w)` |
| corner radius 16 | `BorderRadius.circular(16)` — unscaled |
| stroke 2 | `width: 2` — unscaled |
| font 18 semibold | `AppTextStyles.bodyXLargeSemiBold` — a ladder rung, never a raw size |
| full-bleed element | `1.sw` |

Never round or "adjust" a design number because it looks off on your simulator.
If it looks wrong, either `designSize` is wrong or the suffix is.
