import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter/services.dart';
import 'package:enthrirch/pages/construct.dart';
import 'package:enthrirch/pages/search.dart';
import 'package:enthrirch/pages/settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final darkTheme = await getInitialDarkTheme();

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(darkTheme: darkTheme),
    child: const App(),
  ));
}

Future<int> getInitialDarkTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final theme = prefs.getInt('darkTheme');
  if (theme != null) {
    return theme;
  } else {
    prefs.setInt('darkTheme', 1);
    return 1;
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, theme, child) => MaterialApp(
        title: 'Enţrirç',
        theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        darkTheme: theme.darkTheme == 2
            ? ThemeData(
                colorScheme: const ColorScheme(
                  brightness: Brightness.dark,
                  primary: Colors.grey,
                  onPrimary: Colors.grey,
                  secondary: Colors.black,
                  onSecondary: Colors.grey,
                  error: Colors.grey,
                  onError: Colors.grey,
                  background: Colors.black,
                  onBackground: Colors.grey,
                  surface: Colors.black,
                  onSurface: Colors.grey,
                ),
                useMaterial3: true,
              )
            : ThemeData(
                colorSchemeSeed: Colors.deepPurple,
                brightness: Brightness.dark,
                useMaterial3: true,
              ),
        home: ChangeNotifierProvider(
          create: (context) => LexiconModel(),
          child: const RootPage(),
        ),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: [
          const SearchPage(),
          const ConstructPage(),
          const SettingsPage(),
        ][_currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.construction),
            label: 'Construct',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }
}
