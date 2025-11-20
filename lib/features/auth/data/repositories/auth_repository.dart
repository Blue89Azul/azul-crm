import 'package:azul_crm/core/network/app_api_client.dart';
import 'package:azul_crm/features/auth/data/dto/jwt_token.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:dartz/dartz.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AppApiClient _apiClient;

  AuthRepository(this._apiClient);

  @override
  Future<Either<String, JwtToken>> signup(
    String email,
    String password,
    AppRole role,
  ) async {
    try {

      final requestData = {
        'email': email,
        'password': password,
        'role': role.name,
      };

      var result = await _apiClient.post('/signup', data: requestData);

      return right(JwtToken.fromJson(result));
    } catch (e) {
      return left(e.toString());
    }
  }
}

