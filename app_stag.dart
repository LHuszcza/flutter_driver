import 'dart:ui';

import 'package:flutter_driver/driver_extension.dart';
import 'package:wenn_flutter_poc/main_stag.dart' as app;
import 'package:wenn_flutter_poc/ui/i18n.dart';

void main() {
  final DataHandler handler = (textId) async {
    final translator = I18n(Locale(window.locale.languageCode));
    await translator.load();
    return Future.value(translator.translate(textId));
  };
  enableFlutterDriverExtension(handler: handler);
  app.main();
}
