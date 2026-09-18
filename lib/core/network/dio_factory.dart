import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:fuel_application/core/constants/api_endpoint.dart';
import 'package:fuel_application/core/helper/cache_helper.dart';

class DioFactory {
  DioFactory._();

  static Dio? _dio;

  static Dio getDio() {
    if (_dio == null) {
      _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
          // FIX: Treat any status >= 300 (including 401) as an error so Dio throws a DioException
          validateStatus: (status) => status != null && status >= 200 && status < 300,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // Retrieve fresh token on every request directly from SharedPreferences
            final token = CacheHelper.getToken();

            if (token != null &&
                token != 'null' &&
                token != 'undefined' &&
                token.trim().isNotEmpty) {
              final cleanedToken = token.replaceAll('"', '').trim();
              options.headers['Authorization'] = 'Bearer $cleanedToken';
            } else {
              // Ensure authorization header is clean if no token is stored
              options.headers.remove('Authorization');
            }

            // Extract Authorization Header for Logging
            final String authHeader = options.headers['Authorization'] != null
                ? "\n Token: ${options.headers['Authorization']}"
                : "\n Token: None";

            // Format and log outgoing requests
            final String queryParams = options.queryParameters.isNotEmpty
                ? "\n QueryParams: ${jsonEncode(options.queryParameters)}"
                : "";
            final String body = options.data != null
                ? "\n Body: ${options.data is Map || options.data is List ? jsonEncode(options.data) : options.data}"
                : "";

            developer.log(
              "🚀 [${options.method}] ${options.uri}$authHeader$queryParams$body",
              name: 'DioFactory.Request',
            );

            return handler.next(options);
          },

          onResponse: (response, handler) {
            final String responseString =
            response.data is Map || response.data is List
                ? const JsonEncoder.withIndent('  ').convert(response.data)
                : response.data.toString();

            developer.log(
              "✅ [STATUS ${response.statusCode}] ${response.requestOptions.path}\n Response:\n$responseString",
              name: 'DioFactory.Response',
            );

            return handler.next(response);
          },

          onError: (DioException e, handler) async {
            final path = e.requestOptions.path;
            final isAuthRequest = path.contains('/auth/') ||
                path.contains('/login') ||
                path.contains('/signUp') ||
                path.contains('/signup');

            // Handle 401 Unauthorized (Session Expiration) for non-auth calls
            if (e.response?.statusCode == 401 && !isAuthRequest) {
              developer.log(
                "🔒 Session expired (401). Purging token and resetting cache...",
                name: 'DioFactory.Error',
              );

              await CacheHelper.clearSession();

              return handler.reject(e);
            }

            developer.log(
              "❌ [ERROR ${e.response?.statusCode ?? 'UNKNOWN'}] ${e.requestOptions.path}\n"
                  " Message: ${e.message}\n"
                  " Response Data: ${e.response?.data}",
              name: 'DioFactory.Error',
              error: e.error,
              stackTrace: e.stackTrace,
            );

            return handler.next(e);
          },
        ),
      );
    }
    return _dio!;
  }
}