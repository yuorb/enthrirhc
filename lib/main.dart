import 'package:enthrirhs/libs/misc.dart';
import 'package:enthrirhs/pages/construct/store.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter/services.dart';
import 'package:enthrirhs/pages/construct/mod.dart';
import 'package:enthrirhs/pages/search.dart';
import 'package:enthrirhs/pages/settings.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:provider/provider.dart';

import 'libs/ithkuil/terms/mod.dart';
import 'utils/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  final initialSettings = await SettingsProvider.init();

  runApp(ChangeNotifierProvider(
    create: (_) => initialSettings,
    child: const App(),
  ));
}

ColorScheme createPureDarkColorScheme() {
  ColorScheme baseColorScheme = ThemeData(
    colorSchemeSeed: Colors.deepPurple,
    brightness: Brightness.dark,
    useMaterial3: true,
  ).colorScheme;
  return ColorScheme(
    brightness: baseColorScheme.brightness,
    primary: baseColorScheme.primary,
    onPrimary: baseColorScheme.onPrimary,
    secondary: baseColorScheme.secondary,
    onSecondary: baseColorScheme.onSecondary,
    error: baseColorScheme.error,
    onError: baseColorScheme.onError,
    background: Colors.black,
    onBackground: baseColorScheme.onBackground,
    surface: Colors.black,
    onSurface: baseColorScheme.onSurface,
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, theme, child) => MaterialApp(
        title: 'Enţrirç',
        theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        darkTheme: theme.darkTheme == 2
            ? ThemeData(
                colorScheme: createPureDarkColorScheme(),
                brightness: Brightness.dark,
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
  final ConstructPageRoots _constructPageRoots = ConstructPageRoots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: [
          const SearchPage(),
          ChangeNotifierProvider<ConstructPageRoots>.value(
            value: _constructPageRoots,
            child: const ConstructPage(),
          ),
          const SettingsPage(),
        ][_currentPageIndex],
      ),
      floatingActionButton: _currentPageIndex == 1
          ? FloatingActionButton(
              onPressed: () async {
                final rootStr = await prompt(
                  context,
                  title: const Text("Please enter the root"),
                  initialValue: "",
                );
                if (rootStr != null) {
                  final root = Root.from(rootStr);
                  if (root != null && root.phonemes.isNotEmpty) {
                    _constructPageRoots.push(root);
                  } else {
                    if (!context.mounted) return;
                    await showErrorDialog(context, "Invalid root.");
                  }
                }
              },
              heroTag: null,
              child: const Icon(Icons.add),
            )
          : null,
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
