import 'package:http/http.dart' as http;
import '../models/i18n.dto.dart';

String i18nURL = 'https://6eeb06c5bac2.ngrok.io/{0}';

class I18NService {
  static getI18N(int version) async {
    I18NDTO i18NDTO;
    try {
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
      i18NDTO = I18NDTO.fromJson(responseBody);
      // i18nURL = i18nURL.replaceAll('{0}', version.toString());
      // final response = await http.get(i18nURL);
      // i18NDTO = I18NDTO.fromJson(jsonDecode(response.body));
    } catch (e) {}
    return i18NDTO;
  }
}
