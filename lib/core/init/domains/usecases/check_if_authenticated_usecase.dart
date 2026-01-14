import 'package:azul_crm/features/auth/data/repositories/jwt_repository_interface.dart';

class CheckIfAuthenticatedUsecase {
  final JwtRepositoryInterface _repository;

  const CheckIfAuthenticatedUsecase(this._repository);

  Future<bool> call() async {
    final isTokenExists = await _repository.isTokenExpired();
    final hasToken      = await _repository.hasToken();
    return hasToken && !isTokenExists;
  }
}
