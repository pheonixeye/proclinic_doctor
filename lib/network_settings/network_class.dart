import 'dart:core';

import 'package:localstorage/localstorage.dart';

class NetworkSettings {
  NetworkSettings();
  static LocalStorage storage = LocalStorage('network.json');
  static String? ip;
  static String? port;
  Future adddatatonetwork({required String ip, required String port}) async {
    await storage.ready;
    await storage.setItem('ip', ip);
    await storage.setItem('port', port);
  }

  Future resetnetwork() async {
    await storage.ready;
    await storage.setItem('ip', 'localhost');
    await storage.deleteItem('port');
  }
}
