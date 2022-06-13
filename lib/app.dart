import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'bloc/currencies_bloc.dart';
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
    return BlocBuilder<CurrenciesBloc, CurrenciesState>(
      bloc: GetIt.I.get<CurrenciesBloc>(),
      builder: (context, state) {
        final isDarkTheme = state is CurrenciesLoadedState
            ? state.isDarkTheme
            : state is CurrenciesLoadingState
                ? state.isDarkTheme
                : false;

        return MaterialApp(
          themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
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
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 2,
              iconTheme: const IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                color: Colors.black.withOpacity(0.95),
                fontSize: 26.0,
              ),
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.black.withOpacity(0.95),
              ),
              headline3: TextStyle(
                color: Colors.black.withOpacity(0.95),
              ),
            ),
            scaffoldBackgroundColor: const Color.fromRGBO(244, 244, 244, 1.0),
          ),
          darkTheme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.black,
              elevation: 2,
              titleTextStyle: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontSize: 26.0,
              ),
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.white.withOpacity(0.95),
              ),
              headline3: TextStyle(
                color: Colors.white.withOpacity(0.95),
              ),
            ),
            scaffoldBackgroundColor: const Color.fromRGBO(11, 11, 15, 1.0),
            switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all(Colors.yellow),
              trackColor: MaterialStateProperty.all(Colors.yellow[100]),
            ),
          ),
        );
      },
    );
  }
}
