part of 'add_todo_cubit.dart';

@immutable
sealed class AddTodoState {}

final class AddTodoInitial extends AddTodoState {}
final class AddTodoLoading extends AddTodoState {}
final class AddTodoSuccess extends AddTodoState {
  final TodoModel todo;

  AddTodoSuccess(this.todo);
}
final class AddTodoFailure extends AddTodoState {
  final String errorMessage;

  AddTodoFailure(this.errorMessage);
}
