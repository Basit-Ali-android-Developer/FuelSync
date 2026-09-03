class LoginResponseModel {
  final bool success;
  final AuthDataModel? data;
  final String? error;

  LoginResponseModel({
    required this.success,
    this.data,
    this.error,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? AuthDataModel.fromJson(json['data']) : null,
      error: json['error']?.toString(),
    );
  }
}

class AuthDataModel {
  final String accessToken;
  final String refreshToken;
  final String expiresAt;

  AuthDataModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      accessToken: json['accessToken']?.toString() ?? '',
      refreshToken: json['refreshToken']?.toString() ?? '',
      expiresAt: json['expiresAt']?.toString() ?? '',
    );
  }
}