import 'package:flutter/material.dart';

/// App-wide scrolling: content stops at its edges instead of stretching
/// (Android 12+) or bouncing (iOS) when pulled past them.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
