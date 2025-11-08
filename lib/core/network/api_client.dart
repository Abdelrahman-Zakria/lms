import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../error/error_handler.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

        // Enhanced logging interceptor
        _dio.interceptors.add(LogInterceptor(
          requestBody: true,
          responseBody: true,
          error: true,
          logPrint: (object) {
            if (object.toString().contains('REQUEST')) {
              developer.log('🚀 API Request:', name: 'API_CLIENT');
              developer.log('   $object', name: 'API_CLIENT');
            } else if (object.toString().contains('RESPONSE')) {
              developer.log('📡 API Response:', name: 'API_CLIENT');
              developer.log('   $object', name: 'API_CLIENT');
            } else if (object.toString().contains('ERROR')) {
              developer.log('❌ API Error:', name: 'API_CLIENT');
              developer.log('   $object', name: 'API_CLIENT');
            } else {
              developer.log('📝 API Log: $object', name: 'API_CLIENT');
            }
          },
        ));
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
      try {
        developer.log('🚀 Making POST request to: $path', name: 'API_CLIENT');
        developer.log('📦 Request data: $data', name: 'API_CLIENT');

        final response = await _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );

        developer.log('✅ Request successful: ${response.statusCode}', name: 'API_CLIENT');
        developer.log('📄 Response data: ${response.data}', name: 'API_CLIENT');

        return response;
      } catch (e) {
        developer.log('❌ Request failed: $e', name: 'API_CLIENT');
        throw ErrorHandler.handleError(e);
      }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
      try {
        developer.log('🚀 Making GET request to: $path', name: 'API_CLIENT');
        developer.log('🔍 Query parameters: $queryParameters', name: 'API_CLIENT');

        final response = await _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
        );

        developer.log('✅ Request successful: ${response.statusCode}', name: 'API_CLIENT');
        developer.log('📄 Response data: ${response.data}', name: 'API_CLIENT');

        return response;
      } catch (e) {
        developer.log('❌ Request failed: $e', name: 'API_CLIENT');
        throw ErrorHandler.handleError(e);
      }
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
    developer.log('🔐 Auth token set: Bearer $token', name: 'API_CLIENT');
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
    developer.log('🔓 Auth token cleared', name: 'API_CLIENT');
  }
}
