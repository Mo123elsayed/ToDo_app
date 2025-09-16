import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:todo_app/core/theme/app_color.dart';
import 'package:todo_app/core/validator/app_validator.dart';
import 'package:todo_app/authentication/presentation/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  static const String screenRoute = '/forget-password';

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reset_password').tr(),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 40),
            CustomTextFormField(
              title: "Enter_your_email_to_rest_your_password".tr(),
              label: 'email'.tr(),
              prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
              inputType: TextInputType.emailAddress,
              controller: emailController,
              secureText: false,
              validator: (p0) => AppValidator.validateEmail(p0),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
                border: Border.all(color: AppColors.black, width: 1),
              ),
              child: TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
                child: Text('send_reset_link'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
