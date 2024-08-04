import 'navigation.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

import '../features/authenticate/data/models/base_model.dart';
import 'data_state.dart';

void checkStatus<T extends BaseResModel>(
  DataState<T> state, {
  Function(T? res)? onSuccess,
  Function(T? error)? onError,
  bool showErrorToast = true,
  bool showSuccessToast = false,
}) {
  if (state is DataSuccess<T>) {
    if (state.data != null && state.data!.status == 200) {
      _handelSuccess<T>(showSuccessToast, state, onSuccess);
    } else {
      _handelError<T>(showErrorToast, state, onError);
    }
  } else {
    _handelError<T>(showErrorToast, state, onError);
  }
}

void _handelSuccess<T extends BaseResModel>(
  bool showSuccessToast,
  DataSuccess<dynamic> state,
  Function(T? res)? onSuccess,
) {
  // final context = OneContext().context!;
  //
  if (showSuccessToast) {
    String msg = state.errorMsg ?? state.data?.message ?? "";

    OneContext().context!.showSuccess(msg);
  }
  onSuccess?.call(state.data);
}

void _handelError<T extends BaseResModel>(
  bool showErrorToast,
  DataState<T> state,
  Function(T? error)? onError,
) {
  // final context = OneContext().context!;
  //
  if (showErrorToast) {
    String msg = state.errorMsg ?? state.data?.message ?? "";

    OneContext().context!.showError(msg);
  }
  onError?.call(state.data);
}
