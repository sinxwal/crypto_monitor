import 'package:flutter/material.dart';

import '../models/data_model.dart';
import 'details_view_item.dart';

class DetailsView extends StatelessWidget {
  final DataModel data;

  const DetailsView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usdPriceRaw = data.quote?.uSD?.price ?? 0;
    final rubPriceRaw = data.quote?.rUB?.price ?? 0;
    final usdPrice = '${usdPriceRaw.toStringAsFixed(4)} USD';
    final rubPrice = '${rubPriceRaw.toStringAsFixed(4)} RUB';

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          const SizedBox(height: 12.0),
          DetailsViewItem(label: 'Name:', value: data.name ?? ''),
          DetailsViewItem(label: 'Rank', value: data.cmcRank.toString()),
          DetailsViewItem(
              label: 'Market Pairs', value: data.numMarketPairs.toString()),
          DetailsViewItem(
              label: 'Price', value: usdPriceRaw == 0 ? rubPrice : usdPrice),
        ],
      ),
    );
  }
}
