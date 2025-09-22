import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/authentication/presentation/controllers/change_password_cubit/change_password_cubit.dart';
import 'package:todo_app/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:todo_app/core/theme/app_color.dart';
import 'package:todo_app/core/validator/app_validator.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const screenRoute = '/change-password';

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isVisible1 = true;
  bool isVisible2 = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          } else if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("change_password".tr()),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    CustomTextFormField(
                      validator: (p0) => AppValidator.validatePassword(p0!),
                      label: 'current_password'.tr(),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => isVisible1 = !isVisible1),
                        icon: Icon(
                          isVisible1 ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      controller: currentPasswordController,
                      secureText: isVisible1,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      validator: (p0) => AppValidator.validatePassword(p0!),
                      label: 'new_password'.tr(),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => isVisible2 = !isVisible2),
                        icon: Icon(
                          isVisible2 ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      controller: newPasswordController,
                      secureText: isVisible2,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      validator: (p0) => AppValidator.validatePassword(p0!),
                      label: 'confirm_new_password'.tr(),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => isVisible2 = !isVisible2),
                        icon: Icon(
                          isVisible2 ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                      controller: confirmPasswordController,
                      secureText: isVisible2,
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
                          if (formKey.currentState!.validate()) {
                            context.read<ChangePasswordCubit>().changePassword(
                              currentPasswordController.text,
                              newPasswordController.text,
                              confirmPasswordController.text,
                            );
                          }
                        },
                        child: Text(
                          'change_password'.tr(),
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                            fontFamily: 'IBM',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
