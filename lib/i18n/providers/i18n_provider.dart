import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/i18n_service.dart';
import '../dao/i18n.dao.dart';
import '../models/i18n.dto.dart';
import '../models/i18n.model.dart';
import '../services/local_storage.dart';

class LanguageProvider with ChangeNotifier, DiagnosticableTreeMixin {
  LanguageProvider() {
    this.fetchLatestI18N();
  }

  String _language = 'English';

  I18NDao _i18NDao = I18NDao();

  Map<String, dynamic> langMap = Map<String, dynamic>();

  get language => _language;

  void changeLanguage(String lang) async {
    _language = lang;
    notifyListeners();
  }

  List<String> supportedLanguages() {
    return langMap != null && langMap.keys.length > 0
        ? langMap.keys.toList()
        : ['English'];
  }

  String translate(String key) {
    if(langMap == null) {
      return key;
    }
    I18N i18n = langMap[_language] as I18N;
    if (i18n != null && i18n.translate[key] != null) {
      return i18n.translate[key];
    } else {
      return key;
    }
  }

  void fetchLatestI18N() async {
    int version = await LocalStorageService.getI18NVersion();
    I18NDTO i18NDTO = await I18NService.getI18N(version);
    if (i18NDTO != null && i18NDTO.version == version) {
      return;
    }
    for (I18N i18N in i18NDTO.content) {
      I18N ei18N = await _i18NDao.findOne(i18N.language);
      if (ei18N == null) {
        langMap.putIfAbsent(i18N.language, () => i18N);
        await _i18NDao.insert(i18N);
      } else {
        langMap.remove(i18N.language);
        langMap.putIfAbsent(i18N.language, () => i18N);
        await _i18NDao.update(i18N);
      }
    }
    notifyListeners();
  }

  /// Makes `Language` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('language', language));
  }
}
