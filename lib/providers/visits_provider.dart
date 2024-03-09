import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/models/visitModel.dart';

class PxVisits extends ChangeNotifier {
  List<Visit> _visits = [];
  List<Visit> get visits => _visits;

  DateTime _date = DateTime.now();
  DateTime get date => _date;

  DateTime _secondDate = DateTime.now();
  DateTime get secondDate => _secondDate;

  final DateTime _today = DateTime.now();
  DateTime get today => DateTime(_today.year, _today.month, _today.day);

  bool _forRange = false;
  bool get forRange => _forRange;

  void setForRange(bool val) {
    _forRange = val;
    notifyListeners();
  }

  void setDate({int? day, int? month, int? year}) {
    _date = DateTime(
      year ?? _date.year,
      month ?? _date.month,
      day ?? _date.day,
    );
    notifyListeners();
  }

  void setSecondDate({int? day, int? month, int? year}) {
    _secondDate = DateTime(
      year ?? _secondDate.year,
      month ?? _secondDate.month,
      day ?? _secondDate.day,
    );
    notifyListeners();
  }

  Future<void> fetchVisits({
    required String docname,
    required QueryType type,
    String? query,
  }) async {
    switch (type) {
      case QueryType.Today:
        final result = await Database.instance.allPatients
            .find(where.eq(SxVisit.DOCNAME_E, docname).eq(
                  SxVisit.VISITDATE,
                  today.toIso8601String(),
                ))
            .toList();

        _visits = Visit.visitList(result);
        notifyListeners();

      case QueryType.Date:
        final result = await Database.instance.allPatients
            .find(where.eq(SxVisit.DOCNAME_E, docname).eq(
                  SxVisit.VISITDATE,
                  date.toIso8601String(),
                ))
            .toList();

        _visits = Visit.visitList(result);
        notifyListeners();

      case QueryType.Range:
        //TODO: FIX QUERY
        final result = await Database.instance.allPatients
            .find(
              where
                  .eq(SxVisit.DOCNAME_E, docname)
                  .gte(SxVisit.VISITDATE, date.toIso8601String())
                  .lte(SxVisit.VISITDATE, secondDate.toIso8601String()),
            )
            .toList();
        _visits = Visit.visitList(result);
        notifyListeners();

      case QueryType.Search:
        final result = await Database.instance.allPatients
            .find(where.eq(SxVisit.DOCNAME_E, docname).and(where
                .match(SxVisit.PTNAME, query!)
                .or(where.match(SxVisit.PHONE, query))))
            .toList();
        _visits = Visit.visitList(result);
        notifyListeners();

      case QueryType.All:
        final result = await Database.instance.allPatients
            .find(where.eq(SxVisit.DOCNAME_E, docname))
            .toList();

        _visits = Visit.visitList(result);
        notifyListeners();
    }
  }
}

enum QueryType {
  Today,
  Date,
  Range,
  Search,
  All,
}
