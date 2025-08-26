import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/app_color.dart';

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
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.inputType,
    this.controller,
    this.secureText,
    this.maxLines,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppColors.white, fontFamily: "IBM"),
      maxLines: maxLines ?? 1,
      validator: (value) => validator(value),
      obscureText: secureText!,
      controller: controller,
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.start,
      keyboardAppearance: Brightness.dark,
      decoration: InputDecoration(
        hintText: "$label",
        hintStyle: TextStyle(color: AppColors.white, fontFamily: "IBM"),
        alignLabelWithHint: false,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.transparent,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: AppColors.white, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 2.0),
          gapPadding: 5,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
