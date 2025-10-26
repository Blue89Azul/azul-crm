import 'package:azul_crm/features/auth/data/dto/jwt_token.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepositoryInterface {
  Future<Either<String, JwtToken>> signup(String email, String password, AppRole role);
}