import 'package:flutter/material.dart';

class Go {
  Go._();

  static void to(BuildContext context, Widget page) =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));

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

  static void back(BuildContext context) => Navigator.pop(context);

  static bool canBack(BuildContext context) => Navigator.canPop(context);
}
