import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_either/dart_either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/authentication/domain/repositories/base_auth_repository.dart';

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
      return Left(e);
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

      if(snapshot.exists && snapshot.data() != null) {
        return Right(snapshot.data());
      } else {
        return Left('No User data found.');
      }
    } catch (e) {
      return Left('Error fetching profile info: $e');
    }
  }
}
