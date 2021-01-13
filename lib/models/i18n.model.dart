import 'package:flutter/cupertino.dart';

class I18N {
  String language;

  num version;

  Map<String, dynamic> translate;

  I18N({
    @required this.language,
    @required this.translate,
    // @required this.version
  });

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'version': version,
      'translate': translate,
    };
  }

  static I18N fromMap(Map<String, dynamic> map) {
    return I18N(
      language: map['language'],
      // version: map['version'],
      translate: map['translate'],
    );
  }

  I18N.fromJson(Map<String, dynamic> json): 
    language = json['language'],
    translate = json['translate']
    ;

}
