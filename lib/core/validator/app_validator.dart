import 'package:easy_localization/easy_localization.dart';

class AppValidator {
  /// method to validate email,with regex
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'email_required'.tr();
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'invalid_email'.tr();
    }
    return null;
  }

  /// method to validate name,with regex
  static String? validateName(String? name) {
    if (name!.isEmpty) {
      return 'username_required'.tr();
    }
    final nameRegex = RegExp(r'^[a-zA-Z ]+$');
    if (!nameRegex.hasMatch(name)) {
      return 'Invalid name format,please enter a valid name';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'password_required'.tr();
    }
    if (password.length < 6) {
      return 'password_too_short'.tr();
    }
    final passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$&*~]).{6,}$',
    );

    if (!passwordRegex.hasMatch(password)) {
      return 'password_pattern_invalid'.tr();
    }
    return null;
  }

  static String? validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (password != confirmPassword) {
      return 'passwords_not_match'.tr();
    }
    return null;
  }

  /// method to validate date,with regex
  static String? validateDate(String? date) {
    if (date == null || date.isEmpty) {
      return 'date_required'.tr();
    }
    final dateRegex = RegExp(
      r'^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$',
    );
    if (!dateRegex.hasMatch(date)) {
      return 'invalid_date_format'.tr();
    }
    return null;
  }
}
