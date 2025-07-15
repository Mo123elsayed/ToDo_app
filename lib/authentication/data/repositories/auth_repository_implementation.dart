import 'package:dart_either/dart_either.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/authentication/domain/repositories/base_auth_repository.dart';

class AuthRepositoryImplementation extends BaseAuthRepository {
  @override
  Future<Either> signUpWithFirebase(String email, String password) async {
    try {
      var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Success");
      return Right(user);
    } catch (e) {
      print("Error");
      return Left(e);
    }
  }

  @override
  Future<Either> logInWithFirebase(String email, String password) async {
    // TODO: implement logInWithFirebase
    try {
      var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(
        AlertDialog(
          title: Text('Message'.tr()),
          content: Text(
            "You Login Successefuly!",
            style: TextStyle(
              fontFamily: "IBM",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } catch (e) {
      return Left(
        AlertDialog(
          title: Text("Warning!".tr()),
          content: Text(
            e.toString(),
            style: TextStyle(
              fontFamily: "IBM",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }
}
