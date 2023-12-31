import 'package:flutter/widgets.dart';
import 'package:enthrirhs/database/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LexiconModel extends ChangeNotifier {
  final Database database = constructDb();
}

class SettingsProvider extends ChangeNotifier {
  int _darkTheme;
  bool _preferShortCut;
  bool _omitOptionalAffixes;

  int get darkTheme => _darkTheme;
  bool get preferShortCut => _preferShortCut;
  bool get omitOptionalAffixes => _omitOptionalAffixes;

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

  SettingsProvider({
    required int darkTheme,
    required bool preferShortCut,
    required bool omitOptionalAffixes,
  })  : _darkTheme = darkTheme,
        _preferShortCut = preferShortCut,
        _omitOptionalAffixes = omitOptionalAffixes;

  static Future<SettingsProvider> init() async {
    final prefs = await SharedPreferences.getInstance();
    final darkTheme = prefs.getInt('darkTheme') ?? 1;
    final preferShortCut = prefs.getBool('construct.preferShortCut') ?? false;
    final omitOptionalAffixes = prefs.getBool('construct.omitOptionalAffixes') ?? true;
    return SettingsProvider(
      darkTheme: darkTheme,
      preferShortCut: preferShortCut,
      omitOptionalAffixes: omitOptionalAffixes,
    );
  }
}
