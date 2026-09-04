import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuel_application/core/network/repository.dart';
import 'package:fuel_application/screens/home/logic/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AuthRepository _repository;

  HomeCubit(this._repository) : super(const HomeState());

  Future<void> fetchDashboardData() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final data = await _repository.getHomeDashboardData();
      emit(state.copyWith(status: HomeStatus.success, dashboardData: data));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: e.toString()));
    }
  }
}