import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/authentication/data/repositories/auth_repository_implementation.dart';
import 'package:todo_app/authentication/domain/repositories/base_auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final BaseAuthRepository base = AuthRepositoryImplementation();

  Future<void> logInWithFireBase(String email, String password) async {
    emit(LoginLoading());
    var user = await base.logInWithFirebase(email, password);
    user.fold(
      ifLeft: (value) => emit(LoginFailure(value)),
      ifRight: (value) => emit(LoginSuccess()),
    );
  }
}
