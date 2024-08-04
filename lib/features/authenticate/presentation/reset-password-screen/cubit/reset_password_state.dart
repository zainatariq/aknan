part of 'reset_password_cubit.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {}

//error
final class ResetPasswordError extends ResetPasswordState {
  final String message;
  const ResetPasswordError(this.message);
  @override
  List<Object> get props => [message];
}

//success
final class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess();
  @override
  List<Object> get props => [];
}
