import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/home/data/repositories/home_repository_implementation.dart';
import 'package:todo_app/home/domain/repositories/base_home_repository.dart';

part 'delete_todo_state.dart';

class DeleteTodoCubit extends Cubit<DeleteTodoState> {
  DeleteTodoCubit() : super(DeleteTodoInitial());

  BaseHomeRepository base = HomeRepositoryImplementation();

  Future<void> deleteTodo(String todoId) async {
    emit(DeleteTodoLoading());
    var res = await base.deleteTodo(todoId);
    res.fold(
      ifLeft: (error) => emit(DeleteTodoFailure(error)),
      ifRight: (success) => emit(DeleteTodoSuccess()),
    );
  }
}
