import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class VerifyUsecase extends UseCase<UserEntity, VerifyParams> {
  VerifyUsecase({required this.authRepository});

  late final AuthRepository authRepository;

  Future<Either<Failure, UserEntity>> call(VerifyParams params) {
    return authRepository.verify(
      email: params.email,
      email_code: params.email_code,);
  }
}

class VerifyParams extends Equatable {
  const VerifyParams({
    required this.email,
    required this.email_code,
  });

  final String email;
  final String email_code;

  @override
  List<Object?> get props => [
    email,
    email_code,
  ];
}
