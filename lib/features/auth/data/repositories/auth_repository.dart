import 'package:azul_crm/core/network/app_api_client.dart';
import 'package:azul_crm/core/storage/app_local_storage.dart';
import 'package:azul_crm/features/auth/data/dto/jwt/jwt_token.dart';
import 'package:azul_crm/features/auth/data/dto/user/user.dart';
import 'package:azul_crm/features/auth/domains/services/jwt_token_decoder.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:dartz/dartz.dart';
import 'auth_repository_interface.dart';

const accountKey = "account";

class AuthRepository implements AuthRepositoryInterface {
  final AppApiClient _apiClient;
  final AppLocalStorage _storage;
  final JwtTokenDecoder _jwtTokenDecoder;


  AuthRepository(this._apiClient, this._storage, this._jwtTokenDecoder);

  @override
  Future<Either<String, (JwtToken, User)>> signup(
    String email,
    String password,
    String account,
    String code,
    AppRole role,
  ) async {
    try {

      final requestData = {
        'email': email,
        'password': password,
        'account': account,
        'code': code,
        'role': role.name,
      };

      var result = await _apiClient.post('/signup', data: requestData);
      await _storage.write(key: accountKey, value: result['account']);
      return right((
        JwtToken.fromJson({
          'token': result['jwt']['token'],
          'expiresIn': _jwtTokenDecoder.toExpiredAt(result['jwt']['token'])
        }),
        User.fromJson(result['user']),
      ));
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, (JwtToken, User)>> login(
    String email,
    String password,
    String account,
  ) async {
    try {
      final requestData = {
        'email': email,
        'password': password,
        'account': account,
      };

      var result = await _apiClient.post('/login', data: requestData);
      await _storage.write(key: accountKey, value: result['account']);
      return right((
        JwtToken.fromJson(result['jwt']),
        User.fromJson(result['user']),
      ));
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    try {
      await _apiClient.post('/logout', data: {});
      await _storage.delete(key: accountKey);
    } catch (e) {
      return left(e.toString());
    }
    return right(null);
  }

  @override
  Future<Either<String, String>> getAccount() async {
    late final String account;
    try {
      account = await _storage.read(key: accountKey);
    } catch (e) {
      return left(e.toString());
    }
    return right(account);
  }
}
