import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_text_style.dart';
import '../../core/extensions/context_extension.dart';

/// Themed text field. Fill colour, borders and hint style come from
/// `inputDecorationTheme` in `AppThemes`, so it works in both modes.
class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.isPassword = false,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool isPassword;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late bool _obscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: AppTextStyles.bodyMediumSemiBold.copyWith(
        color: context.colors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _suffix,
      ),
    );
  }

  Widget? get _suffix {
    if (!widget.isPassword) return widget.suffixIcon;
    return IconButton(
      onPressed: () => setState(() => _obscure = !_obscure),
      icon: Icon(
        _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: context.colors.textTertiary,
      ),
    );
  }
}
