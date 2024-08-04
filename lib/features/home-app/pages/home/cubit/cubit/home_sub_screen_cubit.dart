import '../../../../../../bases/base_mixns/state_mapper.dart';
import '../../../../../../bases/base_state/base_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../bases/base_view_cubit/base_cubit.dart';
import '../../models/banners.dart';
import '../../repo/home_repo.dart';

part 'home_sub_screen_cubit.freezed.dart';
part 'home_sub_screen_state.dart';

class HomeSubScreenCubit extends Cubit<HomeSubScreenState> {
  HomeSubScreenCubit() : super(const HomeSubScreenState.initial()) {
    setCurrantBanarIndex(0);
  }

  @override
  void onChange(Change<HomeSubScreenState> change) {
    super.onChange(change);
  }

  int _currantBanarIndex = 0;
  int get currantBanarIndex => _currantBanarIndex;

  setCurrantBanarIndex(int index) {
    _currantBanarIndex = index;
    emit(HomeSubScreenState.changeBanarIndex(index));
  }

  int get totalBanarCount => 3;
  int get totalNotificationCount => 10;

  static get(context) => BlocProvider.of<HomeSubScreenCubit>(context);
}

class HomeNetSubScreenCubit extends ICubit<HomeRes> with UiState<HomeRes> {
  final HomeRepo _repo;
  HomeNetSubScreenCubit(
    this._repo,
  ){
    getHome();
  }

  HomeRes? homeRes;

  getHome() async {
    emit(const ICubitState.loading());
    final response = await _repo.getHomeData();
    final state = mapNetworkState(response);
    emit(state);
    state.whenOrNull(
      success: (uiModel) => homeRes = uiModel,

    );

  }
}
