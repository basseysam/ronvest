import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info_plus/package_info_plus.dart';

@module
abstract class RegisterModule {
  Dio get dio {
    final dio = Dio();
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print, // retry count (optional)
        retryDelays: const [
          Duration(seconds: 1), // wait 1 sec before first retry
          Duration(seconds: 2), // wait 2 sec before second retry
          Duration(seconds: 3), // wait 3 sec before third retry
        ],
      ),
    );
    return dio;
  }
  Connectivity get connectivity => Connectivity();
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker();
}
