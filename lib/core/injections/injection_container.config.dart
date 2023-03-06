// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity/connectivity.dart' as _i3;
import 'package:device_info/device_info.dart' as _i4;
import 'package:dio/dio.dart' as _i6;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i9;
import 'package:package_info_plus/package_info_plus.dart' as _i12;

import '../../features/auth/data/datasource/auth_data_source.dart' as _i13;
import '../../features/auth/data/repository/auth_repository_impl.dart' as _i15;
import '../../features/auth/domain/repository/auth_repository.dart' as _i14;
import '../../features/auth/domain/usecases/clear_saved_data_usecase.dart'
    as _i16;
import '../../features/auth/domain/usecases/get_saved_data_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i18;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i19;
import '../../features/auth/domain/usecases/verify_usecase.dart' as _i20;
import '../../features/auth/presentation/provider/auth_provider.dart' as _i21;
import '../device_info/device_information.dart' as _i5;
import '../local_data/local_data_storage.dart' as _i10;
import '../network/http_requester.dart' as _i8;
import '../network/network_info.dart' as _i11;
import 'register_module.dart' as _i22; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.Connectivity>(() => registerModule.connectivity);
  gh.factory<_i4.DeviceInfoPlugin>(() => registerModule.deviceInfoPlugin);
  gh.lazySingleton<_i5.DeviceInformation>(() =>
      _i5.DeviceInformation(deviceInfoPlugin: get<_i4.DeviceInfoPlugin>()));
  gh.factory<_i6.Dio>(() => registerModule.dio);
  gh.factory<_i7.FlutterSecureStorage>(
      () => registerModule.flutterSecureStorage);
  gh.lazySingleton<_i8.HttpServiceRequester>(
      () => _i8.HttpServiceRequester(dio: get<_i6.Dio>()));
  gh.factory<_i9.InternetConnectionChecker>(
      () => registerModule.internetConnectionChecker);
  gh.lazySingleton<_i10.LocalDataStorage>(
      () => _i10.LocalDataStorageImpl(get<_i7.FlutterSecureStorage>()));
  gh.lazySingleton<_i11.NetworkInfo>(
      () => _i11.NetworkInfoImpl(get<_i9.InternetConnectionChecker>()));
  gh.factoryAsync<_i12.PackageInfo>(() => registerModule.packageInfo);
  gh.lazySingleton<_i13.AuthRemoteDataSource>(
      () => _i13.AuthRemoteDataSourceImpl(
            networkInfo: get<_i11.NetworkInfo>(),
            httpClient: get<_i8.HttpServiceRequester>(),
            localDataStorage: get<_i10.LocalDataStorage>(),
          ));
  gh.lazySingleton<_i14.AuthRepository>(() => _i15.AuthRepositoryIml(
        remoteDataSource: get<_i13.AuthRemoteDataSource>(),
        localDataStorage: get<_i10.LocalDataStorage>(),
      ));
  gh.lazySingleton<_i16.ClearSavedDataUsecase>(() =>
      _i16.ClearSavedDataUsecase(authRepository: get<_i14.AuthRepository>()));
  gh.lazySingleton<_i17.GetSavedDataUsecase>(() =>
      _i17.GetSavedDataUsecase(authRepository: get<_i14.AuthRepository>()));
  gh.lazySingleton<_i18.LoginUsecase>(
      () => _i18.LoginUsecase(authRepository: get<_i14.AuthRepository>()));
  gh.lazySingleton<_i19.RegisterUsecase>(
      () => _i19.RegisterUsecase(authRepository: get<_i14.AuthRepository>()));
  gh.lazySingleton<_i20.VerifyUsecase>(
      () => _i20.VerifyUsecase(authRepository: get<_i14.AuthRepository>()));
  gh.lazySingleton<_i21.AuthProvider>(() => _i21.AuthProvider(
        loginUsecase: get<_i18.LoginUsecase>(),
        getSavedDataUsecase: get<_i17.GetSavedDataUsecase>(),
        clearSavedDataUsecase: get<_i16.ClearSavedDataUsecase>(),
        verifyUsecase: get<_i20.VerifyUsecase>(),
        registerUsecase: get<_i19.RegisterUsecase>(),
      ));
  return get;
}

class _$RegisterModule extends _i22.RegisterModule {}
