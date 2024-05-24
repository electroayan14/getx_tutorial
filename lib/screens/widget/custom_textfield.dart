import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.validatorText,
    this.textController,
    this.labelText,
    this.hintText,
    this.obscureText,
    this.icon,
  });

  final void Function(String)? onChanged;
  final dynamic validatorText;
  final dynamic labelText;
  final dynamic hintText;
  final bool? obscureText;
  final TextEditingController? textController;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return _customTextField(textController, hintText, validatorText, labelText,
        obscureText, onChanged);
  }

  Widget _customTextField(controller, hintText, validatorText, labelText,
      obscureText, void Function(String)? onChanged) {
    return TextFormField(
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        labelText: labelText ?? '',
        hintText: hintText ?? '',
        suffixIcon: Icon(icon), // Icon on the left
      ),
    );
  }
}
