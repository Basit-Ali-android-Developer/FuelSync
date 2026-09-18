import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/constants/request_status.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'package:fuel_application/screens/auth/data/login_request.dart';
import 'package:fuel_application/screens/auth/logic/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(const LoginState());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<void> login({
    required String tenantCode,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RequestStatus.loading, errorMessage: null));

    try {
      final request = LoginRequestModel(
        tenantCode: tenantCode,
        email: email,
        password: password,
      );

      await _authRepository.login(request);

      emit(state.copyWith(status: RequestStatus.success));
    } catch (e) {
      final cleanError = e.toString().replaceAll('Exception: ', '');
      emit(
        state.copyWith(
          status: RequestStatus.error,
          errorMessage: cleanError.isNotEmpty
              ? cleanError
              : 'Invalid credentials. Please try again.',
        ),
      );
    }
  }
}