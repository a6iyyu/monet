import 'package:dio/dio.dart';
import 'package:monet/utils/log.dart';

class Region {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://restcountries.com/v3.1',
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
      final response = await _dio.get('/all?fields=name');

      if (response.statusCode != 200 || response.data == null) {
        Log.error('Failed to fetch countries. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch countries from the server.');
      }

      final dynamic responseData = response.data;

      if (responseData is Map) {
        Log.warning('API returned a Map instead of List: $responseData');
        final message = responseData['message']?.toString();
        throw Exception(message ?? 'Unexpected API response format received.');
      }

      if (responseData is! List) {
        throw Exception('Invalid data format received from the server.');
      }

      final List<dynamic> data = responseData;

      final List<String> countries = data.map((country) {
        if (country is! Map) return '';
        if (country['name'] == null) return '';
        if (country['name']['common'] == null) return '';

        return country['name']['common'] as String;
      }).where((name) => name.isNotEmpty).toList();

      countries.sort();
      return countries;
    } on DioException catch (e) {
      Log.error('DioException in getCountries: ${e.message}', e);
      throw Exception('Connection issue occurred. Please check your internet connection.');
    } catch (e) {
      Log.error('Error parsing countries: $e');
      throw Exception(e.toString().replaceAll('Exception: ', ''));
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
      final response = await _dio.get('/all?fields=currencies');

      if (response.statusCode != 200 || response.data == null) {
        Log.error('Failed to fetch currencies. Status code: ${response.statusCode}');
        throw Exception('Failed to fetch currencies from the server.');
      }

      final dynamic responseData = response.data;

      if (responseData is Map) {
        Log.warning('API returned a Map instead of List: $responseData');
        final message = responseData['message']?.toString();
        throw Exception(message ?? 'Unexpected API response format received.');
      }

      if (responseData is! List) {
        throw Exception('Invalid data format received from the server.');
      }

      final List<dynamic> data = responseData;
      final Set<String> currencies = {};

      for (final country in data) {
        if (country is! Map) continue;

        final Map<String, dynamic>? currencyMap = country['currencies'];
        if (currencyMap == null) continue;

        currencies.addAll(currencyMap.keys);
      }

      return currencies.toList()..sort();
    } on DioException catch (e) {
      Log.error('DioException in getCurrencies: ${e.message}', e);
      throw Exception('Connection issue occurred. Please check your internet connection.');
    } catch (e) {
      Log.error('Error parsing currencies: $e');
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }
}