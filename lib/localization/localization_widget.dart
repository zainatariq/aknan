import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';

import '../config/validator.dart';
import 'change_language.dart';
import 'codegen_loader.g.dart';

class LocalizationWidget extends StatelessWidget {
  final Widget child;
  const LocalizationWidget({super.key, required this.child});

  static Future<void> setUp() async {
    EasyLocalization.logger.enableLevels = [
      LevelMessages.error,
      LevelMessages.warning
    ];
    await EasyLocalization.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [Locale(Lang.en.name), Locale(Lang.ar.name)],
      path: 'assets/translations',
      startLocale: Locale(Lang.en.name),
      fallbackLocale: Locale(Lang.en.name),
      assetLoader: _loadCodegenLoader(),
      child: child,
    );
  }

  CodegenLoader _loadCodegenLoader() {
    CodegenLoader.ar.addAll(TValidator.arV);
    CodegenLoader.en.addAll(TValidator.enV);
    return CodegenLoader();
  }
}
