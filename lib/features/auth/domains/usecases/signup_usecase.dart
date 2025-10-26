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

    var token = await _authRepository.signup(email, password, role);
    await _jwtRepository.saveJwt(token as String);

    return right(null);
  }
}

// Client