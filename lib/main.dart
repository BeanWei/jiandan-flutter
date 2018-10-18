import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jiandan/pages/main_page.dart';
import 'package:jiandan/common/config.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  JianDanTheme _configuration = JianDanTheme(themeType: ThemeType.light);

  StreamSubscription<ConnectivityResult> _streamSubscription;

  void configurationUpdater(JianDanTheme value) {
    setState(() {
      _configuration = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "煎蛋",
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(_configuration, configurationUpdater),
        //'/search': (context) =>

      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadConfig();
    _streamSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        networkEnable = false;
      } else {
        networkEnable = true;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Future<Null> _loadConfig() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeType themeType =
        ThemeType.values.elementAt(prefs.getInt('them') ?? 0);
    configurationUpdater(_configuration.copyWith(themeType: themeType));
  }

  ThemeData get theme {
    switch (_configuration.themeType) {
      case ThemeType.brown:
        return ThemeData(
          primarySwatch: Colors.brown,
          brightness: Brightness.light,
          indicatorColor:Colors.white,
        );
      case ThemeType.light:
        return ThemeData(
          primaryColor: Colors.white,
          brightness: Brightness.light,
        );
      case ThemeType.dark:
        return ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.red,
        );
      case ThemeType.blue:
        return ThemeData(
          indicatorColor:Colors.white,
          primarySwatch: Colors.blue,
        );
    }
    assert(_configuration.themeType != null);

    return null;
  }

}