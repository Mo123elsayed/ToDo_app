import 'package:dart_either/dart_either.dart';

abstract class BaseAuthRepository {
  Future<Either> signUpWithFirebase(
    String email,
    String password,
    String firstName,
    String lastName,
  );
  Future<Either> logInWithFirebase(String email, String password);
  Future<Either> profileInfo();
}
