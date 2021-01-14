import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../dao/i18n.dao.dart';
import 'package:http/http.dart' as http;
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
    return langMap != null && langMap.keys.length > 0 ? langMap.keys.toList() : ['English'];
  }

  String translate(String key) {
    I18N i18n = langMap[_language] as I18N;
    if (i18n != null && i18n.translate[key] != null) {
      return i18n.translate[key];
    } else {
      return key;
    }
  }

  void fetchLatestI18N() async {
    dynamic responseBody = {
      "version": 1,
      "content": [
        {
          "language": "English",
          "translate": {
            "Hello World !": "Hello World !",
            "Localization Demo": "Localization Demo",
          }
        },
        {
          "language": "Malayalam",
          "translate": {
            "Hello World !": "ഹലോ വേൾഡ് !",
            "Localization Demo": "പ്രാദേശികവൽക്കരണ ഡെമോ",
          }
        },
        {
          "language": "Tamil",
          "translate": {
            "Hello World !": "ஹலோ வேர்ல்ட் !",
            "Localization Demo": "உள்ளூராக்கல் டெமோ",
          }
        },
        {
          "language": "Hindi",
          "translate": {
            "Hello World !": "नमस्ते दुनिया !",
            "Localization Demo": "स्थानीयकरण डेमो",
          }
        }
      ]
    };
    int version = await LocalStorageService.getI18NVersion();
    // * Actual
    // final response = await http.get('https://6eeb06c5bac2.ngrok.io/$version');
    // I18NDTO i18NDTO = I18NDTO.fromJson(jsonDecode(response.body));

    I18NDTO i18NDTO = I18NDTO.fromJson(responseBody);
    if( i18NDTO.version == version) {
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
