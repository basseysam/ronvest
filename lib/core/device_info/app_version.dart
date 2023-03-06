import 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  final PackageInfo packageInfo;
  AppVersion({
    required this.packageInfo,
  });

  String call() {
    return packageInfo.version;
  }
}
