import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/authentication/data/repositories/auth_repository_implementation.dart';
import 'package:todo_app/authentication/domain/repositories/base_auth_repository.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  BaseAuthRepository base = AuthRepositoryImplementation();

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    var result = await base.forgetPassword(email);
    result.fold(
      ifLeft: (value) => emit(ForgetPasswordFailure(value)),
      ifRight: (value) => emit(ForgetPasswordSuccess(value)),
    );
  }
}
