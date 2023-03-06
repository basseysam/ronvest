import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/errors/error.dart';
import '../../../../core/local_data/local_data_storage.dart';
import '../../../../core/network/http_requester.dart';
import '../../../../core/network/network_info.dart';
import '../model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> signUp(
      {required String first_name,
      required String last_name,
      required String username,
      required String email,
      required String password});

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> verify({
    required String email,
    required String email_code,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(
      {required this.networkInfo,
      required this.httpClient,
      required this.localDataStorage});

  late final NetworkInfo networkInfo;
  late final HttpServiceRequester httpClient;
  late final LocalDataStorage localDataStorage;



  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      final body = {'username': email, 'password': password};
      final response = await httpClient.post(endpoint: 'login', body: body);

      final userData = UserModel.fromMap(((response.data
          as Map<String, dynamic>)['data'] as Map<String, dynamic>));
      await localDataStorage.saveToken(
        "${((response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>)['access_token']}",
      );
      await localDataStorage.saveUserData(userData.toJson());
      return userData;
    }
    throw NoInternetException();
  }

  @override
  Future<UserModel> verify(
      {required String email, required String email_code}) async {
    if (await networkInfo.isConnected) {
      final body = {'email': email, 'email_code': email_code};
      final response =
          await httpClient.post(endpoint: 'activate_account', body: body);
      Logger().d(response.data);
      final userData = UserModel.fromMap(((response.data
      as Map<String, dynamic>)['data'] as Map<String, dynamic>));
      await localDataStorage.saveToken(
        "${((response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>)['access_token']}",
      );
      await localDataStorage.saveUserData(userData.toJson());
      FirebaseFirestore.instance.collection('users').add(userData.toMap()).then((value){
        print("collection created");
      }).catchError((_){
        print("an error occured");
      });
      return userData;
    }
    throw NoInternetException();
  }

  @override
  Future<String> signUp(
      {required String first_name,
      required String last_name,
      required String username,
      required String email,
      required String password}) async {
    if (await networkInfo.isConnected) {
      final body = {
        'first_name': first_name,
        'last_name': last_name,
        'username': username,
        'email': email,
        'password': password
      };

      final response = await httpClient.post(endpoint: 'register', body: body);

      final userData = response.data['data']['user_info']['email_code'];


      Logger().d(userData);
      return userData;
    } else {
      throw NoInternetException();
    }
  }
}
