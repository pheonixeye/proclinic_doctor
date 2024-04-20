// ignore_for_file: avoid_print, file_names

import 'dart:io';

import 'package:proclinic_doctor_windows/constants/uuid.dart';

bool checkUUID() {
  ProcessResult uuidresult = Process.runSync(
      'powershell.exe', [r'wmic path win32_computersystemproduct get uuid']);
  String res = uuidresult.stdout.toString();
  print(res);
  var abdo = res.split(' ');
  var mohsen = abdo.where((e) {
    return e.length > 5;
  }).toList();
  String u = mohsen.first.toString();

  var z = u.trim();

  if (z.toString() == UUID.toString()) {
    return true;
  } else {
    return false;
  }
}
