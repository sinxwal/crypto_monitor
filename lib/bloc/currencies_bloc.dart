import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data_model.dart';
import '../repositories/currencies_repository.dart';

part 'currencies_event.dart';
part 'currencies_state.dart';

const favsKey = 'favorites';

Set<int> convertStringSetToIntSet(Set<String> strings) {
  return strings.fold<Set<int>>(<int>{}, (previousValue, element) {
    final parsed = int.tryParse(element);
    if (parsed != null) {
      previousValue.add(parsed);
    }
    return previousValue;
  });
}

class CurrenciesBloc extends Bloc<CurrenciesEvent, CurrenciesState> {
  CurrenciesBloc({
    required CurrenciesRepository currenciesRepository,
    required SharedPreferences sharedPrefs,
  }) : super(CurrenciesInitialState()) {
    on<LoadCurrenciesEvent>((
      LoadCurrenciesEvent event,
      Emitter<CurrenciesState> emit,
    ) async {
      emit(CurrenciesLoadingState());
      try {
        final currencies = await currenciesRepository.getAllCurrencies();

        final favsSerialized = sharedPrefs.getString(favsKey) ?? '';
        final Set<String> favsRawSet = Set.of(favsSerialized.split(','));
        final Set<int> favsSet = convertStringSetToIntSet(favsRawSet);

        emit(CurrenciesLoadedState(currencies, favsSet));
      } catch (e) {
        emit(CurrenciesErrorState(e.toString()));
      }
    });

    on<AddToFavsEvent>((
      AddToFavsEvent event,
      Emitter<CurrenciesState> emit,
    ) async {
      if (state is CurrenciesLoadedState) {
        Set<int> nextIds = Set.from((state as CurrenciesLoadedState).favIds);
        nextIds.add(event.id);
        await sharedPrefs.setString(favsKey, nextIds.join(','));
        emit((state as CurrenciesLoadedState).copyWith(nextIds));
      }
    });

    on<RemoveFromFavsEvent>((
      RemoveFromFavsEvent event,
      Emitter<CurrenciesState> emit,
    ) async {
      if (state is CurrenciesLoadedState) {
        Set<int> nextIds = Set.from((state as CurrenciesLoadedState).favIds);
        nextIds.remove(event.id);
        await sharedPrefs.setString(favsKey, nextIds.join(','));
        emit((state as CurrenciesLoadedState).copyWith(nextIds));
      }
    });
  }
}
