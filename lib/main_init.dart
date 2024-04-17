import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:json_theme/json_theme.dart';
import 'package:minisound/minisound.dart' as minisound;
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:proclinic_doctor_windows/providers/notification_provider.dart';
import 'package:proclinic_doctor_windows/providers/theme_changer.dart';
import 'package:proclinic_models/proclinic_models.dart';

///init sockets
///
// late final Socket socket;

// Future<void> _initSocket() async {
//   //todo: EXPAND ON IT
//   //todo: get network address from hive
//   //todo: define socket on login not app initiation
//   //todo: send login ack to reception with doctor id that logged in
//   //todo: implement socket holder class
//   //todo: add notification holder class
//   socket = await Socket.connect(InternetAddress('192.168.0.88'), 6789);
//   socket.write("Hello from the other side !");
// }

///init hive package
///
Future<void> initHive() async {
  //init theme box
  Hive.init('assets\\themestore.hive');
  ThemeChanger.box = await Hive.openBox('themestore');
  //init notification box
  Hive
    ..init('assets\\notifications.hive')
    ..registerAdapter(AppNotificationAdapter());
  PxAppNotifications.box = await Hive.openBox<AppNotification>('notifications');
  //init network settings
  await NetworkSettings.init();
}

///init themes
///
late final ThemeData lightTheme;
late final ThemeData darkTheme;
Future<void> initThemes() async {
  final themeStringLight =
      await rootBundle.loadString('assets/themes/theme_light.json');
  final themeJsonLight = jsonDecode(themeStringLight);
  lightTheme = ThemeDecoder.decodeThemeData(themeJsonLight)!;
  final themeStringDark =
      await rootBundle.loadString('assets/themes/theme_dark.json');
  final themeJsonDark = jsonDecode(themeStringDark);
  darkTheme = ThemeDecoder.decodeThemeData(themeJsonDark)!;
}

///init sound package
///
late final minisound.Engine engine;

void initSound() {
  engine = minisound.Engine();
}
