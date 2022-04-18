
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageProvider extends ChangeNotifier{
  late PackageInfo packageInfo;
  String appVersion = '1.0';

  void getVersion()async{
    packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.buildNumber;
    notifyListeners();
  }
}