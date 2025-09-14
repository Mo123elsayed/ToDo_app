import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:todo_app/core/theme/app_color.dart';
import 'package:todo_app/core/validator/app_validator.dart';

class ChangePassword extends StatefulWidget {
  static const screenRoute = '/change-password';

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              CustomTextFormField(
                validator: (p0) => AppValidator.validatePassword(p0!),
                label: 'current_password'.tr(),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => isVisible = !isVisible),
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                controller: passwordController,
                secureText: isVisible,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                validator: (p0) => AppValidator.validatePassword(p0!),
                label: 'new_password'.tr(),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => isVisible = !isVisible),
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                controller: passwordController,
                secureText: isVisible,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                validator: (p0) => AppValidator.validatePassword(p0!),
                label: 'confirm_new_password'.tr(),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => isVisible = !isVisible),
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                controller: passwordController,
                secureText: isVisible,
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
                child: GestureDetector(
                  onTap: () {
                    if(formKey.currentState!.validate()){
                      
                    }
                  },
                  child: Text('change_password'.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
