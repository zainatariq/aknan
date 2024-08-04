part of 'main_bg_cubit.dart';

sealed class MainBgState extends Equatable {
  const MainBgState();

  @override
  List<Object> get props => [];
}

final class MainBgInitialState extends MainBgState {}

final class MainBgChangeNavIndex extends MainBgState {
  final int index;

  const MainBgChangeNavIndex({required this.index});
  @override
  List<Object> get props => [index];
}
