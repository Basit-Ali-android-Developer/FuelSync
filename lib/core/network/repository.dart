import 'package:dio/dio.dart';
import 'package:fuel_application/core/constants/api_endpoint.dart';
import 'package:fuel_application/core/helper/cache_helper.dart';
import 'package:fuel_application/core/network/dio_factory.dart';
import 'package:fuel_application/screens/auth/data/login_request.dart';
import 'package:fuel_application/screens/auth/data/login_response.dart';
import 'package:fuel_application/screens/branch/data/branch_model.dart';
import 'package:fuel_application/screens/home/data/dashboard_response_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<List<BranchModel>> getBranches();
  Future<DashboardResponseModel> getHomeDashboardData();
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio = DioFactory.getDio();

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final loginResponse = LoginResponseModel.fromJson(response.data);

      if (!loginResponse.success || loginResponse.data == null) {
        throw Exception(
          loginResponse.error ?? 'Login failed. Please check your credentials.',
        );
      }


      await CacheHelper.saveAuthData(
        token: loginResponse.data!.accessToken,
        userId: '',
        userName: '',
        userEmail: request.email,
        userPhone: '',
        userAddress: '',
      );

      return loginResponse;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
        final errorResponse = LoginResponseModel.fromJson(e.response!.data);
        if (errorResponse.error != null && errorResponse.error!.isNotEmpty) {
          throw Exception(errorResponse.error);
        }
      }
      throw Exception(_handleDioError(e));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data is Map) {
      final data = e.response?.data as Map;
      return data['error'] ?? data['message'] ?? 'Network error occurred';
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.connectionError) {
      return 'Cannot connect to server. Check your connection or backend status.';
    }
    return 'An unexpected error occurred. Please try again.';
  }


  @override
  Future<List<BranchModel>> getBranches() async {
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock API response matching your JSON payload
    final response = {
      "success": true,
      "data": [
        {
          "branchId": 3,
          "branchName": "Main Branch",
          "address": "123 Main Road, Lahore",
          "isShiftOpen": true,
        },
        {
          "branchId": 4,
          "branchName": "Gulberg Branch",
          "address": "45 Gulberg III, Lahore",
          "isShiftOpen": false,
        }
      ],
      "error": null
    };

    final List list = response["data"] as List;
    return list.map((e) => BranchModel.fromJson(e)).toList();
  }


  @override
  Future<DashboardResponseModel> getHomeDashboardData() async {
    // Simulate delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Mock API JSON matching provided response
    final response = {
      "success": true,
      "data": {
        "todayRevenuePkr": 280500.00,
        "yesterdayRevenuePkr": 265000.00,
        "revenueTrend": "up",
        "todayLitres": 998.5,
        "yesterdayLitres": 945.2,
        "activeDispenserCount": 4,
        "totalDispenserCount": 5,
        "openShifts": 1,
        "totalReceivablePkr": 245000.00,
        "todayRecoveryPkr": 35000.00,
        "totalCustomers": 28,
        "todayBorrowedFuelLitres": 45.0,
        "todayBorrowedAmountPkr": 12600.00,
        "lastShiftRevenuePkr": 142500.00,
        "lastShiftLitres": 507.5,
        "lastShiftLabel": "Shift #41 – 14 Jan 06:00",
        "tankLevels": [
          {
            "id": 1,
            "tankNumber": "T-01",
            "fuelTypeName": "Petrol",
            "currentLevelLitres": 8100.0,
            "capacityLitres": 20000.0,
            "fillPercentage": 40.5,
            "isBelowReorder": false
          },
          {
            "id": 2,
            "tankNumber": "T-02",
            "fuelTypeName": "Diesel",
            "currentLevelLitres": 1200.0,
            "capacityLitres": 15000.0,
            "fillPercentage": 8.0,
            "isBelowReorder": true
          }
        ],
        "revenueGraph": [
          {"label": "Mon", "amount": 265000.00, "litres": 945.2},
          {"label": "Tue", "amount": 280500.00, "litres": 998.5},
          {"label": "Wed", "amount": 0.0, "litres": 0.0}
        ],
        "recentTransactions": [
          {
            "id": 1201,
            "fuelGrade": "Petrol",
            "volumeLitres": 10.5,
            "totalAmountPkr": 2947.88,
            "recordedAt": "2025-01-15T14:22:00Z",
            "source": "Nozzle"
          },
          {
            "id": 1200,
            "fuelGrade": "Diesel",
            "volumeLitres": 20.0,
            "totalAmountPkr": 5310.00,
            "recordedAt": "2025-01-15T14:10:00Z",
            "source": "Nozzle"
          }
        ]
      },
      "error": null
    };

    return DashboardResponseModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}