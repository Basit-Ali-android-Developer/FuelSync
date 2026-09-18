import 'package:dio/dio.dart';
import 'package:fuel_application/core/constants/api_endpoint.dart';
import 'package:fuel_application/core/helper/cache_helper.dart';
import 'package:fuel_application/core/network/dio_factory.dart';
import 'package:fuel_application/screens/auth/data/login_request.dart';
import 'package:fuel_application/screens/auth/data/login_response.dart';
import 'package:fuel_application/screens/branch/data/branch_model.dart';
import 'package:fuel_application/screens/branch/data/branch_response_model.dart';
import 'package:fuel_application/screens/home/data/dashboard_response_model.dart';
import 'package:fuel_application/screens/stock/data/stock_response_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<BranchResponseModel> getBranches();
  Future<DashboardResponseModel> getHomeDashboardData();
  Future<StockResponseModel> getStockData(int branchId);
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

      // Save tokens and profile data directly into CacheHelper
      await CacheHelper.saveAuthData(
        token: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
        userName: loginResponse.name,
        userEmail: loginResponse.email,
      );

      return loginResponse;
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
        final errorData = e.response!.data as Map<String, dynamic>;
        final errorMessage = errorData['message'] ?? errorData['error'] ?? 'Login failed. Please check your credentials.';
        throw Exception(errorMessage);
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
  Future<BranchResponseModel> getBranches() async {
    try {

      final response = await _dio.get(ApiEndpoints.getBranches);

      if (response.data != null && response.data is Map<String, dynamic>) {
        return BranchResponseModel.fromJson(response.data);
      } else {
        throw Exception("Invalid server response format.");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized. Please log in again.');
      }
      throw Exception('Failed to load branches.');
    }
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





  @override
  Future<StockResponseModel> getStockData(int branchId) async {
    // When live: replace mock with -> final response = await _dio.get('${ApiEndpoints.stock}/$branchId');
    await Future.delayed(const Duration(milliseconds: 600));

    final response = {
      "success": true,
      "data": {
        "totalInventory": {
          "currentLitres": 28450.0,
          "totalCapacity": 65000.0,
          "fillPercentage": 43.8,
          "tankAlertCount": 1,
          "superPetrolLitres": 19500.0,
          "dieselLitres": 8950.0,
          "ullageLitres": 36550.0
        },
        "tanks": [
          {
            "tankNumber": "T-01",
            "fuelTypeName": "Super Petrol (92 RON)",
            "status": "ATG Online",
            "tankType": "Underground UST",
            "currentLevelLitres": 8100.0,
            "capacityLitres": 20000.0,
            "fillPercentage": 40.5,
            "systemLevel": 8100.0,
            "lastManualDip": 8050.0,
            "manualDipDiff": -50.0,
            "lastDipTime": "Today, 09:15 AM",
            "reorderThreshold": 2000.0
          },
          {
            "tankNumber": "T-02",
            "fuelTypeName": "High Speed Diesel (HSD)",
            "status": "Low Stock Alert",
            "tankType": "Underground UST",
            "currentLevelLitres": 1200.0,
            "capacityLitres": 15000.0,
            "fillPercentage": 8.0,
            "systemLevel": 1200.0,
            "lastManualDip": 1150.0,
            "manualDipDiff": -50.0,
            "lastDipTime": "Today, 08:20 AM",
            "reorderThreshold": 1500.0,
            "alertMessage": "Below safety reserve (1,500 L). Tanker refill scheduled."
          },
          {
            "tankNumber": "T-03",
            "fuelTypeName": "Super Petrol (92 RON)",
            "status": "Manual Dip Only",
            "tankType": "Standing Aboveground",
            "currentLevelLitres": 11400.0,
            "capacityLitres": 15000.0,
            "fillPercentage": 76.0,
            "systemLevel": 11400.0,
            "lastManualDip": 11420.0,
            "manualDipDiff": 20.0,
            "lastDipTime": "Yesterday, 10:45 PM",
            "reorderThreshold": 2500.0
          },
          {
            "tankNumber": "T-04",
            "fuelTypeName": "High Speed Diesel (HSD)",
            "status": "ATG Online",
            "tankType": "Commercial Fleet Tank",
            "currentLevelLitres": 7750.0,
            "capacityLitres": 15000.0,
            "fillPercentage": 51.7,
            "systemLevel": 7750.0,
            "lastManualDip": 7710.0,
            "manualDipDiff": -40.0,
            "lastDipTime": "Today, 08:22 AM",
            "reorderThreshold": 2000.0
          }
        ],
        "recentDeliveries": [
          {
            "fuelType": "High Speed Diesel",
            "tankNumber": "T-02",
            "tankerInfo": "PKT-1422 • OMC Seal: HSD-98121",
            "status": "Completed",
            "volumeDischarged": 9850.0,
            "varianceLitres": -150.0,
            "baseRate": 265.50,
            "totalAmountPkr": 2615175.0,
            "timeStamp": "Jan 17, 08:00 AM",
            "verifiedBy": "Manager"
          },
          {
            "fuelType": "Super Petrol (92 RON)",
            "tankNumber": "T-01",
            "tankerInfo": "LHD-9502 • OMC Seal: MAT-12004",
            "status": "Full Discharge",
            "volumeDischarged": 15000.0,
            "varianceLitres": 0.0,
            "baseRate": 258.80,
            "totalAmountPkr": 3882000.0,
            "timeStamp": "Jan 15, 02:30 PM",
            "verifiedBy": "Shift In-charge"
          }
        ]
      }
    };

    return StockResponseModel.fromJson(response['data'] as Map<String, dynamic>);
  }
}