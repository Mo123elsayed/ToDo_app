part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordFailure extends ChangePasswordState {
  final String message;
  ChangePasswordFailure(this.message);
}

final class ChangePasswordSuccess extends ChangePasswordState {
  final String message;
  ChangePasswordSuccess(this.message);
}
