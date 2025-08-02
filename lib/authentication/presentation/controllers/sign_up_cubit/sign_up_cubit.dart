import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/authentication/data/repositories/auth_repository_implementation.dart';
import 'package:todo_app/authentication/domain/repositories/base_auth_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final BaseAuthRepository base = AuthRepositoryImplementation();

  Future<void> signUpWithFirebase(String email, String password) async {
    emit(SignUpLoading());
    
    var user = await base.signUpWithFirebase(email, password);
    user.fold(
      ifLeft: (error) {
        emit(SignUpError(message: error.toString()));
      },
      ifRight: (success)=> emit(SignUpSuccess()),
    );
  }
}
