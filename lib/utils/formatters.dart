import 'package:intl/intl.dart';

/// A utility class for formatting values.
class Formatters {
  Formatters._();

  /// Capitalizes the first letter of a string and converts the rest to lowercase.
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    if (text.length == 1) return text.toUpperCase();
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Formats a double value into a currency string with the specified symbol and locale.
  static String currency(double amount, {String symbol = 'Rp '}) {
    return NumberFormat.currency(decimalDigits: 0, locale: 'id_ID', symbol: symbol).format(amount);
  }

  /// Formats a date and time value into a string with the specified format and locale.
  static String dateTime(DateTime date) {
    return DateFormat('dd MMM yyyy, HH:mm', 'id_ID').format(date);
  }

  /// Masks a card number by replacing all but the last four digits with asterisks.
  static String maskCardNumber(String cardNumber) {
    if (cardNumber.length <= 4) {
      return cardNumber; // Return the original number if it's too short to mask
    }

    final String lastFour = cardNumber.substring(cardNumber.length - 4);
    return '**** **** **** $lastFour'; // Mask all but the last four digits
  }
}