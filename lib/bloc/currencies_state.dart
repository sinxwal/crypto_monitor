part of 'currencies_bloc.dart';

abstract class CurrenciesState {}

class CurrenciesInitialState extends CurrenciesState {}

class CurrenciesLoadingState extends CurrenciesState {}

class CurrenciesErrorState extends CurrenciesState {
  final String message;

  CurrenciesErrorState(this.message);
}

class CurrenciesLoadedState extends CurrenciesState {
  CurrenciesLoadedState({
    this.data = const [],
    this.currencyCode = "USD",
    this.favoriteIds = const {},
  });

  final List<DataModel> data;
  final String currencyCode;
  Set<int> favoriteIds = {};

  CurrenciesLoadedState copyWith(
      {List<DataModel>? data, Set<int>? favoriteIds, String? currencyCode}) {
    return CurrenciesLoadedState(
      data: data ?? this.data,
      currencyCode: currencyCode ?? this.currencyCode,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}
