import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final TextEditingController? controller;
  final String? label, hint, msgError;
  final TextInputType? keyboardType;
  const CustomForm({super.key, required this.controller, this.label, this.hint, this.msgError, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
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
