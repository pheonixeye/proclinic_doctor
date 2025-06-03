import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:minisound/engine.dart';
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:proclinic_doctor_windows/providers/notification_provider.dart';
import 'package:proclinic_doctor_windows/providers/theme_changer.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:proclinic_models/proclinic_models.dart';

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
late final MaterialTheme theme;
late final TextTheme textTheme;

void initTheme() {
  textTheme = TextTheme();
  theme = MaterialTheme(textTheme);
}

///init sound package
///
late final Engine engine;

void initSound() {
  engine = Engine();
}
