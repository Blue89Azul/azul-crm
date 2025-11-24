import 'dart:convert';

import 'package:azul_crm/core/storage/app_local_storage.dart';
import 'package:azul_crm/features/auth/data/dto/jwt_token.dart';
import 'package:dartz/dartz.dart';
import 'jwt_repository_interface.dart';

class JwtRepository implements JwtRepositoryInterface {
  static const String _tokenKey = 'jwt';
  final AppLocalStorage _storage;

  JwtRepository(this._storage);

  @override
  Future<Either<String, void>> saveToken(JwtToken token) async {
    try {
      await _storage.write(key: _tokenKey, value: jsonEncode(token.toJson()));
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteToken() async {
    try {
      await _storage.delete(key: _tokenKey);
      return right(null);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, JwtToken?>> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      final JwtToken jwtToken = JwtToken.fromJson(jsonDecode(token));
      return right(jwtToken);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<bool> hasToken() async {
    final result = await getToken();
    return result.fold(
          (_) => false,
          (token) => token != null,
    );
  }
}
