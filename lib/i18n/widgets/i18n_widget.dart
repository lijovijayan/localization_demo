import 'package:flutter/cupertino.dart';
import '../providers/i18n_provider.dart';
import 'package:provider/provider.dart';

  /// Creates a text widget with traslation support.
  ///
  /// If the [style] argument is null, the text will use the style from the
  /// closest enclosing [DefaultTextStyle].
  ///
  /// The [data] parameter must not be null.
  ///
  /// The [overflow] property's behavior is affected by the [softWrap] argument.
  /// If the [softWrap] is true or null, the glyph causing overflow, and those that follow,
  /// will not be rendered. Otherwise, it will be shown with the given overflow option.
  /// 
class TextLocalization extends StatelessWidget {

  final String data;
  final Key key;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior textHeightBehavior;
  TextLocalization(this.data,
      {this.key,
      this.style,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior});
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder:
        (BuildContext context, LanguageProvider provider, Widget child) {
      return Text(provider.translate(this.data),
          key: this.key,
          style: this.style,
          strutStyle: this.strutStyle,
          textAlign: this.textAlign,
          textDirection: this.textDirection,
          locale: this.locale,
          softWrap: this.softWrap,
          overflow: this.overflow,
          textScaleFactor: this.textScaleFactor,
          maxLines: this.maxLines,
          semanticsLabel: this.semanticsLabel,
          textWidthBasis: this.textWidthBasis,
          textHeightBehavior: this.textHeightBehavior);
    });
  }
}

  /// Creates a Widget with transated value
  /// 
  /// `valueKey` cannot be `null`
  /// 
  /// implement `builder` function 
  /// `builder` function cannot be null and must return a `widget`
class LocalizationBuilder extends StatelessWidget {
  final Widget Function(
      BuildContext context, String translatedString) builder;
  final String valueKey;
  LocalizationBuilder(this.valueKey, {@required this.builder});
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (BuildContext context, LanguageProvider provider, Widget child) {
        return this
            .builder(context, provider.translate(this.valueKey));
      },
    );
  }
}
