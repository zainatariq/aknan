part of 'otp_log_in_screen_cubit.dart';

sealed class OtpLogInScreenState extends Equatable {
  const OtpLogInScreenState();

  @override
  List<Object> get props => [];
}

final class OtpLogInScreenInitial extends OtpLogInScreenState {}

final class OtpLogInScreenLoading extends OtpLogInScreenState {}

//error
final class OtpLogInScreenError extends OtpLogInScreenState {
  final String message;
  const OtpLogInScreenError(this.message);
  @override
  List<Object> get props => [message];
}

//success
final class OtpLogInScreenSuccess extends OtpLogInScreenState {
  const OtpLogInScreenSuccess();
  @override
  List<Object> get props => [];
}
