import 'package:flutter/widgets.dart';

/// Gives a bottom-nav tab a "back" action even though its route can't pop:
/// the main shell wraps every non-home tab in this scope, and the app bar's
/// back button calls [onBack] (switch to the Home tab) when `Go.canBack` is
/// false.
class TabBackScope extends InheritedWidget {
  const TabBackScope({super.key, required this.onBack, required super.child});

  final VoidCallback onBack;

  static VoidCallback? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TabBackScope>()?.onBack;

  @override
  bool updateShouldNotify(TabBackScope oldWidget) => onBack != oldWidget.onBack;
}
