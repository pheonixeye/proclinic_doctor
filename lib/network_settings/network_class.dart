import 'dart:core';

import 'package:hive/hive.dart';

class NetworkSettings {
  const NetworkSettings();

  static Box? storage;

  static Future<void> init() async {
    Hive.init('assets\\network.hive');
    storage = await Hive.openBox('network');
  }

  Future<void> adddatatonetwork(
      {required String ip, required String port}) async {
    await storage?.put('ip', ip);
    await storage?.put('port', port);
  }

  Future<void> resetnetwork() async {
    await storage?.put('ip', 'localhost');
    await storage?.delete('port');
  }
}
