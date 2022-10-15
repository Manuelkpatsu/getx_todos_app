import 'package:flutter/material.dart';

class CustomDropdownTextField<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final FormFieldValidator<T?>? validator;
  final String hintText;
  final void Function(T?)? onChanged;

  const CustomDropdownTextField({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.hintText,
    this.value,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items,
      onChanged: onChanged,
      value: value,
      validator: validator,
      dropdownColor: Colors.white,
      elevation: 16,
      iconSize: 20,
      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF666666)),
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
      ),
    );
  }
}
