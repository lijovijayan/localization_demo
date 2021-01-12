import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'localization.dart';

class LanguageProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Language _language = Language.english;

  get language => _language;

  void changeLanguage(Language lang) {
    _language = lang;
    notifyListeners();
  }

  /// Makes `Language` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('language', language));
  }
}
