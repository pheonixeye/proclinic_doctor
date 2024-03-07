import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/errors/no_visit_selected.dart';
import 'package:proclinic_doctor_windows/models/visitModel.dart';
import 'package:proclinic_doctor_windows/models/visit_data/visit_data.dart';

class PxVisitData extends ChangeNotifier {
  Visit? _visit;
  Visit? get visit => _visit;

  void selectVisit(Visit? value) {
    _visit = value;
    notifyListeners();
  }

  VisitData? _data;
  VisitData? get data => _data;

  Future<void> fetchVisitData() async {
    if (visit == null) {
      throw NoVisitSelectedException();
    }
    final result = await Database.instance.visitData
        .findOne(where.eq(SxVD.VISITID, visit!.id));
    _data = VisitData.fromJson(result);
    notifyListeners();
  }

  Future<void> updateVisitData(String attribute, dynamic value) async {
    await Database.instance.visitData.updateOne(
      where.eq(SxVD.VISITID, visit!.id),
      {
        r'$set': {
          attribute: value,
        }
      },
    );
    await fetchVisitData();
  }
}
