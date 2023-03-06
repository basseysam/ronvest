import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class LoginUsecase extends UseCase<UserEntity, LoginParams> {
  LoginUsecase({required this.authRepository});

  late final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return authRepository.signIn(
        email: params.email,
        password: params.password,);
  }
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
