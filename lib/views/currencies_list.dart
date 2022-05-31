import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../bloc/currencies_bloc.dart';
import '../models/data_model.dart';
import 'currencies_list_item.dart';

class CurrenciesList extends StatelessWidget {
  const CurrenciesList({
    Key? key,
    required this.list,
    required this.favoriteIds,
  }) : super(key: key);

  final List<DataModel> list;
  final Set<int> favoriteIds;

  Future<void> _onRefresh() {
    final block = GetIt.I.get<CurrenciesBloc>()..add(LoadCurrenciesEvent());
    return block.stream.firstWhere((el) => el is! CurrenciesLoadingState);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemBuilder: (context, index) {
                DataModel item = list[index];
                bool isFavorite = favoriteIds.contains(item.id);
                return CurrenciesListItem(
                  currency: item,
                  isFavorite: isFavorite,
                );
              },
              itemCount: list.length,
            ),
          ),
        ),
      ],
    );
  }
}
