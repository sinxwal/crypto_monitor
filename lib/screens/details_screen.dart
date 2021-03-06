import 'package:flutter/material.dart';

import '../models/data_model.dart';
import '../views/details_view.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/details';

  final DataModel currency;

  const DetailsScreen({
    Key? key,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${currency.name} summary'),
      ),
      body: Center(
        child: DetailsView(data: currency),
      ),
    );
  }
}
