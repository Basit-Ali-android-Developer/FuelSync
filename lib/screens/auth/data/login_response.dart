class LoginResponseModel {
  final String accessToken;
  final String refreshToken;
  final String email;
  final String name;

  LoginResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.email,
    required this.name,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken']?.toString() ?? '',
      refreshToken: json['refreshToken']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'email': email,
      'name': name,
    };
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