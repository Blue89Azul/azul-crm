import 'package:azul_crm/features/my_page/data/dto/invitation_code.dart';
import 'package:azul_crm/features/my_page/data/repositories/invitation_code_repository.dart';
import 'package:dartz/dartz.dart';

class FetchInvitationCodeListUseCase {
  final int pageNumber;
  final InvitationCodeRepository _repository;

  FetchInvitationCodeListUseCase(this._repository, {this.pageNumber = 1});

  Future<Either<String, List<InvitationCode>>> call() async {
    final result = await _repository.fetchCodeList(pageNumber);

    if (result.isLeft()) {
      return Left(result.toString());
    }

    final List<InvitationCode> invitationCodeList = result.getOrElse(
      () => throw Exception('Failed to fetch invitation code list.'),
    );
    return Right(invitationCodeList);
  }
}
