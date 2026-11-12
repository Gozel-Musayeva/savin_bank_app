---
name: flutter-navigation-pager
description: Use when adding a screen or moving between screens in a Flutter app that navigates with a Go facade over Navigator plus a central Pager page registry — registering pages, push vs replace vs removeAll, passing a Cubit into a pushed route, back-button handling, and when to graduate to go_router. Trigger on "navigate to", "open this screen", "go back", "register a page", "after login go to home", or any Navigator.push being written.
---

# Navigation: `Go` + `Pager`

Two files in `core/navigation/`. `Go` owns the *verbs*, `Pager` owns the
*destinations*. A screen names a destination and picks a verb; it never
touches `Navigator` or `MaterialPageRoute`.

If the project has `go_router` in `pubspec.yaml`, ignore this skill and use
that project's routing conventions instead.

## `go.dart` — the verbs

```dart
class Go {
  Go._();

  static void to(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  static void replace(BuildContext context, Widget page) =>
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));

  static void removeAll(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => page), (_) => false,
      );

  static void back(BuildContext context) => Navigator.pop(context);
  static bool canBack(BuildContext context) => Navigator.canPop(context);
}
```

Note the `removeAll` predicate: `(_) => false` means "pop everything". Write it
that way — a clever predicate like `(route) => route.isCurrent` happens to work
and reads like a bug forever after.

Add `Future<T?> toResult<T>(…)` returning `Navigator.push<T>` only when a screen
actually needs to return a value.

## `pager.dart` — the destinations

```dart
class Pager {
  Pager._();

  static const splash = SplashPage();
  static const login = LoginPage();
  static const main = MainPage();

  // needs its own Cubit
  static Widget get fillProfile => BlocProvider(
    create: (_) => SelectCountryCubit(),
    child: const FillProfilePage(),
  );

  // reuses the Cubit already above it in the tree
  static Widget selectCountry(BuildContext context) => BlocProvider.value(
    value: context.read<SelectCountryCubit>(),
    child: const SelectCountryPage(),
  );
}
```

Three forms, and the form tells you what the page needs:

| Form | Means |
|---|---|
| `static const x = XPage()` | plain page, no dependencies — the default |
| `static Widget get x => BlocProvider(create: …)` | owns a fresh Cubit; `get`, so each push builds a new one |
| `static Widget x(BuildContext c) => BlocProvider.value(…)` | shares a Cubit from the pusher's context |

**`BlocProvider.value` is the only correct way to hand a Cubit to a pushed
route.** A pushed route sits outside the pusher's subtree, so the provider does
not reach it — `context.read<T>()` on the new page throws
`ProviderNotFoundException`. `.value` re-exposes the same instance without
re-creating or disposing it.

Why a registry at all: every destination in the app is one file you can read
top to bottom, `const` pages are allocated once, and a renamed page breaks in
exactly one place.

## Picking the verb

| Intent | Verb |
|---|---|
| Detail screen the user comes back from | `Go.to` |
| Step forward in a flow they must not return to (splash → onboard, onboard → welcome, login ⇄ register, OTP → new password) | `Go.replace` |
| Entering the app after auth, or logging out | `Go.removeAll` |
| Dismiss / done | `Go.back` |

Getting this wrong is the classic bug: `Go.to` from login to home leaves the
login screen under the app, and the back button walks the user out of their
session.

## Async navigation needs a mounted guard

```dart
void _waitThenGo() async {
  await Future.delayed(AppDurations.s2);
  if (!mounted) return;          // widget may be gone; context would be dead
  Go.replace(context, Pager.onboard);
}
```

Every `await` before a `context` use needs this — a `Future.delayed`, an image
pick, an API call. Called from `initState`, never `build`.

## The back button follows the stack

`CustomAppBar` reads `Go.canBack(context)` and draws a back arrow only when
there is something to pop, adjusting `titleSpacing` to match. That means no
screen ever passes `showBack: true` — the stack already knows.

## Returning a value

The pushed screen writes to shared state, then pops:

```dart
onPressed: () {
  _selectCountryCubit.selectCountry(_selectedCountry);   // commit
  Go.back(context);                                       // then leave
}
```

Cleaner than `Navigator.pop(context, value)` when several widgets need the
result: whoever listens to the Cubit updates, no plumbing through callbacks.

## When to graduate to `go_router`

`Go` + `Pager` is right for a linear, phone-only app. Switch when any of these
becomes true — and switch wholesale, not per screen:

- deep links or web URLs
- a nested navigator per bottom-nav tab, keeping per-tab history
- auth redirect guards ("any route while logged out lands on login")
- more than ~20 destinations, or arguments passed through several hops

Below that line, `go_router` is ceremony. Above it, `Pager` becomes a second,
worse router.

## Anti-patterns

- `Navigator.push(context, MaterialPageRoute(...))` in a page — bypasses `Go`
  and the registry; the transition and stack behaviour drift per screen.
- A widget in `common/` calling `Go.to(context, Pager.someFeaturePage)` —
  shared code must not know feature destinations. Take an
  `onTap`/`VoidCallback` and let the caller navigate.
- A page registered in `Pager` that nothing pushes — dead route, delete it.
- `main.dart` opening a mid-flow page (`home: Pager.chat`) — a debugging
  shortcut that reaches production. Ship `Pager.splash`.
