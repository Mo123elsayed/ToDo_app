import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';

abstract class BaseHomeRepository {
  Future<Either> addTodo(String title, String description, DateTime date, Color color);
  Stream<Either> getTodo();
  Future<Either> updateTodo(String id, String title, String description, DateTime date);
  Future<Either> deleteTodo(String id);
}