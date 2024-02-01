import 'package:flutter/widgets.dart';
import 'package:enthrirhc/database/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LexiconModel extends ChangeNotifier {
  final Database database = constructDb();
}

class SettingsProvider extends ChangeNotifier {
  int _darkTheme;
  bool _preferShortCut;
  bool _omitOptionalAffixes;
  bool _omitOptionalCharacters;

  int get darkTheme => _darkTheme;
  bool get preferShortCut => _preferShortCut;
  bool get omitOptionalAffixes => _omitOptionalAffixes;
  bool get omitOptionalCharacters => _omitOptionalCharacters;

  set darkTheme(int newDarkTheme) {
    _darkTheme = newDarkTheme;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('darkTheme', newDarkTheme);
    });
  }

  set preferShortCut(bool newPreferShortCut) {
    _preferShortCut = newPreferShortCut;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('construct.preferShortCut', newPreferShortCut);
    });
  }

  set omitOptionalAffixes(bool newOmitOptionalAffixes) {
    _omitOptionalAffixes = newOmitOptionalAffixes;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('construct.omitOptionalAffixes', newOmitOptionalAffixes);
    });
  }

  set omitOptionalCharacters(bool newOmitOptionalCharacters) {
    _omitOptionalCharacters = newOmitOptionalCharacters;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('construct.omitOptionalCharacters', newOmitOptionalCharacters);
    });
  }

  SettingsProvider({
    required int darkTheme,
    required bool preferShortCut,
    required bool omitOptionalAffixes,
    required bool omitOptionalCharacters,
  })  : _darkTheme = darkTheme,
        _preferShortCut = preferShortCut,
        _omitOptionalAffixes = omitOptionalAffixes,
        _omitOptionalCharacters = omitOptionalCharacters;

  static Future<SettingsProvider> init() async {
    final prefs = await SharedPreferences.getInstance();
    final darkTheme = prefs.getInt('darkTheme') ?? 1;
    final preferShortCut = prefs.getBool('construct.preferShortCut') ?? false;
    final omitOptionalAffixes = prefs.getBool('construct.omitOptionalAffixes') ?? true;
    final omitOptionalCharacters = prefs.getBool('construct.omitOptionalCharacters') ?? true;
    return SettingsProvider(
      darkTheme: darkTheme,
      preferShortCut: preferShortCut,
      omitOptionalAffixes: omitOptionalAffixes,
      omitOptionalCharacters: omitOptionalCharacters,
    );
  }
}
