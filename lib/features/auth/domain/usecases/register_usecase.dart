import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

@lazySingleton
class RegisterUsecase extends UseCase<String, RegisterParams> {
  RegisterUsecase({required this.authRepository});

  late final AuthRepository authRepository;

  @override
  Future<Either<Failure, String>> call(RegisterParams params) {
    return authRepository.signUp(
      first_name: params.first_name,
      last_name: params.last_name,
      username: params.username,
      email: params.email,
      password: params.password,);
  }
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.first_name,
    required this.last_name,
    required this.username,
    required this.email,
    required this.password,
  });

  final String first_name;
  final String last_name;
  final String username;
  final String email;
  final String password;

  @override
  List<Object?> get props => [
    first_name,
    last_name,
    username,
    email,
    password,
  ];
}
