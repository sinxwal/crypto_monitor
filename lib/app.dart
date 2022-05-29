import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto/bloc/currencies_bloc.dart';
import 'package:crypto/repositories/currencies_repository.dart';
import 'package:crypto/screens/dashboard_screen.dart';
import 'package:crypto/screens/favorites_screen.dart';
import 'package:crypto/screens/settings_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _AppHome(),
    );
  }
}

class _AppHome extends StatefulWidget {
  const _AppHome({Key? key}) : super(key: key);

  @override
  State<_AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<_AppHome> {
  int _selectedScreenIndex = 0;

  final List _screens = [
    {"name": const DashboardScreen(), "title": "Home"},
    {"name": const FavoritesScreen(), "title": "Favorites"},
    {"name": const SettingsScreen(), "title": "Settings"},
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrenciesBloc(
        currenciesRepository: CurrenciesRepository(),
      )..add(LoadCurrenciesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_screens[_selectedScreenIndex]["title"]),
        ),
        body: _screens[_selectedScreenIndex]["name"],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedScreenIndex,
          onTap: _selectScreen,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ],
        ),
      ),
    );
  }
}
