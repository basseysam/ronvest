import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/errors/error.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/local_data/local_data_storage.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_data_source.dart';
import '../model/user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryIml extends AuthRepository {
  AuthRepositoryIml({
    required this.remoteDataSource,
    required this.localDataStorage,
  });

  late final AuthRemoteDataSource remoteDataSource;
  late final LocalDataStorage localDataStorage;

  @override
  Future<Either<Failure, UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(response);
    } catch (e) {
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response!.data != null && e.response!.data != '') {
          return Left(
            ServerFailure(
              message: e.response!.data['error'] ??
                  e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getSavedUserData() async {
    try {
      final savedData = await localDataStorage.getUserData();
      return Right(savedData!);
    } catch (e) {
      return Left(NoEntityFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> clearSavedData() async {
    try {
      await localDataStorage.clear();
      return const Right(true);
    } catch (e) {
      return Left(NoEntityFailure());
    }
  }

  @override
  Future<Either<Failure, String>> signUp({
    required String first_name,
    required String last_name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      Logger().d('response ');
      final response = await remoteDataSource.signUp(
          first_name: first_name,
          last_name: last_name,
          username: username,
          email: email,
          password: password);
      return Right(response);
    } catch (e) {
      Logger().d(e);
      if (e is DioError) {
        if (e.response!.data != null && e.response!.data != '') {
          return Left(
            ServerFailure(
              message: e.response!.data['error'] ??
                  e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      return Left(NoEntityFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> verify({
    required String email,
    required String email_code,
  }) async {
    try {
      final response = await remoteDataSource.verify(
        email: email,
        email_code: email_code,
      );
      return Right(response);
    } catch (e) {
      Logger().d(e);
      if (e is NoInternetException) {
        return Left(NoInternetFailure());
      }
      if (e is DioError) {
        if (e.response!.data != null && e.response!.data != '') {
          return Left(
            ServerFailure(
              message: e.response!.data['error'] ??
                  e.response!.data['message'] ??
                  'Service unavailable, please try again!',
            ),
          );
        } else {
          return const Left(
            ServerFailure(
              message: 'Server error, please try again',
            ),
          );
        }
      }
      return Left(UnknownFailure());
    }
  }
}
