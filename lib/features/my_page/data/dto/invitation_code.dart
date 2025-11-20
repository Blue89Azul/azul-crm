import 'package:freezed_annotation/freezed_annotation.dart';

part 'invitation_code.freezed.dart';
part 'invitation_code.g.dart';

@freezed
abstract class InvitationCode with _$InvitationCode {
  const factory InvitationCode({
    required int id,
    required String code,
    @JsonKey(name: 'role_id') required int roleId,
    @JsonKey(name: 'expires_at') required DateTime expiresAt,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'redeemed_at') required DateTime? redeemedAt,
  }) = _InvitationCode;

  factory InvitationCode.fromJson(Map<String, dynamic> json) => _$InvitationCodeFromJson(json);
}