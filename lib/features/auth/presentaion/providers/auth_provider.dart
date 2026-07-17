import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logishield/core/providers/providers.dart';
import 'package:logishield/features/auth/domain/usecases/check_login_usecase.dart';
import 'package:logishield/features/auth/domain/usecases/login_usecase.dart';
import 'package:logishield/features/auth/domain/usecases/logout_usecase.dart';

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.watch(authRepositoryProvider));
});

final checkLoginUseCaseProvider = Provider<CheckLoginUseCase>((ref) {
  return CheckLoginUseCase(ref.watch(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.watch(authRepositoryProvider));
});
