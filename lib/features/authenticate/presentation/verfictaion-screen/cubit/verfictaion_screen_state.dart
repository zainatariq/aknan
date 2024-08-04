part of 'verfictaion_screen_cubit.dart';

sealed class VerificationScreenState extends Equatable {
  const VerificationScreenState();

  @override
  List<Object> get props => [];
}

final class VerificationScreenInitial extends VerificationScreenState {}

final class VerificationScreenTimerViewState extends VerificationScreenState {
    final bool viewState;

  const VerificationScreenTimerViewState({required this.viewState});
    @override
  List<Object> get props => [viewState];
}
final class VerificationScreenSendBtnViewState extends VerificationScreenState {
    final bool viewState;

  const VerificationScreenSendBtnViewState({required this.viewState});
    @override
  List<Object> get props => [viewState];
}
final class VerificationScreenLoadState extends VerificationScreenState {
  final bool loadState;

  const VerificationScreenLoadState({required this.loadState});

  @override
  List<Object> get props => [loadState];
}
final class VerificationScreenResendBtnState extends VerificationScreenState {
  final bool reSendBtnState;

  const VerificationScreenResendBtnState({required this.reSendBtnState});

  @override
  List<Object> get props => [reSendBtnState];
}


final class VerificationScreenTimerState extends VerificationScreenState {
  final String min;
  final String second;

  const VerificationScreenTimerState({
    required this.min,
    required this.second,
  });

  @override
  List<Object> get props => [min, second];
}

//error
final class VerificationScreenError extends VerificationScreenState {
  final String message;
  const VerificationScreenError(this.message);
  @override
  List<Object> get props => [message];
}




//success
final class VerificationScreenSuccess extends VerificationScreenState {
  const VerificationScreenSuccess();
  @override
  List<Object> get props => [];
}

final class VerificationScreenResendCodeSuccess extends VerificationScreenState {
  const VerificationScreenResendCodeSuccess();
  @override
  List<Object> get props => [];
}


final class VerificationScreenResendCodeFail
    extends VerificationScreenState {
  const VerificationScreenResendCodeFail();
  @override
  List<Object> get props => [];
}

