import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/authentication/data/repositories/auth_repository_implementation.dart';
import 'package:todo_app/authentication/domain/repositories/base_auth_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  BaseAuthRepository base = AuthRepositoryImplementation();
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  ) async {
    emit(ChangePasswordLoading());
    final res = await base.changePassword(
      currentPassword,
      newPassword,
      confirmNewPassword,
    );
    res.fold(
      ifLeft: (message) => emit(ChangePasswordFailure(message)),
      ifRight: (message) => emit(ChangePasswordSuccess(message)),
    );
  }
}
