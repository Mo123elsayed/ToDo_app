import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/home/data/models/todo_model.dart';
import 'package:todo_app/home/data/repositories/home_repository_implementation.dart';
import 'package:todo_app/home/domain/repositories/base_home_repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit() : super(AddTodoInitial());

  BaseHomeRepository base = HomeRepositoryImplementation();
  Future<void> addToDo(String title, String description, DateTime date) async {
    var todo = await base.addTodo(title, description, date);

    todo.fold(
      ifLeft: (error) => emit(AddTodoFailure(error)),
      ifRight: (success) {
        final data = TodoModel.fromSnapshot(success);
        emit(AddTodoSuccess(data));
      },
    );
  }
}
