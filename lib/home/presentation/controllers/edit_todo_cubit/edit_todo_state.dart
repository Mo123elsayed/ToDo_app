part of 'edit_todo_cubit.dart';

sealed class EditTodoState {}

final class EditTodoInitial extends EditTodoState {}
final class EditTodoLoading extends EditTodoState {}
final class EditTodoSuccess extends EditTodoState {}
final class EditTodoFailure extends EditTodoState {
  final String errorMessage;

  EditTodoFailure(this.errorMessage);
}
