import '../../widgets/app_dilog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_context/one_context.dart';

import '../base_state/base_cubit_state.dart';

abstract class ICubit<G> extends Cubit<ICubitState<G>> {
  ICubit() : super(const ICubitState.initial());
  @override
  void emit(ICubitState<G> state) {
    if (isClosed) return;
    super.emit(state);
  }

  void _dismissDialog(Change<ICubitState<G>> change) {
    if (change.currentState == ICubitState<G>.loading()) {
      // OneContext().pop();
      // Later
      OneContext().hideProgressIndicator();
    }
  }

  void _resetState() {
    emit(const ICubitState.initial());
    // OneContext().pop();
    OneContext().popDialog();
    // Later
    // OneContext().hideProgressIndicator();
  }

  @override
  void onChange(Change<ICubitState<G>> change) {
    super.onChange(change);
    change.nextState.whenOrNull(
      loading: () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
 
          // Show a custom progress indicator
          OneContext().showProgressIndicator(
            builder: (context) => const LoadingDialog(),
            backgroundColor: Colors.black12
          );
        });
      },
      error: (err, msgList) {
        final context = OneContext().context;
        _dismissDialog(change);
        if (context != null) {
          OneContext().showDialog(
            builder: (context) => ErrorDialog(
              title: 'failed'.tr(context: context),
              message: msgList?.join(',') ?? '',
              resetState: _resetState,
            ),
          );
        }
      },
      initial: () {
        _dismissDialog(change);
      },
      success: (_) {
        _dismissDialog(change);
      },
    );
  }
}
