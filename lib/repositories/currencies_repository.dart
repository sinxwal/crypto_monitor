import 'package:dio/dio.dart';

const _baseUrl = 'https://sandbox-api.coinmarketcap.com/v1';

class CurrenciesRepository {
  CurrenciesRepository();

  final Dio dio = Dio()
    ..options.baseUrl = _baseUrl
    ..options.headers = {
      'X-CMC_PRO_API_KEY': 'b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c'
    };

  Future<List<dynamic>> getAllCurrencies() async {
    try {
      final response = await dio.get('/cryptocurrency/listings/latest');

      print(response);

      return [];
    } catch (e) {
      print(e.toString());
      throw "Network Error. Try again later.";
    }
  }
}
