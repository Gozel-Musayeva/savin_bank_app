import 'package:flutter/material.dart';

extension WidgetStatePropertyAllX<T> on T {
  WidgetStatePropertyAll<T> get wspAll => WidgetStatePropertyAll<T>(this);
}

extension ColorExtensions on Color {
  ColorFilter get toColorFilter => ColorFilter.mode(this, BlendMode.srcIn);
}
