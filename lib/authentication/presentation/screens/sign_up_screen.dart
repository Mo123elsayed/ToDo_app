import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/authentication/presentation/controllers/sign_up_cubit/sign_up_cubit.dart';
import 'package:todo_app/authentication/presentation/screens/login_screen.dart';
import 'package:todo_app/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:todo_app/authentication/presentation/widgets/logo.dart';
import 'package:todo_app/core/validator/app_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  static const screenRoute = '/signUp-Screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isVisible = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {
                final currentLang = context.locale;
                if (currentLang == Locale('en')) {
                  context.setLocale(Locale('ar'));
                } else {
                  context.setLocale(Locale('en'));
                }
              },
              child: Text(
                "language".tr(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Logo(),
                SizedBox(height: 40),
                CustomTextFormField(
                  validator: (p0) => AppValidator.validateEmail(p0),
                  label: 'email'.tr(),
                  inputType: TextInputType.emailAddress,
                  controller: emailController,
                  prefixIcon: Icon(Icons.email_outlined),
                  secureText: false,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  validator: (p0) => AppValidator.validateName(p0),
                  label: 'full_name'.tr(),
                  inputType: TextInputType.name,
                  controller: nameController,
                  prefixIcon: Icon(Icons.person_2_outlined),
                  secureText: false,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  validator: (p0) => AppValidator.validatePassword(p0!),
                  label: 'password'.tr(),
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => isVisible = !isVisible),
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  controller: passwordController,
                  secureText: isVisible,
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  validator: (p0) => AppValidator.validateConfirmPassword(
                    p0!,
                    passwordController.text,
                  ),
                  label: 'confirm_password'.tr(),
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => isVisible = !isVisible),
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  controller: confirmPasswordController,
                  secureText: isVisible,
                ),
                SizedBox(height: 40),
                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is SignUpLoading) {
                      return CircularProgressIndicator(color: Colors.black54);
                    }
                    if (state is SignUpError) {
                      AlertDialog(
                        title: Text('error'.tr()),
                        content: Text(state.message),
                      );
                    }
                    if (state is SignUpSuccess) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xffEA3F7E),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<SignUpCubit>().signUpWithFirebase(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                          child: Text(
                            'sign_in'.tr(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("have_account".tr()),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          LoginScreen.screenRoute,
                        );
                      },
                      child: Text(
                        "sign_in".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
