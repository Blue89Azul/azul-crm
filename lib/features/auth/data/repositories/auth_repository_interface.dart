import 'package:azul_crm/features/auth/data/dto/jwt/jwt_token.dart';
import 'package:azul_crm/features/auth/data/dto/user/user.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepositoryInterface {
  Future<Either<String, (JwtToken, User)>> signup(
    String email,
    String password,
    String account,
    String code,
    AppRole role,
  );

  Future<Either<String, (JwtToken, User)>> login(
    String email,
    String password,
    String account,
  );

  Future<Either<String, void>> logout();

  Future<Either<String, String>> getAccount();
}
