import 'package:dio/dio.dart';
import '../error/failures.dart';

class ErrorHandler {
  static Failure handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const NetworkFailure('Connection timeout. Please check your internet connection.');
        
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final message = _getErrorMessage(error.response?.data);
          
          if (statusCode == 401) {
            return const AuthFailure('Authentication failed. Please login again.');
          } else if (statusCode == 403) {
            return const AuthFailure('Access denied. You don\'t have permission.');
          } else if (statusCode == 404) {
            return const ServerFailure('Resource not found.');
          } else if (statusCode == 500) {
            return const ServerFailure('Internal server error. Please try again later.');
          } else {
            return ServerFailure(message ?? 'An error occurred', statusCode);
          }
        
        case DioExceptionType.cancel:
          return const NetworkFailure('Request was cancelled.');
        
        case DioExceptionType.connectionError:
          return const NetworkFailure('No internet connection. Please check your network.');
        
        case DioExceptionType.badCertificate:
          return const NetworkFailure('Certificate error. Please check your connection.');
        
        case DioExceptionType.unknown:
          return const NetworkFailure('An unexpected error occurred.');
      }
    } else if (error is FormatException) {
      return const ServerFailure('Invalid data format received from server.');
    } else {
      return ServerFailure('An unexpected error occurred: ${error.toString()}');
    }
  }

  static String? _getErrorMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      if (responseData.containsKey('message')) {
        return responseData['message'].toString();
      } else if (responseData.containsKey('error')) {
        return responseData['error'].toString();
      } else if (responseData.containsKey('errors')) {
        final errors = responseData['errors'];
        if (errors is Map) {
          return errors.values.first.toString();
        } else if (errors is List && errors.isNotEmpty) {
          return errors.first.toString();
        }
      }
    }
    return null;
  }
}
