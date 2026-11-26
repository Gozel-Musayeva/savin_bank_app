import 'package:flutter/material.dart';

class Go {
  Go._();

  static void to(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));

  /// Push a page that pops with a value (e.g. a picker screen).
  static Future<T?> toForResult<T>(BuildContext context, Widget page) =>
      Navigator.push<T>(context, MaterialPageRoute(builder: (_) => page));

  static void replace(BuildContext context, Widget page) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => page),
      );

  static void removeAll(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => page),
        (_) => false,
      );

  /// Drop every route above the first one (the main shell), then push [page]
  /// — a finished flow's result screen whose Back returns to Home.
  static void toAboveRoot(BuildContext context, Widget page) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => page),
        (route) => route.isFirst,
      );

  static void back(BuildContext context) => Navigator.pop(context);

  static bool canBack(BuildContext context) => Navigator.canPop(context);
}
