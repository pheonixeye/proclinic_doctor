import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FontFileProvider extends ChangeNotifier {
  FontFileProvider() {
    _getFontFilePath();
  }
  static late Box<String> box;

  static String? _fontFilePath;
  static String? get fontFilePath => _fontFilePath;
  String? get fontFilePathInstance => _fontFilePath;

  void _getFontFilePath() {
    _fontFilePath = box.get('font_file_path');
    notifyListeners();
  }

  Future<void> setFontFilePath() async {
    final _path = await FilePicker.platform.pickFiles(
      dialogTitle: "Select Font File",
    );
    if (_path != null) {
      box.put('font_file_path', _path.xFiles.first.path);
    }
    _fontFilePath = box.get('font_file_path');
    notifyListeners();
  }
}
