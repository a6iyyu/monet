/// Represents a request for user registration.
class RegisterRequest {
  final String fullName;
  final String email;
  final String password;
  final String country;
  final String defaultCurrency;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.country,
    required this.defaultCurrency,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      'country': country,
      'default_currency': defaultCurrency,
    };
  }
}