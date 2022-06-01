import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/currencies_bloc.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "USD", child: Text("USD")),
      const DropdownMenuItem(value: "RUB", child: Text("RUB")),
      const DropdownMenuItem(value: "BTC", enabled: false, child: Text("BTC")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = GetIt.I.get<CurrenciesBloc>();
    return BlocBuilder<CurrenciesBloc, CurrenciesState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is CurrenciesLoadedState) {
          final code = state.currencyCode;
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                SwitchListTile(
                    title: const Text('Dark theme'),
                    value: true,
                    onChanged: (_) {
                      return;
                    }),
                ListTile(
                  title: const Text('Base currency'),
                  trailing: DropdownButton(
                    value: code.toString(),
                    items: dropdownItems,
                    onChanged: (value) {
                      if (value == "USD") {
                        bloc.add(SelectCurrencyCodeEvent("USD"));
                      } else {
                        bloc.add(SelectCurrencyCodeEvent("RUB"));
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
