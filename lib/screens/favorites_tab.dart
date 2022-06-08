import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/currencies_bloc.dart';
import '../views/currencies_list.dart';
import '../views/error_message.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  final _controller = TextEditingController();

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
          final items = state.data
              .where((el) => state.favoriteIds.contains(el.id))
              .toList();
          if (items.isEmpty) {
            return Center(
              child: Text(
                'Favorites list is empty',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            );
          } else {
            return ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, TextEditingValue value, __) {
                  return Column(
                    children: [
                      const SizedBox(height: 12.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          child: ListTile(
                            title: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                hintText: 'Filter',
                                border: InputBorder.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                _controller.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CurrenciesList(
                          currencyCode: state.currencyCode,
                          favoriteIds: state.favoriteIds,
                          list: items,
                          filter: value.text,
                        ),
                      ),
                    ],
                  );
                });
          }
        }

        return Container();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
