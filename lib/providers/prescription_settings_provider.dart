import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:pdf/pdf.dart';
import 'package:proclinic_doctor/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor/providers/font_file_provider.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:pdf/widgets.dart' as pw;

class PxPrescriptionSettings extends ChangeNotifier {
  final int docId;

  PxPrescriptionSettings({required this.docId});

  PrescriptionSettings? _settings;
  PrescriptionSettings? get settings => _settings;

  void onLogout() {
    _settings = null;
    notifyListeners();
  }

  Future<void> get init => _checkIfDoctorSettingsExists();

  Future<void> _checkIfDoctorSettingsExists() async {
    final result = await Database.prescriptionSettings.findOne(
      where.eq('docId', docId),
    );
    if (result == null) {
      //todo: perform add first time
      await Database.prescriptionSettings.insertOne(
        PrescriptionSettings.create(docId).toJson(),
      );
      //todo: assign data
      final newResult = await Database.prescriptionSettings.findOne(
        where.eq('docId', docId),
      );
      _settings = PrescriptionSettings.fromJson(newResult!);
      notifyListeners();
      if (kDebugMode) {
        print(
          'PxPrescriptionSetting()._checkIfDoctorSettingsExists(create&assign)',
        );
      }
    } else {
      //todo: assign data
      _settings = PrescriptionSettings.fromJson(result);
      notifyListeners();
      if (kDebugMode) {
        print('PxPrescriptionSetting()._checkIfDoctorSettingsExists(assign)');
      }
    }
  }

  Future<void> updatePrescriptionSettings({
    required String key,
    required dynamic value,
  }) async {
    await Database.prescriptionSettings.updateOne(
      where.eq("_id", _settings?.id),
      {
        r'$set': {key: value},
      },
    );
    if (kDebugMode) {
      print('PxPrescriptionSetting().updatePrescriptionSettings($key)');
    }
    await init;
  }

  Future<void> updatePrescriptionData({
    required PositionedDataItem newData,
  }) async {
    await Database.prescriptionSettings.updateOne(
      where.eq("_id", _settings?.id),
      {
        r'$set': {
          "data"
              "."
              "${newData.type.name}": newData
              .toJson(),
        },
      },
    );
    if (kDebugMode) {
      print(
        'PxPrescriptionSetting().updatePrescriptionData(${newData.type.name})',
      );
    }
    await init;
  }

  static const Map<String, PdfPageFormat> _pageFormats = {
    // "a4": PdfPageFormat.a4,
    "a5": PdfPageFormat.a5,
  };

  Map<String, PdfPageFormat> get pageFormats => _pageFormats;

  //TODO: change at build time
  static final Uint8List fontData = File(
    FontFileProvider.box.get('font_file_path')!,
  ).readAsBytesSync();
  static final ttf = pw.Font.ttf(fontData.buffer.asByteData());
  final style = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    fontSize: 10,
  );
  final titleStyle = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1,
    fontSize: 24,
  );

  File? _pngPrescription;
  File? get pdfPrescription => _pngPrescription;

  FutureOr<Uint8List> _buildPdf() {
    if (_settings != null && _settings!.path != null) {
      _pngPrescription = File(_settings!.path!);
      final image = pw.MemoryImage(_pngPrescription!.readAsBytesSync());
      final doc = pw.Document();
      doc.addPage(
        pw.Page(
          margin: pw.EdgeInsets.zero,
          pageFormat: _pageFormats['a5']!,
          theme: pw.ThemeData(defaultTextStyle: style),
          build: (context) {
            return pw.Stack(
              fit: pw.StackFit.expand,
              alignment: pw.Alignment.center,
              children: [
                pw.Image(image),
                pw.Positioned(
                  child: pw.Text("{{ ${posDataType?.forWidgets() ?? ''} }}"),
                  left: settings?.data[posDataType.toString()]?.x,
                  top: settings?.data[posDataType.toString()]?.y,
                ),
              ],
            );
          },
        ),
      );

      return doc.save();
    } else {
      _pngPrescription = null;
      // notifyListeners();
      final doc = pw.Document();
      doc.addPage(
        pw.Page(
          theme: pw.ThemeData(defaultTextStyle: titleStyle),
          pageFormat: pageFormats['a5']!,
          build: (context) {
            return pw.Center(
              child: pw.Text(
                "No Prescription File Selected.",
                textAlign: pw.TextAlign.center,
              ),
            );
          },
        ),
      );
      return doc.save();
    }
  }

  FutureOr<Uint8List> get pdfPrescriptionBuilder => _buildPdf();

  PosDataType? _posDataType;
  PosDataType? get posDataType => _posDataType;

  void selectPosDataType(PosDataType? value) {
    _posDataType = value;
    notifyListeners();
  }
}
