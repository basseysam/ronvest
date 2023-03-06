import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../features/auth/data/model/user_model.dart';

abstract class LocalDataStorage {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<String?> getRefreshToken();
  Future<void> saveRefreshToken(String token);
  Future<UserModel?> getUserData();
  Future<void> saveUserData(String userJson);
  Future<void> saveDashboardData(String dashboardJson);
  Future<void> clear();
  Future<void> savePref(String key, dynamic value);
  Future<dynamic> getPref(String key);
}

@LazySingleton(as: LocalDataStorage)
class LocalDataStorageImpl implements LocalDataStorage {
  LocalDataStorageImpl(this.storage);

  final FlutterSecureStorage storage;
  @override
  Future<void> clear() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: accessToken);
  }

  @override
  Future<String?> getRefreshToken() {
    return storage.read(key: refreshToken);
  }

  @override
  Future<void> saveToken(String token) {
    return storage.write(key: accessToken, value: token);
  }

  @override
  Future<void> saveRefreshToken(String token) {
    return storage.write(key: refreshToken, value: token);
  }

  @override
  Future<void> saveUserData(String userJson) {
    return storage.write(key: userData, value: userJson);
  }

  @override
  Future<void> saveDashboardData(String dashboardJson) {
    return storage.write(key: dashboardData, value: dashboardJson);
  }

  @override
  Future<UserModel?> getUserData() async{
    final result =  await storage.read(key: userData);
    if(result != null){
      final user = UserModel.fromJson(result);
      return user;
    }
    return null;
  }

  @override
  Future<void> savePref(String key, dynamic value) {
    return storage.write(key: key, value: value.toString());
  }

  @override
  Future getPref(String key) async{
    final res = await storage.read(key: key);
    return res;
  }

/*@override
  Future<DashboardModel> getDashboardData() async {
    final json = await storage.read(key: dashboardData);
    if (json != null) {
      return DashboardModel.fromJson(json);
    } else {
      throw NoDataException();
    }
  }*/
}

const String accessToken = 'access_token';
const String refreshToken = 'refreshToken';
const String userData = 'userData';
const String dashboardData = 'dashboardData';
const String onboarded = 'onboarded';
