import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:enthrirhc/pages/construct/mod.dart';
import 'package:enthrirhc/pages/search.dart';
import 'package:enthrirhc/pages/settings.dart';
import 'package:provider/provider.dart';

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
    primaryContainer: baseColorScheme.primaryContainer,
    onPrimaryContainer: baseColorScheme.onPrimaryContainer,
    secondary: baseColorScheme.secondary,
    onSecondary: baseColorScheme.onSecondary,
    secondaryContainer: baseColorScheme.secondaryContainer,
    onSecondaryContainer: baseColorScheme.onSecondaryContainer,
    tertiary: baseColorScheme.tertiary,
    onTertiary: baseColorScheme.onTertiary,
    tertiaryContainer: baseColorScheme.tertiaryContainer,
    onTertiaryContainer: baseColorScheme.onTertiaryContainer,
    error: baseColorScheme.error,
    onError: baseColorScheme.onError,
    errorContainer: baseColorScheme.errorContainer,
    onErrorContainer: baseColorScheme.onErrorContainer,
    background: Colors.black,
    onBackground: baseColorScheme.onBackground,
    surface: Colors.black,
    onSurface: baseColorScheme.onSurface,
    surfaceVariant: baseColorScheme.surfaceVariant,
    onSurfaceVariant: baseColorScheme.onSurfaceVariant,
    outline: baseColorScheme.outline,
    outlineVariant: baseColorScheme.outlineVariant,
    shadow: baseColorScheme.shadow,
    scrim: baseColorScheme.scrim,
    inverseSurface: baseColorScheme.inverseSurface,
    onInverseSurface: baseColorScheme.onInverseSurface,
    inversePrimary: baseColorScheme.inversePrimary,
    surfaceTint: baseColorScheme.surfaceTint,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: const [
          SearchPage(),
          ConstructPage(),
          SettingsPage(),
        ],
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
