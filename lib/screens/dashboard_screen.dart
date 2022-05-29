import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto/bloc/currencies_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrenciesBloc, CurrenciesState>(
      builder: (context, state) {
        if (state is CurrenciesInitialState ||
            state is CurrenciesLoadingState) {
          return const CircularProgressIndicator();
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
          if (state.list.isEmpty) {
            return const Center(
              child: Text('List is empty', style: TextStyle(fontSize: 20)),
            );
          } else {
            return Column(
              children: [
                // const Text(
                //   'Dashboard Screen',
                //   style: TextStyle(fontSize: 30),
                // ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return const _ListItem();
                    },
                    itemCount: state.list.length,
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
  const _ListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('item click');
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
            const Text('BTC', style: TextStyle(fontSize: 24)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('9283.92 USD', style: TextStyle(fontSize: 20)),
                    Text('0.518894%'),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.star_border,
                size: 30,
              ),
              onPressed: () {
                print('star');
              },
            ),
          ],
        ),
      ),
    );
  }
}
