import 'package:azul_crm/features/auth/data/repositories/auth_repository_interface.dart';
import 'package:azul_crm/features/auth/data/repositories/jwt_repository_interface.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final AuthRepositoryInterface _authRepository;
  final JwtRepositoryInterface _jwtRepository;

  LoginUseCase(this._jwtRepository, this._authRepository);

  Future<Either<String, void>> call(String email, String password) async {
    final result = await _authRepository.login(email, password);

    if(result.isLeft()) {
      return result.map((_){});
    }

    final token = result.getOrElse(() => throw Exception('Failed to get JWT token'));
    return await _jwtRepository.saveToken(token);
  }
}