import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data_model.dart';
import '../models/listing_result_model.dart';

const _baseUrl = 'https://pro-api.coinmarketcap.com/v1';

const _codeKey = 'currencyCode';

class CurrenciesRepository {
  CurrenciesRepository(this.prefs);

  final SharedPreferences prefs;

  final dio = Dio()
    ..options.baseUrl = _baseUrl
    ..options.headers = {'X-CMC_PRO_API_KEY': dotenv.env['API_TOKEN']};

  Future<List<DataModel>> getAllCurrencies() async {
    final currencyCode = prefs.getString(_codeKey) ?? 'USD';
    try {
      final response = await dio.get(
        '/cryptocurrency/listings/latest',
        queryParameters: {"convert": currencyCode},
      );
      final model = ListingResultModel.fromJson(response.data);
      return model.data ?? [];
    } catch (e) {
      if (e is DioError) {
        throw (e.error);
      } else {
        throw "Unknown error. Try again later.";
      }
    }
  }
}
