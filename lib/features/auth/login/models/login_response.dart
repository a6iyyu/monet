/// Represents the response received after a successful login attempt.
/// It contains the authentication token that can be used for subsequent requests.
class LoginResponse {
  final String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] == null || json['data']['token'] == null) {
      throw Exception("[${DateTime.now().toIso8601String().replaceAll('T', ' ').replaceAll('.000', '')}] Invalid response format: 'data' or 'token' is missing.");
    }

    return LoginResponse(token: json['data']['token'] as String);
  }
}