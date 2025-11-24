import 'package:azul_crm/features/auth/data/dto/jwt_token.dart';
import 'package:dartz/dartz.dart';

abstract interface class JwtRepositoryInterface {
  /// Save JWT token to local storage
  Future<Either<String, void>> saveToken(JwtToken token);

  Future<Either<String, JwtToken?>> getToken();

  Future<Either<String, void>> deleteToken();

  Future<bool> hasToken();
}