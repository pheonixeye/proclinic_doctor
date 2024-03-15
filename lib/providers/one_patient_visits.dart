import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/models/visitModel.dart';
import 'package:proclinic_doctor_windows/models/visit_data/visit_data.dart';

class PxOnePatientVisits extends ChangeNotifier {
  // List<Visit> _visits = [];
  // List<Visit> get visits => _visits;

  // List<VisitData> _data = [];
  // List<VisitData> get data => _data;

  static final _t = DateTime.now();
  final _cutoffDate = DateTime(_t.year, _t.month, _t.day).toIso8601String();

  final Map<ObjectId, Map<String, dynamic>> _database = {};
  Map<ObjectId, Map<String, dynamic>> get database => _database;

  Future<void> fetchOnePatientVisits({required Visit visit}) async {
    _database.clear();
    final result = await Database.instance.allPatients
        .find(where
            .eq(SxVisit.DOCID, visit.docid)
            .eq(SxVisit.PTNAME, visit.ptName)
            .eq(SxVisit.DOB, visit.dob)
            .eq(SxVisit.PHONE, visit.phone)
            .lt(SxVisit.VISITDATE, _cutoffDate)
            .sortBy(
              SxVisit.VISITDATE,
              descending: true,
            ))
        .toList();

    // _visits = result.map((e) => Visit.fromJson(e)).toList();
    result.map((e) {
      _database.putIfAbsent(
          e["_id"] as ObjectId, () => {"visit": {}, "data": {}});
      _database[(e["_id"] as ObjectId)]?['visit'] = Visit.fromJson(e);
    }).toList();
    notifyListeners();
    await fetchOnePatientVisitsData();
  }

  Future<void> fetchOnePatientVisitsData() async {
    for (final entry in _database.entries) {
      final result = await Database.instance.visitData
          .findOne(where.eq(SxVD.VISITID, entry.key));
      // print(result);
      _database[result![SxVD.VISITID] as ObjectId]?["data"] =
          VisitData.fromJson(result);
    }
    notifyListeners();
    // print(_database);
  }
}
