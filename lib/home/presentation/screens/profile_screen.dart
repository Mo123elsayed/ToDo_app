import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/authentication/presentation/controllers/profile_cubit/profile_cubit.dart';
import 'package:todo_app/core/theme/app_color.dart';
import 'package:todo_app/core/theme/app_text.dart';
import 'package:todo_app/authentication/presentation/screens/change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String screenRoute = '/profile';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileInfo(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is ProfileFailure) {
                      Center(child: Text(state.message));
                    }
                  },
                  builder: (context, state) {
                    if (state is ProfileSuccess) {
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: screenSize.width * 0.15,
                            child: Icon(
                              Icons.person,
                              size: screenSize.width * 0.15,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Text(
                            state.userModel.fullName,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: AppText.fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.01),
                          Text(
                            state.userModel.email,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: AppText.fontFamily,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),

              SizedBox(height: screenSize.height * 0.04),
              GestureDetector(
                child: personalDataRow(title: "change_password".tr()),
                onTap: () => Navigator.of(
                  context,
                ).pushNamed(ChangePasswordScreen.screenRoute),
              ),
              SizedBox(height: screenSize.height * 0.01),
              SwitchListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                title: Text(
                  'Change_Language'.tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppText.fontFamily,
                  ),
                ),
                value: context.locale.languageCode == 'ar',
                onChanged: (value) {
                  Locale newLocale = value ? Locale('ar') : Locale('en');
                  context.setLocale(newLocale);
                },
              ),
              SizedBox(height: screenSize.height * 0.04),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'logout'.tr(),
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: AppText.fontFamily,
                    color: AppColors.darkPink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A personal data row widget to display the user's data.
  ///
  /// This widget takes three parameters, [title], [nameValue], and [onTap].
  /// [title] is the title of the row, [nameValue] is the value of the user's data,
  /// and [onTap] is the callback function to be called when the row is tapped.
  /// It returns a [Row] widget that contains a [Text] widget for the title,
  /// a [Spacer] widget to align the widgets to the right, a [Text] widget for the value,
  /// and an [IconButton] widget to navigate to the details page.
  Widget personalDataRow({
    String? title,
    String? nameValue,
    VoidCallback? onTap,
  }) {
    return Row(
      children: [
        Text(
          '$title',
          style: TextStyle(fontSize: 20, fontFamily: AppText.fontFamily),
        ),
        Spacer(),
        Text(
          nameValue ?? '',
          style: TextStyle(
            fontSize: 16,
            fontFamily: AppText.fontFamily,
            color: Colors.black54,
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios_rounded),
          onPressed: onTap,
        ),
      ],
    );
  }
}
