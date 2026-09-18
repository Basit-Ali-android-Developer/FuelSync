import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(MoreInitial());

  void loadUserData() async {
    emit(MoreLoading());
    try {
      final prefs = await SharedPreferences.getInstance();

      final name = prefs.getString('user_name') ?? 'Basit Ali';
      final email = prefs.getString('user_email') ?? 'basit.ali@fuelsync.com';
      final role = prefs.getString('user_role') ?? 'STATION OWNER';
      final activeBranch = prefs.getString('active_branch') ?? 'Main Station Branch';

      emit(MoreLoaded(
        name: name,
        email: email,
        role: role,
        activeBranch: activeBranch,
      ));
    } catch (e) {
      emit(MoreError('Failed to load user profile.'));
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(MoreLoggedOut());
  }
}