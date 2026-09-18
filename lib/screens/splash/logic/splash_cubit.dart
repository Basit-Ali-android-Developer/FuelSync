import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/helper/cache_helper.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startSplash() async {
    emit(SplashLoading());

    await Future.delayed(const Duration(milliseconds: 1500));

    final String? token = CacheHelper.getToken();
    final bool isLoggedIn = token != null && token.trim().isNotEmpty && token != 'null';

    // 1. If not logged in -> Go to Login
    if (!isLoggedIn) {
      emit(SplashUnauthenticated());
      return;
    }

    // 2. Fetch Active Branch ID strictly
    final int? branchId = CacheHelper.getActiveBranchId();

    // 3. If Logged in but Branch is NOT saved -> Go to Select Branch
    if (branchId == null) {
      emit(SplashSelectBranch());
    } else {
      // 4. Both Auth & Branch exist -> Dashboard
      emit(SplashAuthenticated());
    }
  }
}