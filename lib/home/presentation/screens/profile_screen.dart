import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/theme/app_color.dart';
import 'package:todo_app/core/theme/app_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String screenRoute = '/profile';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: SvgPicture.asset('assets/images/profile.svg')),
            SizedBox(height: screenSize.height * 0.04),
            personalDataRow(title: 'Name', nameValue: 'Muhammed ElSayed'),
            personalDataRow(title: 'Change Email'),
            personalDataRow(title: 'Change Password'),
            personalDataRow(title: 'Change Language'),
            SizedBox(height: screenSize.height * 0.04),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Logout',
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
