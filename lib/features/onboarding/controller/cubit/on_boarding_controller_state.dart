part of 'on_boarding_controller_cubit.dart';

@immutable
sealed class OnBoardingState extends Equatable {
  @override
  List<Object?> get props;
}

final class OnBoardingInitial extends OnBoardingState {
  @override
  List<Object?> get props => [];
}

final class OnBoardingChangePage extends OnBoardingState {
  final int index;

  OnBoardingChangePage({required this.index});

  @override
  List<Object?> get props => [index];
}
