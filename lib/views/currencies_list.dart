import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../bloc/currencies_bloc.dart';
import '../models/data_model.dart';
import 'currencies_list_item.dart';

class CurrenciesList extends StatelessWidget {
  const CurrenciesList({
    Key? key,
    required this.currencyCode,
    required this.list,
    required this.favoriteIds,
    this.filter = '',
  }) : super(key: key);

  final String currencyCode;
  final List<DataModel> list;
  final Set<int> favoriteIds;
  final String filter;

  Future<void> _onRefresh() {
    final block = GetIt.I.get<CurrenciesBloc>()..add(LoadCurrenciesEvent());
    return block.stream.firstWhere((el) => el is! CurrenciesLoadingState);
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = list
        .where((el) =>
            (el.symbol ?? '').toLowerCase().contains(filter.toLowerCase()))
        .toList();

    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: filteredList.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      DataModel item = filteredList[index];
                      bool isFavorite = favoriteIds.contains(item.id);
                      return CurrenciesListItem(
                        currency: item,
                        currencyCode: currencyCode,
                        isFavorite: isFavorite,
                      );
                    },
                    itemCount: filteredList.length,
                  )
                : Text(
                    'Nothing to display',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
          ),
        ),
      ],
    );
  }
}
