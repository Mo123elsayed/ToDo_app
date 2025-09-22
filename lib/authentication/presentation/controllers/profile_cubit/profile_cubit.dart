import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/authentication/data/models/user_model.dart';
import 'package:todo_app/authentication/data/repositories/auth_repository_implementation.dart';
import 'package:todo_app/authentication/domain/repositories/base_auth_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  BaseAuthRepository base = AuthRepositoryImplementation();

  Future<void> getProfileInfo() async {
    emit(ProfileLoading());
    var res = await base.profileInfo();
    res.fold(
      ifLeft: (value) => emit(ProfileFailure(value)),
      ifRight: (value) {
        emit(ProfileSuccess(value));
      },
    );
  }
}
