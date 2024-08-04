// chucker_flutter_page
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';

class ChuckerFlutterPage extends StatelessWidget {
  final Widget child;
  const ChuckerFlutterPage({super.key, required this.child});

  bool get showChukkerBtn => ChuckerFlutter.showOnRelease;

  PreferredSizeWidget? get chukkerBtn => showChukkerBtn
      ? AppBar(
          title: ChuckerFlutter.chuckerButton,
          centerTitle: true,
          leading: const SizedBox(),
          actions: const [],
        )
      : null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chukkerBtn,
      body: child,
    );
  }
}
