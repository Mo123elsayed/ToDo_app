import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime createdAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot map) {
    return TodoModel(
      id: map.id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
