import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/home/data/repositories/home_repository_implementation.dart';
import 'package:todo_app/home/domain/repositories/base_home_repository.dart';

part 'get_todo_state.dart';

class GetTodoCubit extends Cubit<GetTodoState> {
  GetTodoCubit() : super(GetTodoInitial());
  BaseHomeRepository base = HomeRepositoryImplementation();
  Stream<void> getTodo() async* {
    emit(GetTodoLoading());
    var res = await base.getTodo();
    res.listen((event) {
      event.fold(
        ifLeft: (error) => emit(GetTodoFailure(error)),
        ifRight: (success) => emit(GetTodoSuccess(success)),
      );
    });
  }
}
