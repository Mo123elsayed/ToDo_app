import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/authentication/presentation/controllers/forget_password_cubit/forget_password_cubit.dart';
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
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('reset_password').tr(),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Enter_your_email_to_rest_your_password'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'IBM',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15),
                CustomTextFormField(
                  label: 'email'.tr(),
                  inputType: TextInputType.emailAddress,
                  controller: emailController,
                  secureText: false,
                  validator: (p0) => AppValidator.validateEmail(p0),
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 20),
                Center(
                  child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordLoading) {
                        showAboutDialog(
                          context: context,
                          children: [
                            Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 20),
                                Text(
                                  'loading'.tr(),
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'IBM',
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      if (state is ForgetPasswordSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              state.message,
                              style: TextStyle(
                                color: AppColors.white,
                                fontFamily: 'IBM',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      } else if (state is ForgetPasswordFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              state.errorMessage,
                              style: TextStyle(
                                color: AppColors.white,
                                fontFamily: 'IBM',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.transparent,
                          border: Border.all(color: AppColors.black, width: 1),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<ForgetPasswordCubit>()
                                  .forgetPassword(emailController.text.trim());
                            }
                          },
                          child: Text(
                            'send_reset_link'.tr(),
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 16,
                              fontFamily: 'IBM',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
