import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localization_demo/dao/i18n.dao.dart';
import 'package:localization_demo/models/i18n.dto.dart';
import 'package:localization_demo/models/i18n.model.dart';
import 'package:http/http.dart' as http;

class LanguageProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _language = 'English';

  I18NDao _i18NDao = I18NDao();

  Map<String, dynamic> langMap = Map<String, dynamic>(); 

  get language => _language;

  void changeLanguage(String lang) async {
    _language = lang;
    notifyListeners();
  }

  String translate(key) {
    I18N i18n = langMap[_language] as I18N;
    return i18n.translate[key];
  }

  void fetchLatestI18N() async {
    dynamic responseBody = {
      "version": 1,
      "content": [
        {
          "language": "English",
          "translate": {"hello": "hallo"}
        },
        {
          "language": "Malayalam",
          "translate": {"hello": "hallo malayalam"}
        }
      ]
    };

    /*
    * Actual
    * final response = await http.get('https://6eeb06c5bac2.ngrok.io/');
    * I18NDTO i18NDTO = I18NDTO.fromJson(jsonDecode(response.body));
    */

    I18NDTO i18NDTO = I18NDTO.fromJson(responseBody);
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
  }

  /// Makes `Language` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('language', language));
  }
}
