import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home/data/models/todo_model.dart';
import 'package:todo_app/home/data/repositories/home_repository_implementation.dart';
import 'package:todo_app/home/domain/repositories/base_home_repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit() : super(AddTodoInitial());

  BaseHomeRepository base = HomeRepositoryImplementation();

  /// Adds a new todo item to the todo-list collection in Firestore.
  ///
  /// Takes in the title, description, and date of the todo item, and adds a
  /// createdAt timestamp field to the document. Emits a success state with
  /// the newly created todo item if the operation is successful, or a failure
  /// state with the error message if the operation fails.
  Future<void> addToDo(String title, String description, DateTime date, Color color) async {
    var todo = await base.addTodo(title, description, date, color);

    todo.fold(
      ifLeft: (error) => emit(AddTodoFailure(error)),
      ifRight: (success) {
        final data = TodoModel.fromSnapshot(success);
        emit(AddTodoSuccess(data));
      },
    );
  }
}
