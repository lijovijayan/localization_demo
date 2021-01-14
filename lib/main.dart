import 'package:flutter/material.dart';
import 'package:localization_demo/provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'localization.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Future<void> _onLanguageChange(
      LanguageProvider provider, String lang) async {
    var map = await http.get('https://6eeb06c5bac2.ngrok.io/');
    print(map.body.toString());
    provider.changeLanguage(lang);
    print(provider.translate('Localization Demo'));
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    languageProvider.fetchLatestI18N();
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Localization Demo App'),
          ),
          body: Consumer<LanguageProvider>(
            builder: (BuildContext _, LanguageProvider _provider, Widget __) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    TextLocalization('Hello World'),
                    SizedBox(
                      height: 30,
                    ),
                    LocalizationBuilder(
                      'Localization Demo',
                      builder: (BuildContext context, String value) {
                        return Text(value);
                      },
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: 'English',
                          groupValue: _provider.language,
                          onChanged: (lang) =>
                              {_onLanguageChange(_provider, lang)},
                        ),
                        new Text(
                          'English',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 'Malayalam',
                          groupValue: _provider.language,
                          onChanged: (lang) =>
                              {_onLanguageChange(_provider, lang)},
                        ),
                        new Text(
                          'Malayalam',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        new Radio(
                          value: 'Tamil',
                          groupValue: _provider.language,
                          onChanged: (lang) =>
                              {_onLanguageChange(_provider, lang)},
                        ),
                        new Text(
                          'Tamil',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 'Hindi',
                          groupValue: _provider.language,
                          onChanged: (lang) =>
                              {_onLanguageChange(_provider, lang)},
                        ),
                        new Text(
                          'Hindi',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
