import 'dart:convert';

import 'package:azul_crm/core/storage/app_local_storage.dart';
import 'package:azul_crm/features/auth/data/dto/jwt_token.dart';
import 'package:dartz/dartz.dart';
import 'jwt_repository_interface.dart';

class JwtRepository implements JwtRepositoryInterface {
  static const String _tokenKey = 'jwt';
  static const String _tokenSavedAt = 'jwt_saved_at';

  final AppLocalStorage _storage;

  JwtRepository(this._storage);

  @override
  Future<Either<String, void>> saveToken(JwtToken token) async {
    try {
      final jsonString = jsonEncode(token.toJson());
      await _storage.write(key: _tokenKey, value: jsonString);
      await _storage.write(
        key: _tokenSavedAt,
        value: DateTime.now().toIso8601String(),
      );
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

      if (token == null) {
        return left('Token not found');
      }

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
      (error) {
        return false;
      },
      (token) {
        return true;
      },
    );
  }

  @override
  Future<bool> isTokenExpired() async {
    try {
      final savedAtStr = await _storage.read(key: _tokenSavedAt);
      if (savedAtStr == null) {
        return true;
      }

      final tokenResult = await getToken();
      return tokenResult.fold((_) => true, (token) {
        if (token == null) {
          return true;
        }

        final savedAt   = DateTime.parse(savedAtStr);
        final expiresAt = savedAt.add(Duration(seconds: token.expiresIn));
        return DateTime.now().isAfter(expiresAt.subtract(Duration(minutes: 1)));
      });
    } catch (_) {
      return true;
    }
  }
}
