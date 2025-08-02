import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  /// A custom text form field widget.
  ///
  /// [label] is the text displayed as the label of the form field.
  /// [prefixIcon] is the widget displayed at the start of the form field.
  /// [suffixIcon] is the widget displayed at the end of the form field.
  /// [inputType] is the type of data that the form field accepts.
  /// [controller] is used to control the text being edited.
  /// [secureText] determines whether the text in the form field is obscured.
  /// [validator] is a function that validates the text entered in the form field.

  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool? secureText;
  final String? Function(String?) validator;

  const CustomTextFormField({super.key, 
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.controller,
    this.secureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validator(value),
      obscureText: secureText!,
      controller: controller,
      keyboardType: inputType,
      keyboardAppearance: Brightness.dark,
      decoration: InputDecoration(
        label: Text("$label"),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        floatingLabelStyle: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Color.fromRGBO(179, 178, 234, 0.15),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        border: OutlineInputBorder(
          gapPadding: 5,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
