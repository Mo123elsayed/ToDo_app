part of 'delete_todo_cubit.dart';

@immutable
sealed class DeleteTodoState {}

final class DeleteTodoInitial extends DeleteTodoState {}

final class DeleteTodoLoading extends DeleteTodoState {}

final class DeleteTodoFailure extends DeleteTodoState {
  final String errorMessage;
  DeleteTodoFailure(this.errorMessage);
}

final class DeleteTodoSuccess extends DeleteTodoState {}
