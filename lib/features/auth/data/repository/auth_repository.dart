import 'package:logishield/features/auth/data/dto/login_request.dart';
import 'package:logishield/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<User> login(LoginRequest request);

  Future<void> logout();

  Future<User?> currentUser();
}
