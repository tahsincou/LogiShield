import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logishield/core/network/api_client.dart';
import 'package:logishield/core/providers/providers.dart';
import '../network/dio_client.dart';

final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.read(secureStorageServiceProvider);

  return DioClient(secureStorage).create();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.read(dioProvider));
});
