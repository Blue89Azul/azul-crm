import 'package:azul_crm/core/network/app_api_client.dart';
import 'package:azul_crm/features/my_page/data/dto/invitation_code.dart';
import 'package:azul_crm/features/my_page/data/repositories/invitation_code_repository_interface.dart';
import 'package:azul_crm/shared/roles/app_roles.dart';
import 'package:dartz/dartz.dart';

class InvitationCodeRepository implements InvitationCodeRepositoryInterface {
  final String _endPoint = "/invitation_codes";
  final AppApiClient _apiClient;

  const InvitationCodeRepository(this._apiClient);

  @override
  Future<Either<String, InvitationCode>> createNewCode() async {
    try {
      final Map<String, dynamic> fetchedData = await _apiClient.post(
        _endPoint,
        data: {'role': AppRole.member},
      );

      final result = InvitationCode.fromJson(fetchedData['data'][0]);

      return right(result);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<InvitationCode>>> fetchCodeList(
    int pageNumber,
  ) async {
    try {
      final Map<String, dynamic> fetchedData = await _apiClient.get(
        _endPoint,
        queryParameters: {'page': pageNumber},
      );

      final List<InvitationCode> result = [
        ...?(fetchedData['data'] as List<dynamic>?)?.map((json) =>
            InvitationCode.fromJson(json as Map<String, dynamic>)),
      ];

      return right(result);
    } catch (e) {
      return left(e.toString());
    }
  }
}
