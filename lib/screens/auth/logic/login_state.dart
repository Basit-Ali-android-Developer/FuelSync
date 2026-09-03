import 'package:fuel_application/core/constants/request_status.dart';

class LoginState {
  final bool isPasswordObscured;
  final RequestStatus status;
  final String? errorMessage;

  const LoginState({
    this.isPasswordObscured = true,
    this.status = RequestStatus.initial,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isPasswordObscured,
    RequestStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}