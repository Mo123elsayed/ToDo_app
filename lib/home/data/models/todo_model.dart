import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final DateTime createdAt;
  final Color color;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.createdAt,
    required this.color,
  });

  /// Converts the [TodoModel] to a map representation that can be stored in
  /// Firestore. The map contains the following fields:
  ///
  /// - `id`: The ID of the todo item, which is used as the document ID in Firestore.
  /// - `title`: The title of the todo item.
  /// - `description`: The description of the todo item.
  /// - `date`: The date of the todo item, represented as a Firestore
  ///   [Timestamp] object.
  /// - `createdAt`: The date the todo item was created, represented as a Firestore
  ///   [Timestamp] object.
  /// - `color`: The color of the todo item, stored as an integer value.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'createdAt': Timestamp.fromDate(createdAt),
      'color': color.toARGB32(), // Store color as an integer value
    };
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot map) {
    return TodoModel(
      id: map.id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      color: Color(map['color']),
    );
  }
}
