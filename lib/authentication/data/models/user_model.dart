import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String fullName;
  final String email;
  final DateTime createdAt;

  UserModel({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.createdAt,
  });

  /// Converts the [UserModel] to a map representation that can be stored in
  /// Firestore. The map contains the following fields:
  ///
  /// - `userId`: The ID of the user, which is used as the document ID in Firestore.
  /// - `fullName`: The full name of the user.
  /// - `email`: The email address of the user.
  /// - `createdAt`: The date the user was created, represented as a Firestore
  ///   [Timestamp] object.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Converts a Firestore document snapshot to a [UserModel].
  ///
  /// The [doc] parameter is a [DocumentSnapshot] containing the user data.
  /// The function extracts the relevant fields from the snapshot and returns
  /// a [UserModel] instance.
  ///
  /// If a field is missing in the snapshot, it defaults to an empty string
  /// for `userId`, `fullName`, and `email`, and the current date and time for
  /// `createdAt`.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      userId: data['userId'] ?? '',
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
