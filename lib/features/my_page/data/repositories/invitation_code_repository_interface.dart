import 'package:azul_crm/features/my_page/data/dto/invitation_code.dart';
import 'package:dartz/dartz.dart';

abstract interface class InvitationCodeRepositoryInterface {
  Future<Either<String, List<InvitationCode>>> fetchCodeList(int pageNumber);
  Future<Either<String, InvitationCode>> createNewCode();
}