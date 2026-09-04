

import 'package:fuel_application/screens/home/data/dashboard_response_model.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState {
  final HomeStatus status;
  final DashboardResponseModel? dashboardData;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.dashboardData,
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    DashboardResponseModel? dashboardData,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      dashboardData: dashboardData ?? this.dashboardData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}