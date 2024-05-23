import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:proclinic_doctor_windows/providers/notification_provider.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class PxSocketProvider extends ChangeNotifier {
  Socket? _socket;
  final int docid;

  PxSocketProvider({
    required this.docid,
  });

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Future<void> initSocketConnection(BuildContext context) async {
    try {
      _socket = await Socket.connect(
        InternetAddress(await NetworkSettings.instance.getIpAddress() ?? ""),
        6789,
      );
      _isConnected = true;
      if (kDebugMode) {
        print(docid);
      }

      notifyListeners();
      if (context.mounted) {
        sendDocLogin(context);
      }
    } catch (e) {
      _socket = null;
      _isConnected = false;
      if (kDebugMode) {
        print(e.toString());
        print('socket not connected.');
      }
      notifyListeners();
    }
    notifyListeners();
  }

  // void sendDocId() {
  //   if (_socket != null) {
  //     _socket!.write(docid);
  //   }
  // }

  void sendDocLogin(BuildContext context) {
    final doctor = context.read<PxSelectedDoctor>().doctor!;
    final tr = Tr(
      e: doctor.docnameEN,
      a: doctor.docnameAR,
    );
    final msg = SocketNotificationMessage.doctorLogin(docid, tr);
    _socket?.write(msg.toJson());
  }

  void sendSocketMessage(SocketNotificationMessage message) {
    _socket?.write(message.toJson());
  }

  List<int>? _socketMessage;
  List<int>? get socketMessage => _socketMessage;

  void listenToSocket(BuildContext context) {
    _socket?.asBroadcastStream().listen(
      (event) {
        _socketMessage = event;
        parseSocketEvent(event, context);
      },
      onDone: () {
        _socket = null;
        _isConnected = _socket == null;
        notifyListeners();
      },
      onError: (e) {
        _socket = null;
        _isConnected = _socket == null;
        notifyListeners();
      },
      cancelOnError: true,
    );
  }

  void disconnect(BuildContext context) {
    final doctor = context.read<PxSelectedDoctor>().doctor!;
    final tr = Tr(
      e: doctor.docnameEN,
      a: doctor.docnameAR,
    );
    final msg = SocketNotificationMessage.doctorLogout(docid, tr);

    _socket?.write(msg.toJson());
    _socket?.close();
    _socket = null;
    _isConnected = false;
    notifyListeners();
  }

  void parseSocketEvent(List<int>? event, BuildContext context) async {
    if (event != null) {
      final String strMessage = utf8.decode(_socketMessage!);
      final msg = SocketNotificationMessage.fromJson(strMessage);
      //todo: fire notification
      await context.read<PxAppNotifications>().addNotification(
          AppNotification.fromSocketNotificationMessage(msg), context);
      if (msg.type == MessageType.newVisit) {
        if (context.mounted) {
          await context.read<PxVisits>().fetchVisits(
                type: QueryType.Today,
              );
          if (kDebugMode) {
            print("fetching today visits - new visit");
          }
        }
      }
      if (msg.type == MessageType.visitUpdatedreception) {
        if (context.mounted) {
          await context.read<PxVisits>().fetchVisits(
                type: QueryType.Today,
              );

          if (kDebugMode) {
            print("fetching today visits - visit update reception");
          }
        }
      }
    }
  }
}
