import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto/bloc/currencies_bloc.dart';
import 'package:crypto/repositories/currencies_repository.dart';
import 'package:crypto/screens/dashboard_tab.dart';
import 'package:crypto/screens/favorites_tab.dart';
import 'package:crypto/screens/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  final List _tabs = [
    {"name": const DashboardTab(), "title": "Home"},
    {"name": const FavoritesTab(), "title": "Favorites"},
    {"name": const SettingsTab(), "title": "Settings"},
  ];

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
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
          title: Text(_tabs[_selectedTabIndex]["title"]),
        ),
        body: _tabs[_selectedTabIndex]["name"],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: _selectTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
