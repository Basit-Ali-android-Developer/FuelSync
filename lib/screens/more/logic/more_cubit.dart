import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/helper/cache_helper.dart';
import 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(MoreInitial());

  void loadUserData() {
    emit(MoreLoading());
    try {
      final name = CacheHelper.getUserName() ?? 'User';
      final email = CacheHelper.getUserEmail() ?? 'user@example.com';
     // final role = CacheHelper.getUserRole() ?? 'STAFF';

      // Fetch branch details saved during branch selection
      final activeBranch = CacheHelper.getActiveBranchName() ?? 'No Branch Selected';
      final branchAddress = CacheHelper.getActiveBranchAddress() ?? 'Address not available';
      final isShiftOpen = CacheHelper.getActiveBranchShiftStatus();

      emit(MoreLoaded(
        name: name,
        email: email,
      //  role: role,
        activeBranch: activeBranch,
        branchAddress: branchAddress,
        isShiftOpen: isShiftOpen,
      ));
    } catch (e) {
      emit(MoreError("Failed to load user profile"));
    }
  }

  Future<void> logout() async {
    await CacheHelper.clearSession();
    emit(MoreLoggedOut());
  }
}