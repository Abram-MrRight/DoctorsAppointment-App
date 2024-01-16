import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';

enum ThemeEnum {
  dark,
  light
}

class ThemeProvider extends ChangeNotifier {
  // set initial theme
  ThemeEnum currentTheme = ThemeEnum.light;

  // variable to store current theme
  ThemeData? currentThemeData;

  // Singleton to ensure only 1 instance of provider exists
  static ThemeProvider? _instance;

  // getter for the instance
  static ThemeProvider get instance {
    _instance ??= ThemeProvider._init();
    return _instance!;
  }

  ThemeProvider._init();

  // method to change theme & immediately notifiy the provider's listeners
  Future<void> changeTheme(ThemeEnum theme) async {
    currentTheme = theme;
    await _generateThemeData();
    notifyListeners();
  }

  // private method to generate theme data
  Future<void> _generateThemeData() async {
    String themeStr = await rootBundle.loadString(_getThemeJsonPath());
    Map themeJson = jsonDecode(themeStr);
    currentThemeData = ThemeDecoder.decodeThemeData(themeJson);
  }

  // private method to return the path of specified theme
  String _getThemeJsonPath() {
    switch (currentTheme) {
      case ThemeEnum.light:
        return "assets/themes/theme_light.json";
      case ThemeEnum.dark:
        return "assets/themes/theme_dark.json";
      default:
        return "assets/themes/theme_light.json";
    }
  }
}

class Util {
  static ThemeData? getTheme(BuildContext context) {
    return Provider.of<ThemeProvider>(context, listen: false).currentThemeData;
  }

  static void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      backgroundColor: Color(0xff1055e5),
      toastLength: Toast.LENGTH_LONG
    );
  }
}