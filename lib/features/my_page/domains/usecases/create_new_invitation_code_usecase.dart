import 'package:azul_crm/features/my_page/data/dto/invitation_code.dart';
import 'package:azul_crm/features/my_page/data/repositories/invitation_code_repository_interface.dart';
import 'package:dartz/dartz.dart';

class CreateNewInvitationCodeUseCase {
  final InvitationCodeRepositoryInterface _repository;

  CreateNewInvitationCodeUseCase(this._repository);

  Future<Either<String, InvitationCode>> call() async {
    final result = await _repository.createNewCode();

    if (result.isLeft()) {
      return Left(result.toString());
    }

    final newInvitationCode = result.getOrElse(
      () => throw Exception('Failed to create a new invitation code'),
    );
    return Right(newInvitationCode);
  }
}
