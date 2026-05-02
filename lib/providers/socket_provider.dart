import 'package:flutter/material.dart';
import 'package:proclinic_doctor/logic/socket_server_type.dart';
import 'package:proclinic_doctor/providers/socket_provider_local.dart';
import 'package:proclinic_doctor/providers/socket_provider_web.dart';
import 'package:proclinic_models/proclinic_models.dart';

abstract class PxSocketProvider extends ChangeNotifier {
  PxSocketProvider();

  static PxSocketProvider instance(int docid) {
    return switch (SocketServerType.fromString()) {
      SocketServerType.local => PxSocketProviderLocal(docid: docid),
      SocketServerType.web => PxSocketProviderWeb(docid: docid),
    };
  }

  Future<void> initSocketConnection(BuildContext context);

  void sendDocLogin(BuildContext context);

  void sendSocketMessage(SocketNotificationMessage message);

  void listenToSocket(BuildContext context);

  void disconnect(BuildContext context);

  void parseSocketEvent(dynamic ev, BuildContext context);

  dynamic get socketMessage;

  bool get isConnected;
}
