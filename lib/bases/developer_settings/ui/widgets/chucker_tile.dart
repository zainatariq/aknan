import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChuckerTile extends StatefulWidget {
  const ChuckerTile({Key? key}) : super(key: key);

  @override
  State<ChuckerTile> createState() => _ChuckerTileState();
}

class _ChuckerTileState extends State<ChuckerTile> {
  bool _chuckerEnabled = false;

  void _onChuckerChanged(bool value) {
    setState(() {
    _chuckerEnabled = value;
  });
    if(_chuckerEnabled){
      ChuckerFlutter.showOnRelease = _chuckerEnabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      value: _chuckerEnabled,
      onChanged: _onChuckerChanged,
      title: Text('enable_chucker'.tr(context:context)),
    );
  }
}
