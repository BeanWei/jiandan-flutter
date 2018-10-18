import 'package:flutter/foundation.dart';


bool networkEnable = true;



enum ThemeType { light, dark, brown, blue }

class JianDanTheme {
  ThemeType themeType;

  JianDanTheme(
    {@required this.themeType}) : assert(themeType != null);

  JianDanTheme copyWith({
    ThemeType themeType
  }) {
    return JianDanTheme(
      themeType: themeType ?? this.themeType
    );
  }
}
