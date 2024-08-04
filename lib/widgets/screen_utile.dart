


import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilInitWidget extends StatelessWidget {
  final Widget child;
  const ScreenUtilInitWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 914),
      ensureScreenSize: true,
      minTextAdapt: true,
      builder: (context, _) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: child,
      ),
    );
  }
}
