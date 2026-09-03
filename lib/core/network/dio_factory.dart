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
          validateStatus: (status) => status != null && status < 500,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      _dio!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            //  Fetch saved token from CacheHelper
            final token = CacheHelper.getToken();

            //  Automatically attach Bearer token to all headers if present
            if (token != null &&
                token != 'null' &&
                token != 'undefined' &&
                token.trim().isNotEmpty) {
              final cleanedToken = token.replaceAll('"', '').trim();
              options.headers['Authorization'] = 'Bearer $cleanedToken';
            }

            //  Extract Token Header for Logging
            final String authHeader = options.headers['Authorization'] != null
                ? "\n Token: ${options.headers['Authorization']}"
                : "\n Token: None";

            //  Format and log outgoing requests
            final String queryParams = options.queryParameters.isNotEmpty
                ? "\n QueryParams: ${jsonEncode(options.queryParameters)}"
                : "";
            final String body = options.data != null
                ? "\n Body: ${options.data is Map || options.data is List ? jsonEncode(options.data) : options.data}"
                : "";

            developer.log(
              " [${options.method}] ${options.uri}$authHeader$queryParams$body",
              name: 'DioFactory.Request',
            );


            return handler.next(options);
          },

          onResponse: (response, handler) {
            //  Pretty-print JSON response payload for debugging
            final String responseString =
            response.data is Map || response.data is List
                ? const JsonEncoder.withIndent('  ').convert(response.data)
                : response.data.toString();

            developer.log(
              " [STATUS ${response.statusCode}] ${response.requestOptions.path}\n Response:\n$responseString",
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

            //  Handle 401 Unauthorized (Session Expiration)
            if (e.response?.statusCode == 401 && !isAuthRequest) {
              developer.log(
                " Session expired (401). Purging token and resetting cache...",
                name: 'DioFactory.Error',
              );

              // Automatically clear stored user data upon expired token
              await CacheHelper.clearSession();

              return handler.reject(e);
            }

            //  Log error details
            developer.log(
              " [ERROR ${e.response?.statusCode ?? 'UNKNOWN'}] ${e.requestOptions.path}\n"
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