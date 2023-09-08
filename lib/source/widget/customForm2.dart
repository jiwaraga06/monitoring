import 'package:flutter/material.dart';

class CustomForm2 extends StatelessWidget {
  final TextEditingController? controller;
  final String? label, hint, msgError;
  final Widget? prefixIcon, suffixIcon;
  final bool? obsecureText;
  final TextInputType? textinputtype;
  const CustomForm2({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obsecureText,
    this.msgError,
    this.textinputtype,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText!,
      controller: controller,
      keyboardType: textinputtype,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return msgError;
        }
        return null;
      },
    );
  }
}
