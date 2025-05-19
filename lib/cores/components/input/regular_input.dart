import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhome/cores/cores.dart';

class RegularTextInput extends StatelessWidget {
  const RegularTextInput({
    super.key,
    required this.hintText,
    this.controller,
    this.enabled = true,
    this.inputFormatters,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.prefixIcon,
    this.label,
    this.required = false,
    this.onChanged,
    this.suffix,
    this.keyboardType,
    this.textCapitalization,
  });

  final String hintText;
  final TextEditingController? controller;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final IconData? prefixIcon;
  final String? label;
  final bool required;
  final ValueChanged<String>? onChanged;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...[
          LabelInput(label: label, required: required),
          Dimens.dp8.height,
        ],
        TextFormField(
          controller: controller,
          textCapitalization: textCapitalization ?? TextCapitalization.words,
          enabled: enabled,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            hintText: hintText,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
