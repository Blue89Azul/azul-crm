import 'package:freezed_annotation/freezed_annotation.dart';

part 'jwt_token.freezed.dart';
part 'jwt_token.g.dart';

@freezed
abstract class JwtToken with _$JwtToken {
  const factory JwtToken({
    required String token,
    @JsonKey(name: 'token_type') required String tokenType,
    @JsonKey(name: 'expires_in') required int expiresIn,
  }) = _JwtToken;

  factory JwtToken.fromJson(Map<String, dynamic> json) =>
      _$JwtTokenFromJson(json);
}
