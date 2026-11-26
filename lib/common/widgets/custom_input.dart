import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_text_style.dart';
import '../../core/extensions/color_extensions.dart';
import '../../core/extensions/context_extension.dart';

/// Figma "Form" component: optional label above a light-grey field.
///
/// States: empty → no border, focused or filled → 1px brand border,
/// invalid → error border + message. Fill, radius and hint come from
/// `inputDecorationTheme`, so both themes work.
class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.isPassword = false,
    this.errorText,
    this.readOnly = false,
    this.onTap,
    this.style,
    this.highlightFilled = true,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool isPassword;

  /// Error set by the page (e.g. wrong credentials), shown like a
  /// validator error: red border + message under the field.
  final String? errorText;

  /// Picker-backed field: no keyboard, [onTap] opens the picker and the page
  /// writes the choice into [controller].
  final bool readOnly;
  final VoidCallback? onTap;

  /// Overrides the default 12 Regular text (e.g. a large amount field).
  final TextStyle? style;

  /// Brand border once the field has text. Off for display-only fields
  /// (e.g. Detail Account), which stay plain grey.
  final bool highlightFilled;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late final TextEditingController _controller;
  late final bool _ownsController;
  late bool _obscure;

  bool get _hasText => _controller.text.isNotEmpty;

  @override
  void initState() {
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
    _obscure = widget.isPassword;
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  /// Rebuild only when the empty ↔ filled border state flips.
  bool _wasFilled = false;
  void _onTextChanged() {
    if (_wasFilled == _hasText) return;
    _wasFilled = _hasText;
    setState(() {});
  }

  void _toggleObscure() {
    _obscure = !_obscure;
    setState(() {});
  }

  /// A `FormField` around a plain `TextField`, so the error message can be
  /// laid out by us: Figma puts it 8 below the field, flush with its left
  /// edge — `InputDecorator` would indent it by the content padding.
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (_) => widget.validator?.call(_controller.text),
      builder: (state) {
        final message = widget.errorText ?? state.errorText;
        return Column(
          crossAxisAlignment: .start,
          spacing: AppSizes.inputLabelGap.h,
          children: [
            if (widget.label case final label?)
              Text(
                label,
                style: AppTextStyles.bodyMediumSemiBold.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
            _field(state, hasError: message != null),
            if (message != null)
              Text(
                message,
                style: AppTextStyles.bodyMediumRegularTight.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _field(FormFieldState<String> state, {required bool hasError}) {
    return TextField(
      controller: _controller,
      obscureText: _obscure,
      readOnly: widget.readOnly,
      showCursor: !widget.readOnly,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      onChanged: (value) {
        state.didChange(value);
        widget.onChanged?.call(value);
      },
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      cursorColor: AppColors.primary500,
      textAlignVertical: .center,
      style: (widget.style ?? AppTextStyles.bodySmallRegularTight).copyWith(
        color: context.colors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        // Empty error widget: red border from the theme, message drawn above.
        error: hasError ? const SizedBox.shrink() : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.inputPadding.w,
          vertical: widget.isPassword
              ? AppSizes.inputPasswordPaddingV.h
              : AppSizes.inputPadding.h,
        ),
        enabledBorder: _hasText && widget.highlightFilled
            ? _filledBorder
            : null,
        prefixIcon: widget.prefixIcon,
        suffixIcon: _suffix,
        // Figma: the 20px eye + 14px padding top/bottom sets the 48px height.
        suffixIconConstraints: BoxConstraints(
          minHeight:
              (AppSizes.inputIcon + AppSizes.inputPasswordPaddingV * 2).h,
        ),
      ),
    );
  }

  InputBorder get _filledBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSizes.radiusInput.r),
    borderSide: const BorderSide(color: AppColors.primary500),
  );

  Widget? get _suffix {
    if (!widget.isPassword) return widget.suffixIcon;
    // Figma: "Show" while empty or revealed, "Hide" while masked text is shown.
    final masked = _obscure && _hasText;
    return Padding(
      padding: EdgeInsets.only(right: AppSizes.inputPadding.w),
      child: GestureDetector(
        onTap: _toggleObscure,
        behavior: .opaque,
        child: SvgPicture.asset(
          masked ? AppAssets.eyeHide : AppAssets.eyeShow,
          width: AppSizes.inputIcon.r,
          height: AppSizes.inputIcon.r,
          colorFilter:
              (masked
                      ? context.colors.textPrimary
                      : context.colors.textSecondary)
                  .toColorFilter,
        ),
      ),
    );
  }
}
