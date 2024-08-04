
import 'package:flutter/material.dart';

import '../../widgets/app_dilog.dart';

mixin LoaderMixin {
  void showLoader(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const LoadingDialog(),
    );
  }

  void dismissDialog(BuildContext context) => Navigator.of(context).pop();
}

mixin ErrorMixin {
  void showErrorDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return ErrorDialog(
            title: title,
            message: message,
            resetState: () => dismissDialog(context),
          );
        });
  }

  void dismissDialog(BuildContext context) => Navigator.of(context).pop();
}
