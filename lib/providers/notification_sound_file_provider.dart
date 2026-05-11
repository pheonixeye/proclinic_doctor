import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NotificationSoundFileProvider extends ChangeNotifier {
  NotificationSoundFileProvider() {
    _getSoundFilePath();
  }
  static late Box<String> box;

  static String? _soundFilePath;
  static String? get soundFilePath => _soundFilePath;
  String? get soundFilePathInstance => _soundFilePath;

  void _getSoundFilePath() {
    _soundFilePath = box.get('sound_file_path');
    notifyListeners();
  }

  Future<void> setSoundFilePath() async {
    final _path = await FilePicker.platform.pickFiles(
      dialogTitle: "Select Sound File",
    );
    if (_path != null) {
      box.put('sound_file_path', _path.xFiles.first.path);
    }
    _soundFilePath = box.get('sound_file_path');
    notifyListeners();
  }
}
