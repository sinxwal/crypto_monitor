import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/currencies_bloc.dart';
import 'repositories/currencies_repository.dart';
import 'app.dart';

Future<void> setup() async {
  await dotenv.load(fileName: ".env");

  final sharedPrefs = await SharedPreferences.getInstance();
  final currenciesRepository = CurrenciesRepository(sharedPrefs);

  GetIt.I.registerSingleton<CurrenciesBloc>(
    CurrenciesBloc(
      sharedPrefs: sharedPrefs,
      currenciesRepository: currenciesRepository,
    )..add(LoadCurrenciesEvent()),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const App());
}
