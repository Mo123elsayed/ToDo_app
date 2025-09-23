import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/authentication/presentation/controllers/login_cubit/login_cubit.dart';
import 'package:todo_app/authentication/presentation/controllers/profile_cubit/profile_cubit.dart';
import 'package:todo_app/authentication/presentation/screens/forget_password_screen.dart';
import 'package:todo_app/authentication/presentation/screens/sign_up_screen.dart';
import 'package:todo_app/authentication/presentation/widgets/custom_text_form_field.dart';
import 'package:todo_app/authentication/presentation/widgets/logo.dart';

import 'package:todo_app/core/validator/app_validator.dart';
import 'package:todo_app/home/presentation/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const screenRoute = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // const LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  bool isVisible = true;

  @override
  /// Builds the widget with a Scaffold that contains a AppBar with a leading
  /// TextButton to switch between languages, a body with a Form that contains
  /// two [CustomTextFormField] to input email and password, a TextButton to
  /// log in with Firebase, a Row with two Divider and a Text in the middle
  /// to separate between the Firebase log in and the Google log in and the
  /// Facebook log in, and a TextButton to log in with Google and a TextButton
  /// to log in with Facebook, and a TextButton to navigate to the sign up
  /// screen.
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => LoginCubit(),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Logo(),

                      SizedBox(height: 40),
                      CustomTextFormField(
                        label: 'email'.tr(),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        inputType: TextInputType.emailAddress,
                        controller: emailController,
                        secureText: false,
                        validator: (p0) => AppValidator.validateEmail(p0),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        label: 'password'.tr(),
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => isVisible = !isVisible),
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                        controller: passwordController,
                        secureText: isVisible,
                        validator: (p0) => AppValidator.validatePassword(
                          passwordController.text,
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 30),
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if (state is LoginFailure) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Login Failed'),
                                  content: Text(
                                    state.message,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "IBM",
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          if (state is LoginSuccess) {
                            Navigator.pushReplacementNamed(
                              context,
                              HomeScreen.screenRoute,
                            );
                            context.read<ProfileCubit>().getProfileInfo();
                          }
                        },
                        builder: (context, state) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xffEA3F7E),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<LoginCubit>().logInWithFireBase(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                }
                              },
                              child: state is LoginLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )
                                  : Text(
                                      'sign_in'.tr(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     SizedBox(width: 160, child: Divider()),
                      //     Container(
                      //       padding: EdgeInsets.only(left: 10, right: 10),
                      //       child: Text(
                      //         'or'.tr(),
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: screenSize.width * 0.37,
                      //       child: Divider(),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 10),
                      // buildOnTapContainer(
                      //   context,
                      //   icon: SvgPicture.asset(
                      //     'assets/images/google-logo-search-new-svgrepo-com.svg',
                      //   ),
                      //   label: "login_with_google".tr(),
                      // ),
                      // SizedBox(height: 10),
                      // buildOnTapContainer(
                      //   context,
                      //   icon: SvgPicture.asset(
                      //     'assets/images/facebook-icon-logo-svgrepo-com.svg',
                      //     height: 25,
                      //     width: 25,
                      //   ),
                      //   label: "login_with_facebook".tr(),
                      // ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ForgetPasswordScreen.screenRoute,
                          );
                        },
                        child: Text(
                          "forget_password".tr(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("dont_have_account".tr()),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                SignUpScreen.screenRoute,
                              );
                            },
                            child: Text(
                              "register".tr(),
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOnTapContainer(
    BuildContext context, {
    Widget? icon,
    String? label,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            icon!,
            SizedBox(width: 80),
            Text(
              label!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
