import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';

class PxSocketProvider extends ChangeNotifier {
  late final Socket? _socket;
  final int docid;
  final NetworkSettings _networkSettings = NetworkSettings.instance();

  PxSocketProvider({required this.docid});

  Future<void> initSocketConnection() async {
    try {
      _socket = await Socket.connect(
        InternetAddress(await _networkSettings.getIpAddress() ?? ""),
        6789,
      );
      print(docid);
    } catch (e) {
      _socket = null;
      print('socket is null');
    }
    notifyListeners();
  }

  bool _isSocketConnected() {
    if (_socket != null) {
      return true;
    }
    return false;
  }

  bool get isSocketConnected => _isSocketConnected();

  void sendDocId() {
    if (_socket != null) {
      _socket!.write(docid);
    }
  }
}
