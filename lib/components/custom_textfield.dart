import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final int? maxLines;
  final bool? enabled;
  final bool readOnly;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;
  final TextInputAction? inputAction;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    this.keyboardType,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.maxLength = 30,
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onSaved,
    this.maxLines,
    this.onChanged,
    this.enabled,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.inputAction,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      autocorrect: false,
      textCapitalization: textCapitalization,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      enabled: enabled,
      autofocus: autofocus,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      maxLines: maxLines,
      textInputAction: inputAction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF666666), fontSize: 13),
        filled: true,
        fillColor: const Color(0x99E4E4E4),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xFFE4E4E4), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Color(0xFFE4E4E4), width: 1),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
