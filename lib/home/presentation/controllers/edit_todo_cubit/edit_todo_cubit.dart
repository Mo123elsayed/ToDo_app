import 'package:bloc/bloc.dart';
import 'package:todo_app/home/data/repositories/home_repository_implementation.dart';
import 'package:todo_app/home/domain/repositories/base_home_repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  EditTodoCubit() : super(EditTodoInitial());
  BaseHomeRepository base = HomeRepositoryImplementation();

  /// Edit a todo item
  ///
  /// Takes in the id of the todo item to be edited, and the new
  /// title, description, and date for the todo item. Emits
  /// [EditTodoSuccess] on success, or [EditTodoFailure] on
  /// failure.
  Future<void> editTodo(
    String id,
    String title,
    String description,
    DateTime date,
  ) async {
    final res = await base.updateTodo(id, title, description, date);
    print("EditTodoCubit ========================================>: $res");
    res.fold(
      ifLeft: (error) {
        emit(EditTodoFailure(error));
      },
      ifRight: (success) {
        emit(EditTodoSuccess());
      },
    );
  }
}
