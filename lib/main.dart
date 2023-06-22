import 'package:flutter/material.dart' hide SearchBar;
import 'package:ithkuil_helper/pages/construct.dart';
import 'package:ithkuil_helper/pages/search/index.dart';
import 'package:ithkuil_helper/pages/search/app_bar.dart';
import 'package:ithkuil_helper/pages/settings.dart';
import 'package:provider/provider.dart';

import 'common/store.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enţrirç',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => LexiconModel(),
        child: const RootPage(),
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
      appBar: [
        SearchBar(),
        AppBar(
          title: const Text("Construct"),
        ),
        AppBar(
          title: const Text("Settings"),
        )
      ][_currentPageIndex],
      body: [
        const SearchPage(),
        const ConstructPage(),
        const SettingsPage(),
      ][_currentPageIndex],
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
