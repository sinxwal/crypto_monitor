part of 'currencies_bloc.dart';

abstract class CurrenciesState {}

class CurrenciesInitialState extends CurrenciesState {}

class CurrenciesLoadingState extends CurrenciesState {}

class CurrenciesErrorState extends CurrenciesState {
  final String message;

  CurrenciesErrorState(this.message);
}

class CurrenciesLoadedState extends CurrenciesState {
  final List<DataModel> data;

  CurrenciesLoadedState(this.data);
}
