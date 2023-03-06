import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class GetSavedDataUsecase extends UseCase<UserEntity, NoParams> {
  GetSavedDataUsecase({
    required this.authRepository
});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return authRepository.getSavedUserData();
  }
}