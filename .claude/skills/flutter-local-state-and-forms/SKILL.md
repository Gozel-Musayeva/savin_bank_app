---
name: flutter-local-state-and-forms
description: Use when adding state or a form to a Flutter screen without a backend layer — choosing setState vs Cubit, the Cubit-owns-its-controller pattern, TextEditingController lifecycle, Form + GlobalKey validation, picker-backed fields, and search/filter lists. Trigger on "add a form", "validate this input", "this screen needs state", "share state between screens", "search/filter a list", "date picker field", or a StatefulWidget being created.
---

# Local state and forms

Two tools only: `setState` for state one screen owns, a `Cubit` for state that
outlives or spans a screen. Reach for the second only when the first stops
working.

## Which one

| Situation | Tool |
|---|---|
| Current onboarding page index, a toggled checkbox, password visibility, a filtered list | `setState` |
| A form's controllers on one screen | `setState` (or none — controllers notify themselves) |
| A value a **pushed screen must edit and the pusher must see** | `Cubit` |
| State surviving navigation, or read by widgets in different subtrees | `Cubit` |
| Anything with async loading / error / success phases | `Cubit` |

Do not start with a Cubit "because it's cleaner". A screen whose state dies
with it is `setState` state. Promote when a second screen needs to read or
write it — that is the actual signal, and it is unambiguous.

## The `setState` house style

Mutate, then flush:

```dart
void _onSelect(CountryModel country) {
  if (_selectedCountry == country) return;   // guard: skip pointless rebuilds
  _selectedCountry = country;
  setState(() {});
}
```

Assignment outside, empty `setState(() {})` after. It keeps every handler the
same shape and puts the guard clause where you can see it. Consistency matters
more than which of the two forms you pick — but pick one.

Every mutation lives in a named `_onX` / `_verbNoun` method, never inline in a
`build`. `build` reads as a description of the UI; handlers read as a list of
what the screen can do.

## Controller lifecycle — non-negotiable

```dart
late final TextEditingController _emailController;

@override
void initState() {
  _emailController = TextEditingController();
  super.initState();
}

@override
void dispose() {
  _emailController.dispose();
  super.dispose();
}
```

Every `TextEditingController`, `PageController`, `ScrollController`,
`StoryController`, `AnimationController` created by a widget is disposed by
that widget. A missed `dispose` is a leak the analyzer will not report.

`late final` + `initState` (rather than a field initialiser) keeps creation and
disposal visibly paired, and works when construction needs `context` or
`widget`. Prefix private: `_emailController`, not `emailController` — a
controller is never part of the widget's public surface.

## Cubit: state, and the controllers that belong to it

When the state is a single value, the Cubit's type parameter **is** that value —
no state class, no `freezed`:

```dart
class SelectCountryCubit extends Cubit<CountryModel> {
  SelectCountryCubit() : super(CountryModel.countries.first);

  final phoneController = TextEditingController(
    text: CountryModel.countries.first.phoneCode,
  );

  void selectCountry(CountryModel country) {
    emit(country);
    phoneController.text = country.phoneCode!;
  }

  @override
  Future<void> close() {
    phoneController.dispose();     // the Cubit owns it, so the Cubit frees it
    return super.close();
  }
}
```

Two things worth copying:

- **A controller that must survive across screens belongs to the Cubit, not to
  either screen.** Both the profile form and the country picker touch the phone
  field; neither can own it. Whoever owns a controller disposes it — here, in
  `close()`.
- Write a `<X>State` class only once the state has more than one field. A
  `Cubit<CountryModel>` is complete and readable; wrapping it in a one-field
  state class buys nothing.

Provide it in `Pager` (`BlocProvider` to create, `BlocProvider.value` to hand
to a pushed route) and read it with `context.read<T>()` for actions,
`BlocBuilder` for the parts of the UI that must rebuild:

```dart
countryFlag: BlocBuilder<SelectCountryCubit, CountryModel>(
  builder: (context, country) => Image.asset(country.flag, height: 20.r, width: 20.r),
),
```

Wrap the smallest widget that actually changes — a `BlocBuilder` around a whole
`Scaffold` rebuilds the screen to repaint a flag.

Cache the Cubit in `initState` when a handler needs it after an `await` or in
`dispose`: `_cubit = context.read<SelectCountryCubit>();` — `context.read` is
unsafe once the widget may be unmounted.

## Forms

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(children: [
    CustomInput(
      controller: _emailController,
      hintText: 'Email',
      keyboardType: TextInputType.emailAddress,
      validator: (v) {
        if (v == null || v.isEmpty) return 'Email can\'t be empty';
        if (!ValidatorUtils.isValidEmail(v)) return 'Email format is not valid';
        return null;
      },
    ),
    CustomButton(
      text: 'Continue',
      onPressed: () {
        if (!_formKey.currentState!.validate()) return;   // guard, then act
        Go.to(context, Pager.followSomeone);
      },
    ),
  ]),
)
```

- Validators return `null` for valid, a message for invalid. Empty-check first,
  format second — the user gets the most useful message.
- Reusable rules (`isValidEmail`, phone, password strength) live in
  `core/utils/validator_utils.dart` as static methods over a private `RegExp`,
  so the pattern is compiled once and tested once.
- `if (!validate()) return;` before every submit. A commented-out validate call
  next to a live submit button is a form that silently accepts anything.
- The input widget owns *presentation* of the error; the page owns the *rule*.

## Picker-backed fields

A field the user must not type into, only pick:

```dart
GestureDetector(
  onTap: () async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (date == null) return;                      // cancelled
    _birthdayController.text = date.year.toString();
    _formKey.currentState!.validate();             // clear a stale error now
    setState(() {});
  },
  child: AbsorbPointer(
    child: CustomInput(controller: _birthdayController, hintText: 'Date of Birth'),
  ),
)
```

`AbsorbPointer` blocks the keyboard while the outer `GestureDetector` still
receives the tap. Re-validating right after writing the value removes the
"required" error the moment it stops being true.

Same shape for image picking — wrap the plugin in `core/utils/`, return a
nullable path, bail on `null`:

```dart
final path = await ImagePickerUtil.pickGalleryImage();
if (path == null) return;
_filePath = path;
setState(() {});
```

If anything is `await`ed before touching `context`, guard with
`if (!mounted) return;` first.

## Keyboard and input hygiene

- `onTapOutside: (_) => FocusScope.of(context).unfocus()` on text fields —
  tapping the background should dismiss the keyboard.
- `keyboardType` on every field: `.emailAddress`, `.phone`, `.number`.
- `inputFormatters` to make bad input impossible rather than invalid:
  `FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))`.
- Wrap form screens in `SingleChildScrollView` — the keyboard halves the
  viewport and an unscrollable column overflows.

## Search and filter

```dart
void _filterCountries(String query) {
  _visibleCountries = CountryModel.countries
      .where((e) => e.name.toLowerCase().startsWith(query.toLowerCase()))
      .toList();
  setState(() {});
}
```

Always filter the **full source list**, never the previously filtered one —
filtering the filtered list makes deleting a character unable to bring results
back. Keep the source `const` and the visible list derived. Prefer `contains`
over `startsWith` unless the design says otherwise; users search mid-word.
