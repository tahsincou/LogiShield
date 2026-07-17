import 'package:dio/dio.dart';
import 'package:logishield/core/config/environment.dart';
import 'package:logishield/core/network/interceptors/auth_interceptor.dart';
import 'package:logishield/core/network/interceptors/error_interceptor.dart';
import 'package:logishield/core/network/interceptors/logging_interceptor.dart';
import 'package:logishield/core/storage/secure_storage_service.dart';
import '../config/app_config.dart';
import '../config/supabse_config.dart';

class DioClient {
  final SecureStorageService secureStorage;

  DioClient(this.secureStorage);

  Dio create() {
    final headers = <String, dynamic>{'Content-Type': 'application/json'};

    if (AppConfig.environment == Environment.staging) {
      headers['apikey'] = SupabaseConfig.publishableKey;
    }

    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        headers: headers,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(secureStorage),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);

    return dio;
  }
}
