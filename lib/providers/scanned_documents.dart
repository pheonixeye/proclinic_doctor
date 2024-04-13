import 'dart:io' show File, FileMode;

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/functions/print_logic.dart';
import 'package:proclinic_models/proclinic_models.dart';

class PxScannedDocuments extends ChangeNotifier {
  final pdfPath = PdfPrinter();

  VisitData? _data;
  VisitData? get data => _data;

  void selectData(VisitData? value) {
    _data = value;
    notifyListeners();
  }

  final List<File> _docs = [];
  List<File> get docs => _docs;

  Future<void> fetchVisitData(ObjectId visitId) async {
    final result =
        await Database.instance.visitData.findOne(where.eq("visitid", visitId));
    _data = VisitData.fromJson(result);
    notifyListeners();
  }

  Future<void> fetchDocumentsOfType(VisitAttribute attr) async {
    _docs.clear();
    for (final id in _data!.getIds(attr)) {
      final result = await Database.instance.gird.findOne(where.eq("_id", id));
      final temp = File("${pdfPath.path}\\${result!.filename}");
      if (!await temp.exists()) {
        await temp.create();
        final file = await result.toFile(temp,
            overwriteExistingFile: true, mode: FileMode.write);
        _docs.add(file);
        notifyListeners();
      } else {
        _docs.add(temp);
        notifyListeners();
      }
    }
  }
}

enum VisitAttribute {
  sheets,
  labs,
  rads,
  prescriptions,
  comments;

  static VisitAttribute fromString(String val) {
    return switch (val) {
      SxVD.SHEETSPAPERS => VisitAttribute.sheets,
      SxVD.LABSPAPERS => VisitAttribute.labs,
      SxVD.RADSPAPERS => VisitAttribute.rads,
      SxVD.DRUGPAPERS => VisitAttribute.prescriptions,
      SxVD.COMMENTSPAPERS => VisitAttribute.comments,
      _ => throw UnimplementedError(),
    };
  }
}

extension Attribute on VisitData {
  List<dynamic> getIds(VisitAttribute attribute) {
    return switch (attribute) {
      VisitAttribute.sheets => sheetpapers,
      VisitAttribute.labs => labpapers,
      VisitAttribute.rads => radpapers,
      VisitAttribute.prescriptions => drugpapers,
      VisitAttribute.comments => commentspapers,
    };
  }
}
