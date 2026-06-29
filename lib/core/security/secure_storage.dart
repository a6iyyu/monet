import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// A utility class for securely storing and retrieving sensitive data,
/// such as authentication tokens.
class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _tokenKey = 'token';

  /// Saves the provided token securely in the storage.
  ///
  /// Example usage:
  /// ```dart
  /// import 'package:monet/core/security/secure_storage.dart';
  ///
  /// ... // Rest of your code
  /// final secureStorage = SecureStorage();
  /// secureStorage.saveToken(token);
  /// ... // Rest of your code
  /// ```
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Retrieves the token from secure storage. Returns the token as a [String]
  /// if it exists, or `null` if it doesn't.
  ///
  /// Example usage:
  /// ```dart
  /// import 'package:monet/core/security/secure_storage.dart';
  ///
  /// ... // Rest of your code
  /// final secureStorage = SecureStorage();
  /// final token = await secureStorage.getToken();
  /// ... // Rest of your code
  /// ```
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Deletes the token from secure storage.
  ///
  /// Example usage:
  /// ```dart
  /// import 'package:monet/core/security/secure_storage.dart';
  ///
  /// ... // Rest of your code
  /// final secureStorage = SecureStorage();
  /// await secureStorage.deleteToken();
  /// ... // Rest of your code
  /// ```
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}