import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/home/data/models/todo_model.dart';
import 'package:todo_app/home/data/repositories/home_repository_implementation.dart';
import 'package:todo_app/home/domain/repositories/base_home_repository.dart';

part 'get_todo_state.dart';

class GetTodoCubit extends Cubit<GetTodoState> {
  GetTodoCubit() : super(GetTodoInitial());
  BaseHomeRepository base = HomeRepositoryImplementation();

  /// The subscription to the stream of todo items, to cancel it when the cubit is closed.
  StreamSubscription? _subscription;

  /// Retrieves todo items and emits state changes.
  ///
  /// This function listens to a stream of todo items from the repository.
  /// It emits a [GetTodoLoading] state initially, then listens to the
  /// results from the repository's stream. On a successful retrieval of
  /// todos, it emits a [GetTodoSuccess] state with the list of todos. If
  /// an error occurs during the retrieval, it emits a [GetTodoFailure]
  /// state with the error message.
  void getTodo() {
    emit(GetTodoLoading());

    /// call the getTodo method from the repository
    /// listen to the stream to get the result of the getTodo method
    _subscription = base.getTodo().listen((event) {
      event.fold(
        ifLeft: (error) => emit(GetTodoFailure(error)),
        ifRight: (success) {
          if (success.isEmpty) {
            emit(GetTodoEmpty());
          } else {
            emit(GetTodoSuccess(success));
          }
        },
      );
    });
  }

  /// Cancels the subscription to the stream of todo items and then closes the
  /// cubit.
  ///
  /// This method is used to clean up resources when the cubit is no longer needed.
  /// It is called automatically when the cubit is closed, but it can also be
  /// called explicitly.
  ///
  /// Returns a Future that completes when the cubit has been closed.
  @override
  Future<void> close() async {
    _subscription?.cancel();
    return super.close();
  }
}
