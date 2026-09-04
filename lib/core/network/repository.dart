import 'package:dio/dio.dart';
import 'package:fuel_application/core/constants/api_endpoint.dart';
import 'package:fuel_application/core/helper/cache_helper.dart';
import 'package:fuel_application/core/network/dio_factory.dart';
import 'package:fuel_application/screens/auth/data/login_request.dart';
import 'package:fuel_application/screens/auth/data/login_response.dart';
import 'package:fuel_application/screens/branch/data/branch_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<List<BranchModel>> getBranches();
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
}