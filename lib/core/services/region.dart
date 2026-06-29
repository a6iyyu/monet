import 'package:dio/dio.dart';
import 'package:monet/utils/log.dart';

class Region {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://countriesnow.space/api/v0.1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// Fetches a list of countries from the API. Returns a list of country names
  /// sorted alphabetically.
  ///
  /// Example usage:
  /// ```dart
  /// import 'package:monet/core/services/region.dart';
  /// final regionService = Region();
  /// final countries = await regionService.getCountries();
  /// ```
  Future<List<String>> getCountries() async {
    try {
      final response = await _dio.get('/countries/currency');

      if (response.statusCode != 200) {
        throw Exception('An error occurred while fetching countries. Please try again later.');
      }

      final dynamic responseData = response.data;

      if (responseData is! Map || responseData['error'] == true) {
        Log.error('Unexpected API response format: $responseData');
        throw Exception('Unexpected API response format.');
      }

      final List<dynamic> data = responseData['data'];
      final List<String> countries = data.map((e) => e['name']?.toString()).where((name) => name != null && name.isNotEmpty).cast<String>().toList();

      countries.sort();
      return countries;
    } catch (e) {
      Log.error('Error fetching countries: $e');
      return ['Australia', 'Brazil', 'Canada', 'Indonesia', 'Japan', 'Malaysia', 'Singapore', 'United Kingdom', 'United States'];
    }
  }

  /// Fetches a list of currencies from the API. Returns a list of currency
  /// codes sorted alphabetically.
  ///
  /// Example usage:
  /// ```dart
  /// import 'package:monet/core/services/region.dart';
  /// final regionService = Region();
  /// final currencies = await regionService.getCurrencies();
  /// ```
  Future<List<String>> getCurrencies() async {
    try {
      final response = await _dio.get('/countries/currency');

      if (response.statusCode != 200) {
        throw Exception('An error occurred while fetching currencies. Please try again later.');
      }

      final dynamic responseData = response.data;

      if (responseData is! Map || responseData['error'] == true) {
        Log.error('Unexpected API response format: $responseData');
        throw Exception('Unexpected API response format.');
      }

      final List<dynamic> data = responseData['data'];
      final Set<String> currencies = {};

      for (final country in data) {
        final currency = country['currency']?.toString();
        if (currency == null || currency.isEmpty) continue;
        currencies.add(currency);
      }

      return currencies.toList()..sort();
    } catch (e) {
      Log.error('Error fetching currencies: $e');
      return ['AUD', 'BRL', 'CAD', 'EUR', 'GBP', 'IDR', 'JPY', 'MYR', 'SGD', 'USD'];
    }
  }
}