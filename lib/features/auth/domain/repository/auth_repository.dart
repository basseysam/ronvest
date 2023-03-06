import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> signUp(
      {required String first_name,
      required String last_name,
      required String username,
      required String email,
      required String password});

  Future<Either<Failure, UserEntity>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> getSavedUserData();

  Future<Either<Failure, bool>> clearSavedData();

  Future<Either<Failure, UserEntity>> verify({
    required String email,
    required String email_code,
  });
}
