part of 'login_with_pass_cubit.dart';

sealed class LoginWithPassState extends Equatable {
  const LoginWithPassState();

  @override
  List<Object> get props => [];
}

final class LoginWithPassInitial extends LoginWithPassState {}

final class LoginWithPassLoading extends LoginWithPassState {}

//error
final class LoginWithPassError extends LoginWithPassState {
  final String message;
  const LoginWithPassError(this.message);
  @override
  List<Object> get props => [message];
}

//success
final class LoginWithPassSuccess extends LoginWithPassState {
  const LoginWithPassSuccess();
  @override
  List<Object> get props => [];
}
