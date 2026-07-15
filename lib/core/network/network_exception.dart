import 'package:dio/dio.dart';

class NetworkException implements Exception {
  NetworkException(this.exception);

  final DioException exception;

  String get message {
    final response = exception.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    // Prefer the message returned by your Node server.
    if (data is Map<String, dynamic>) {
      final serverMessage = data['message'];

      if (serverMessage is String && serverMessage.trim().isNotEmpty) {
        return serverMessage;
      }
    }

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The request timed out. Please try again.';

      case DioExceptionType.connectionError:
        return 'Unable to connect to the server. Check your connection.';

      case DioExceptionType.cancel:
        return 'The request was cancelled.';

      case DioExceptionType.badCertificate:
        return 'A secure connection could not be established.';

      case DioExceptionType.badResponse:
        return _messageFromStatusCode(statusCode);

      case DioExceptionType.unknown:
        return 'Something went wrong. Please try again.';
      case DioExceptionType.transformTimeout:
        return 'Time out. Please try again';
    }
  }

  String _messageFromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'The request is invalid.';
      case 401:
        return 'Invalid email or password.';
      case 403:
        return 'You do not have permission to continue.';
      case 404:
        return 'The requested service was not found.';
      case 409:
        return 'This information already exists.';
      case 422:
        return 'Please check the information you entered.';
      case 500:
      case 502:
      case 503:
        return 'The server is temporarily unavailable.';
      default:
        return 'Unable to complete the request. Please try again.';
    }
  }

  @override
  String toString() => message;
}
