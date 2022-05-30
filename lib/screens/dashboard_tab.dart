import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto/bloc/currencies_bloc.dart';
import 'package:crypto/screens/details_screen.dart';
import 'package:crypto/models/data_model.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrenciesBloc, CurrenciesState>(
      builder: (context, state) {
        if (state is CurrenciesInitialState ||
            state is CurrenciesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CurrenciesErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Error', style: TextStyle(fontSize: 22)),
                Text(' ${state.message}', style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        }

        if (state is CurrenciesLoadedState) {
          if (state.data.isEmpty) {
            return const Center(
              child: Text('List is empty', style: TextStyle(fontSize: 20)),
            );
          } else {
            return Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      DataModel item = state.data[index];
                      bool isFavorite = state.favIds.contains(item.id);
                      return _ListItem(
                        currency: item,
                        isFavorite: isFavorite,
                      );
                    },
                    itemCount: state.data.length,
                  ),
                ),
              ],
            );
          }
        }

        return Container();
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final DataModel currency;
  final bool isFavorite;

  const _ListItem({
    Key? key,
    required this.currency,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double usdPrice = currency.quote?.uSD?.price ?? 0;
    double change24h = currency.quote?.uSD?.percentChange24h ?? 0;
    // bool isRising = change24h > 0;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: currency,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 4.0,
              offset: const Offset(2.0, 2.0),
            )
          ],
        ),
        child: Row(
          children: [
            Text(currency.symbol ?? '', style: const TextStyle(fontSize: 20)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$usdPrice USD', style: const TextStyle(fontSize: 20)),
                    Text('$change24h%'),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                size: 30,
              ),
              onPressed: () {
                final bloc = context.read<CurrenciesBloc>();
                if (currency.id != null) {
                  if (isFavorite) {
                    bloc.add(RemoveFromFavsEvent(currency.id as int));
                  } else {
                    bloc.add(AddToFavsEvent(currency.id as int));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
