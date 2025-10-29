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
}