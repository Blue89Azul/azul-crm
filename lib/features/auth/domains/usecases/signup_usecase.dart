import 'package:azul_crm/features/auth/data/repositories/auth_repository_interface.dart';
import 'package:azul_crm/features/auth/data/repositories/jwt_repository_interface.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:dartz/dartz.dart';

class SignupUseCase {
  final AuthRepositoryInterface _authRepository;
  final JwtRepositoryInterface _jwtRepository;

  SignupUseCase(this._authRepository, this._jwtRepository);

  Future<Either<String, void>> handle(String email, String password, AppRole role) async {
    if (email.isEmpty || password.isEmpty) {
      return left('Email and password are required');
    }
    final result = await _authRepository.signup(email, password, role);

    if(result.isLeft()) {
      return result.map((_){});
    }

    final token = result.getOrElse(() => throw Exception('Failed to get JWT token'));
    return await _jwtRepository.saveToken(token);
  }
}

// Client