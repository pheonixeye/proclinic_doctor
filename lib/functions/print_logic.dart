import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPrinter extends ChangeNotifier {
  PdfPrinter() {
    _getStoragePath();
  }

  static Future<void> init() async {
    Hive.init('assets\\path.hive');
    box = await Hive.openBox('path');
  }

  void _getStoragePath() {
    _path = box?.get('path');
    notifyListeners();
  }

  static Box? box;

  Future<void> setStoragePath() async {
    final dir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: "Select Print Files Save Directory",
    );
    if (dir != null) {
      box?.put('path', dir);
    }
    _path = box?.get('path');
    notifyListeners();
  }

  String? _path;
  String? get path => _path;

  Future<bool> generatePdfFile(String img) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(
      File(img).readAsBytesSync(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        build: (pw.Context context) {
          return pw.Image(
            image,
            dpi: 200,
          );
        },
      ),
      index: 0,
    );

    final file = File("$img.pdf");
    _pdfFile = await file.writeAsBytes(await pdf.save());

    return true;
  }

  File? _pdfFile;
  File? get pdfFile => _pdfFile;

  Future<void> printPdfFile(BuildContext context) async {
    final path = _pdfFile?.absolute.path;
    if (_pdfFile != null && path != null) {
      final printer = await Printing.pickPrinter(context: context);
      await Printing.directPrintPdf(
          printer: printer!,
          onLayout: (format) async {
            return _pdfFile!.readAsBytes();
          });
    }
  }
}
