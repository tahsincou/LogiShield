import 'package:logishield/core/network/api_client.dart';
import 'package:logishield/features/auth/data/model/user_model.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/config/environment.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/services/supabase_service.dart';
import '../dto/login_request.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserModel> login(LoginRequest request) async {
    if (AppConfig.environment == Environment.staging) {
      final result = await SupabaseService.client.auth.signInWithPassword(
        email: request.email,
        password: request.password,
      );

      final session = result.session;
      final user = result.user;

      if (session == null || user == null) {
        throw Exception('Login failed');
      }

      return UserModel(
        id: 1,
        name: user.email ?? '',
        email: user.email ?? '',
        token: session.accessToken,
      );
    }

    // Existing Node login
    final response = await apiClient.post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: request.toJson(),
    );

    return UserModel.fromJson(response.data!);
  }
}
