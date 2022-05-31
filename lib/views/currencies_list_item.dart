import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../bloc/currencies_bloc.dart';
import '../models/data_model.dart';
import '../screens/details_screen.dart';

class CurrenciesListItem extends StatelessWidget {
  final DataModel currency;
  final bool isFavorite;

  const CurrenciesListItem({
    Key? key,
    required this.currency,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usdPrice = currency.quote?.uSD?.price ?? 0;
    final roundedPrice = usdPrice.toStringAsFixed(4);
    double change24h = currency.quote?.uSD?.percentChange24h ?? 0;
    bool isRising = change24h > 0;

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
                child: Row(
                  children: [
                    Text(
                      '$roundedPrice USD',
                      style: const TextStyle(fontSize: 16),
                    ),
                    isRising
                        ? const Icon(Icons.arrow_upward, color: Colors.green)
                        : const Icon(Icons.arrow_downward, color: Colors.red),
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
                final bloc = GetIt.I.get<CurrenciesBloc>();
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
