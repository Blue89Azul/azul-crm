import 'package:azul_crm/core/network/app_api_client.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AppApiClient _apiClient;

  AuthRepository(this._apiClient);

  // JwtDTOを返す
  @override
  Future<Either<String, Map<String, dynamic>>> signup(
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
      print(result);
      return right(result);
    } catch (e) {
      return left(e.toString());
    }
  }
}

/// _apiClientを引数に渡すときにヘッダーにauthを乗っけるか、無しでもいいかを決めて送りたい。
///
