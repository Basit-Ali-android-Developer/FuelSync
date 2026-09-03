import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/helper/cache_helper.dart';
import 'package:fuel_application/screens/splash/logic/splash_state.dart';


class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> startSplash() async {
    emit(SplashLoading());

    // 3-second delay for splash branding
    await Future.delayed(const Duration(seconds: 3));

    // FIX: Call statically without parentheses CacheHelper()
    final bool isLoggedIn = CacheHelper.isLoggedIn();

    if (isLoggedIn) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}