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

  Future<void> _onLanguageChange(LanguageProvider provider, String lang) async {
    provider.changeLanguage(lang);
  }

  @override
  Widget build(BuildContext context) {
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
                      height: 30,
                    ),
                    TextLocalization('Hello World !'),
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
                      height: 20,
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
