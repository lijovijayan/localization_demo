import 'package:flutter/material.dart';
import 'package:localization_demo/provider.dart';
import 'package:provider/provider.dart';
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
  Language _language = Language.english;
  Function _onLanguageChange(LanguageProvider provider, dynamic lang) {
    _language = lang;
    provider.changeLanguage('Malayalam');
    print(provider.translate('hello'));
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
                    Text('Hello World'),
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Radio(
                          value: Language.english,
                          groupValue: _provider.language,
                          onChanged: (lang) =>
                              {_onLanguageChange(_provider, lang)},
                        ),
                        new Text(
                          'English',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: Language.malayalam,
                          groupValue: _language,
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
                          value: Language.tamil,
                          groupValue: _language,
                          onChanged: (lang) =>
                              {_onLanguageChange(_provider, lang)},
                        ),
                        new Text(
                          'Tamil',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: Language.hindi,
                          groupValue: _language,
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
            // child: Center(
            //   child: Column(
            //     children: [
            //       Text('Hello World'),
            //       SizedBox(
            //         height: 100,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           new Radio(
            //             value: Language.english,
            //             groupValue: _language,
            //             onChanged: (lang) => {_onLanguageChange(_provider, lang)},
            //           ),
            //           new Text(
            //             'English',
            //             style: new TextStyle(fontSize: 16.0),
            //           ),
            //           new Radio(
            //             value: Language.malayalam,
            //             groupValue: _language,
            //             onChanged: (lang) => {_onLanguageChange(_provider, lang)},
            //           ),
            //           new Text(
            //             'Malayalam',
            //             style: new TextStyle(
            //               fontSize: 16.0,
            //             ),
            //           ),
            //           new Radio(
            //             value: Language.tamil,
            //             groupValue: _language,
            //             onChanged: (lang) => {_onLanguageChange(_provider, lang)},
            //           ),
            //           new Text(
            //             'Tamil',
            //             style: new TextStyle(fontSize: 16.0),
            //           ),
            //           new Radio(
            //             value: Language.hindi,
            //             groupValue: _language,
            //             onChanged: (lang) => {_onLanguageChange(_provider, lang)},
            //           ),
            //           new Text(
            //             'Hindi',
            //             style: new TextStyle(fontSize: 16.0),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
