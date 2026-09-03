
class LoginRequestModel {
  final String email;
  final String password;
  final String tenantCode;

  LoginRequestModel({
    required this.tenantCode,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'tenantCode': tenantCode,
    'email': email,
    'password': password,
  };
}