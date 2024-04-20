import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class NetworkSettings {
  NetworkSettings._();

  factory NetworkSettings._instance() => NetworkSettings._();

  static NetworkSettings get instance => NetworkSettings._instance();

  static final Future<Box> _box = Hive.openBox('network');

  static Box? storage;

  static Future<void> init() async {
    Hive.init('assets\\network.hive');
    storage = await _box;
  }

  Future<void> adddatatonetwork({
    required String ip,
    required String port,
  }) async {
    if (storage != null) {
      await storage!.put('ip', ip);
      await storage!.put('port', port);
    }
  }

  Future<void> resetnetwork() async {
    if (storage != null) {
      await storage!.put('ip', 'localhost');
      await storage!.delete('port');
    }
  }

  Future<String?> getIpAddress() async {
    if (storage != null) {
      final ip = await storage?.get('ip') as String?;
      if (kDebugMode) {
        print(ip);
      }
      return ip;
    }
    return null;
  }
}
