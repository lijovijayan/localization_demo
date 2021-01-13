import 'dart:convert';

import 'package:localization_demo/models/i18n.model.dart';

class I18NDTO {
  
  num version;

  List<I18N> content;

  I18NDTO.fromJson(Map<String, dynamic> _json): 
    version = _json['version'],
    content = (_json['content'] as List)
      .map((i) => I18N.fromJson(i))
      .toList()
    ;

  Map<String, dynamic> toJson() =>
  {
    'version': version,
  };

}