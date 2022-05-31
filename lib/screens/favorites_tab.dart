import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/currencies_bloc.dart';
import '../views/currencies_list.dart';
import '../views/error_message.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrenciesBloc, CurrenciesState>(
      bloc: GetIt.I.get<CurrenciesBloc>(),
      builder: (context, state) {
        if (state is CurrenciesInitialState ||
            state is CurrenciesLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CurrenciesErrorState) {
          return ErrorMessage(
            message: state.message,
          );
        }

        if (state is CurrenciesLoadedState) {
          final items =
              state.data.where((el) => state.favIds.contains(el.id)).toList();
          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Favorites list is empty',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return CurrenciesList(
              list: items,
              favoriteIds: state.favIds,
            );
          }
        }

        return Container();
      },
    );
  }
}
