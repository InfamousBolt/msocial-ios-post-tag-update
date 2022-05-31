import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final String? initialValue;
  final bool isObscure;
  final IconData? icon;
  final Widget? trailing;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onSave;
  final TextInputType? keyboardType;
  final double borderRadius;
  final int? maxLength;
  final String? helperText;
  final String? errorText;
  final double? labelSize;
  final List<TextInputFormatter>? formatters;
  final EdgeInsets? margin;
  final int? maxLines;
  final int? minLines;

  const AppTextFormField({
    Key? key,
    this.label,
    this.controller,
    this.initialValue,
    this.isObscure = false,
    this.icon,
    this.trailing,
    this.validator,
    this.onSave,
    this.keyboardType,
    this.borderRadius = 10,
    this.maxLength,
    this.helperText,
    this.errorText,
    this.labelSize,
    this.formatters,
    this.margin,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: margin ?? const EdgeInsets.all(8),
      constraints: BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        initialValue: controller == null ? initialValue : null,
        controller: controller,
        autofocus: true,
        style: theme.textTheme.subtitle2,
        obscureText: isObscure,
        validator: validator,
        keyboardType: keyboardType,
        maxLength: maxLength,
        onFieldSubmitted: onSave,
        onSaved: onSave,
        maxLines: maxLines,
        minLines: minLines,
        inputFormatters: formatters,
        decoration: InputDecoration(
          counterStyle: TextStyle(fontSize: 0),
          filled: true,
          errorStyle: theme.textTheme.caption!.copyWith(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          labelText: label,
          labelStyle: TextStyle(fontSize: labelSize),
          helperText: helperText,
          errorText: errorText,
          prefixIcon: icon == null
              ? null
              : Padding(padding: EdgeInsets.only(left: 4), child: Icon(icon)),
          suffixIcon: trailing == null
              ? null
              : Padding(padding: EdgeInsets.only(right: 12), child: trailing),
        ),
      ),
    );
  }
}
