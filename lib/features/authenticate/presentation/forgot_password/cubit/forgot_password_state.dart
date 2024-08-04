part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

//error
final class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  const ForgotPasswordError(this.message);
  @override
  List<Object> get props => [message];
}

//success
final class ForgotPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordSuccess();
  @override
  List<Object> get props => [];
}
