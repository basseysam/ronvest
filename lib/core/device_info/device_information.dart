import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeviceInformation {
  final DeviceInfoPlugin? deviceInfoPlugin;
  DeviceInformation({
    required this.deviceInfoPlugin,
  });

  Future<String> getDeviceName() async {
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfoPlugin!.androidInfo;
      return '${androidInfo.manufacturer}  ${androidInfo.model}';
    }

    var iosInfo = await deviceInfoPlugin!.iosInfo;
    return '${iosInfo.utsname.machine} ${iosInfo.model}';
  }

  Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfoPlugin!.androidInfo;
      return androidInfo.androidId;
    }

    var iosInfo = await deviceInfoPlugin!.iosInfo;
    return iosInfo.identifierForVendor;
  }
}
