import 'package:flutter/material.dart';
import './i18n/providers/i18n_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'i18n/widgets/i18n_widget.dart';

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

  renderLanguages(LanguageProvider provider) {
    return provider.supportedLanguages().map((String language) => Row(
          children: [
            new Radio(
              value: language,
              groupValue: provider.language,
              onChanged: (lang) => {_onLanguageChange(provider, lang)},
            ),
            new Text(
              language,
              style: new TextStyle(fontSize: 16.0),
            )
          ],
        )).toList();
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
                      children: renderLanguages(_provider)
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
