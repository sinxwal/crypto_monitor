import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/details_screen.dart';
import 'models/data_model.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeScreen.routeName:
            return MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              },
            );
          case DetailsScreen.routeName:
            final model = settings.arguments as DataModel;
            return MaterialPageRoute(
              builder: (context) {
                return DetailsScreen(currency: model);
              },
            );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
