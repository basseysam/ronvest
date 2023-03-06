import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class ClearSavedDataUsecase extends UseCase<bool, NoParams> {
  ClearSavedDataUsecase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return authRepository.clearSavedData();
  }
}
