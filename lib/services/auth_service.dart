import '../constants/typedef_app.dart';
import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository authRepository;
  AuthService(this.authRepository);

  ResultFuture<Map<String, dynamic>> login({
    required String cardId,
    required String cargoUuid,
  }) async {
    return await authRepository.login(
      cardId,
      cargoUuid,
    );
  }

  ResultFuture<bool> logout() async {
    return await authRepository.logout();
  }
}
