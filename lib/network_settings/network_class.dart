import 'dart:core';

import 'package:hive/hive.dart';

class NetworkSettings {
  const NetworkSettings._();

  static const NetworkSettings _instance = NetworkSettings._();

  factory NetworkSettings.instance() {
    return _instance;
  }

  static Box? storage;

  static Future<void> init() async {
    Hive.init('assets\\network.hive');
    storage = await Hive.openBox('network');
  }

  Future<void> adddatatonetwork({
    required String ip,
    required String port,
  }) async {
    await storage?.put('ip', ip);
    await storage?.put('port', port);
  }

  Future<void> resetnetwork() async {
    await storage?.put('ip', 'localhost');
    await storage?.delete('port');
  }

  Future<String?> getIpAddress() async {
    final ip = await storage?.get('ip') as String?;
    print(ip);
    return ip;
  }
}
