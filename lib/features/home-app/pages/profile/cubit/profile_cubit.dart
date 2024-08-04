import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_cubit.freezed.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState.initial());

  int? _selectedIndex;
  int? get selectedIndex => _selectedIndex;

  int get totalElevatorCount => 3;
  void onElevatorTap(int index) {
    final bool isIndexAlreadySelected = _selectedIndex == index;
    if (!isIndexAlreadySelected) {
      _selectedIndex = index;
    } else {
      _selectedIndex = null;
    }
    emit(ProfileState.tapOnElevator(_selectedIndex));
  }
}
