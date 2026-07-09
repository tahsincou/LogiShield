import 'package:logishield/features/auth/data/model/user_model.dart';

import '../dto/login_request.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginRequest request);
}
