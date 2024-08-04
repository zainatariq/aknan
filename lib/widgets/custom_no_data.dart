import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:one_context/one_context.dart';

import '../localization/change_language.dart';

Widget customNoDataWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Lottie.asset(
        "assets/lottie/no_data.json",
        width: 200.w,
      ),
      Text(
        "no_data_found".tre,
        style: TextStyle(
          color: Theme.of(OneContext.instance.context!).primaryColor,
        ),
      )
    ],
  ));
}
