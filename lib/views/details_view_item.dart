import 'package:flutter/material.dart';

class DetailsViewItem extends StatelessWidget {
  final String label;
  final String value;

  const DetailsViewItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
      side: BorderSide(color: Colors.grey.shade300),
    );

    return ListTile(
      shape: shape,
      title: Text(
        label,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
