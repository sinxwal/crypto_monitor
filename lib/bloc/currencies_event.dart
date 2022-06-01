part of 'currencies_bloc.dart';

abstract class CurrenciesEvent {}

class LoadCurrenciesEvent extends CurrenciesEvent {}

class AddToFavsEvent extends CurrenciesEvent {
  final int id;

  AddToFavsEvent(this.id);
}

class RemoveFromFavsEvent extends CurrenciesEvent {
  final int id;

  RemoveFromFavsEvent(this.id);
}

class SelectCurrencyCodeEvent extends CurrenciesEvent {
  final String currencyCode;

  SelectCurrencyCodeEvent(this.currencyCode);
}

class ToggleDarkThemeEvent extends CurrenciesEvent {
  final bool isDarkTheme;

  ToggleDarkThemeEvent(this.isDarkTheme);
}
