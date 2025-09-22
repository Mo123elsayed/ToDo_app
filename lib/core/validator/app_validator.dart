import 'package:easy_localization/easy_localization.dart';

class AppValidator {
  /// Validate an email address.
  ///
  /// This function takes an optional email address string and returns an error
  /// message if the email address is invalid or empty. If the email address is
  /// valid, it returns null.
  ///
  /// The error messages are localized using the Easy Localization library.
  ///
  /// @param email The email address to validate
  /// @return An error message if the email address is invalid or empty, or null if
  /// the email address is valid.
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'email_required'.tr();
    }

    // Trim the email to remove leading/trailing spaces
    final trimmedEmail = email.trim();

    // Basic email regex pattern
    final emailRegex = RegExp(r'^[\w-\.]+(\+[\w-]+)?@([\w-]+\.)+[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(trimmedEmail)) {
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

  /// Validate a password.
  ///
  /// This function takes an optional password string and returns an error message
  /// if the password is invalid or empty. If the password is valid, it returns null.
  ///
  /// The password must be at least 6 characters long and start with a letter.
  ///
  /// The error messages are localized using the Easy Localization library.
  ///
  /// @param password The password to validate
  /// @return An error message if the password is invalid or empty, or null if the
  /// password is valid.
  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'password_required'.tr();
    }
    if (password.length < 6) {
      return 'password_too_short'.tr();
    }

    // يبدأ بحرف صغير + أي حاجة بعد كده + طول لا يقل عن 6
    final passwordRegex = RegExp(r'^[a-z].{5,}$');

    if (!passwordRegex.hasMatch(password)) {
      return 'password_pattern_invalid'.tr();
    }
    return null;
  }

  /// Validate confirm password, checks if password and confirm password are same.
  ///
  /// If passwords are not same, it returns a Left with the value "passwords_not_match".
  ///
  /// Otherwise, it returns a Right with null value.
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
