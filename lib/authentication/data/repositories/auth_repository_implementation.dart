import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/authentication/domain/repositories/base_auth_repository.dart';
import 'package:todo_app/home/presentation/screens/change_password.dart';

class AuthRepositoryImplementation extends BaseAuthRepository {
  @override
  /// Signs up a user with the provided email, password, first name, and last name.
  ///
  /// If the user is signed up successfully, it returns a Right with a success
  /// message. If the email already exists, it returns a Left with an error message.
  /// If there is any other error, it returns a Left with the error message.
  Future<Either> signUpWithFirebase(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var instance = FirebaseFirestore.instance;
      var userId = user.user!.uid;
      await instance.collection('users').doc(userId).set({
        'userId': userId,
        'email': email,
        'fullName': '$firstName $lastName',
        'createdAt': Timestamp.now(),
      });

      return Right('Email created successfully!');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return Left('The account already exists for that email.');
      }
      // Fallback return in case no exception is caught
      return Left('Unknown error');
    }
  }

  @override
  /// Signs in to Firebase with the given email and password.
  ///
  /// This function returns a Right with a success message if the sign in was
  /// successful, or a Left with an error message if the sign in failed.
  ///
  /// If the sign in failed because the email or password was invalid, the Left
  /// value will contain the error message "invalid email or password!".
  ///
  /// Otherwise, the Left value will contain the string "Unknown error".
  Future<Either> logInWithFirebase(String email, String password) async {
    // TODO: implement logInWithFirebase
    try {
      var instance = FirebaseAuth.instance;
      var user = await instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // var currentUser = instance.currentUser;

      return Right('You are logged in');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return Left('invalid email or password!');
      }
      // Fallback return in case no exception is caught
      return Left('Unknown error');
    }
  }

  @override
  Future<Either> profileInfo() async {
    try {
      var instance = FirebaseFirestore.instance;
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var snapshot = await instance.collection('users').doc(userId).get();

      if (snapshot.exists && snapshot.data() != null) {
        return Right(snapshot.data());
      } else {
        return Left('No User data found.');
      }
    } catch (e) {
      return Left('Error fetching profile info: $e');
    }
  }

  @override
/*************  ✨ Windsurf Command ⭐  *************/
  /// Changes the user's password.
  ///
  /// The function takes three parameters, [currentPassword], [newPassword], and [confirmNewPassword].
  ///
  /// If [newPassword] and [confirmNewPassword] do not match, it returns a Left with the value "passwords_do_not_match".
  ///
  /// The function reauthenticates the user with the current password and then updates the password in Firebase.
  ///
  /// If the user is not found, it returns a Left with the value "User not Found".
  ///
  /// If the current password is wrong, it returns a Left with the value "current_password_is_wrong".
  ///
  /// If the new password is too weak, it returns a Left with the value "new_password_is_too_weak".
  ///
  /// Otherwise, the Right value will contain the string "password_changed_successfully!".
  ///
/*******  1fdbf80b-17a6-44d7-9942-7bc828c72fa5  *******/
  Future<Either> changePassword({
    String? currentPassword,
    String? newPassword,
    String? confirmNewPassword,
  }) async {
    try {
      final instance = FirebaseAuth.instance;
      final user = instance.currentUser;
      
      if (newPassword != confirmNewPassword) {
        return Left("passwords_do_not_match".tr());
      }
      // reauthenticate with current password
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword!,
      );
      if (user == null || user.email == null) {
        return Left("user_not_found".tr());
      }
      /// reauthenticate and update password in firebase 
      await user.reauthenticateWithCredential(credential);
      /// update password in firebase
      await user.updatePassword(newPassword!);
      return Right("password_changed_successfully!".tr());
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return Left("User not Found");
      } else if (e.code == "wrong-password") {
        return Left("current_password_is_wrong".tr());
      } else if (e.code == "weak-password") {
        return Left("new_password_is_too_weak".tr());
      }
      // Fallback return in case no exception is caught
      return Left('unknown_error'.tr());
    }
  }
}
