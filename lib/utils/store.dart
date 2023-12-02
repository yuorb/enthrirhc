import 'package:flutter/widgets.dart';
import 'package:enthrirhs/database/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LexiconModel extends ChangeNotifier {
  final Database database = constructDb();
}

class ThemeProvider extends ChangeNotifier {
  int _darkTheme;

  int get darkTheme => _darkTheme;

  set darkTheme(int newDarkTheme) {
    _darkTheme = newDarkTheme;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('darkTheme', newDarkTheme);
    });
  }

  ThemeProvider({darkTheme}) : _darkTheme = darkTheme;
}
