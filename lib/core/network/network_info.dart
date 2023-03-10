import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker dataConnectionChecker;
  NetworkInfoImpl(
    this.dataConnectionChecker,
  );
  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;
}
