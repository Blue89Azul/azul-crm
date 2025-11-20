import 'package:azul_crm/shared/roles/app_roles.dart';

abstract class InvitationCodeEvent {}

// 招待コード一覧の取得
class InvitationCodeListFetched implements InvitationCodeEvent {
  const InvitationCodeListFetched();
}

// 招待コードの新規発行
class InvitationCodeCreated implements InvitationCodeEvent {
  final AppRole grantedRole;

  const InvitationCodeCreated({required this.grantedRole});
}
