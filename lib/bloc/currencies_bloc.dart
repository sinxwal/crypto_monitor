import 'package:bloc/bloc.dart';

import 'package:crypto/models/data_model.dart';
import 'package:crypto/repositories/currencies_repository.dart';

part 'currencies_event.dart';
part 'currencies_state.dart';

class CurrenciesBloc extends Bloc<CurrenciesEvent, CurrenciesState> {
  CurrenciesBloc({
    required CurrenciesRepository currenciesRepository,
  }) : super(CurrenciesInitialState()) {
    on<LoadCurrenciesEvent>((
      LoadCurrenciesEvent event,
      Emitter<CurrenciesState> emit,
    ) async {
      emit(CurrenciesLoadingState());
      try {
        final currencies = await currenciesRepository.getAllCurrencies();
        emit(CurrenciesLoadedState(currencies, {}));
      } catch (e) {
        emit(CurrenciesErrorState(e.toString()));
      }
    });

    on<AddToFavsEvent>((
      AddToFavsEvent event,
      Emitter<CurrenciesState> emit,
    ) {
      if (state is CurrenciesLoadedState) {
        Set<int> nextIds = Set.from((state as CurrenciesLoadedState).favIds);
        nextIds.add(event.id);
        emit((state as CurrenciesLoadedState).copyWith(nextIds));
      }
    });

    on<RemoveFromFavsEvent>((
      RemoveFromFavsEvent event,
      Emitter<CurrenciesState> emit,
    ) {
      if (state is CurrenciesLoadedState) {
        Set<int> nextIds = Set.from((state as CurrenciesLoadedState).favIds);
        nextIds.remove(event.id);
        emit((state as CurrenciesLoadedState).copyWith(nextIds));
      }
    });
  }
}
