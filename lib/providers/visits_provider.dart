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

  DateTime get today => DateTime(_date.year, _date.month, _date.day);

  void setDate({int? day, int? month, int? year}) {
    _date = DateTime(
      year ?? _date.year,
      month ?? date.month,
      day ?? date.day,
    );
    notifyListeners();
  }

  void setSecondDate({int? day, int? month, int? year}) {
    _secondDate = DateTime(
      year ?? _date.year,
      month ?? date.month,
      day ?? date.day,
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
        final result = await Database.instance.allPatients
            .find(where
                .eq(SxVisit.DOCNAME_E, docname)
                .gte(
                  SxVisit.VISITDATE,
                  date.toIso8601String(),
                )
                .lte(SxVisit.VISITDATE, secondDate))
            .toList();
        _visits = Visit.visitList(result);
        notifyListeners();

      case QueryType.Search:
        final result = await Database.instance.allPatients
            .find(where.eq(SxVisit.DOCNAME_E, docname).and(where
                .eq(SxVisit.PTNAME, query)
                .or(where.eq(SxVisit.PHONE, query))))
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
}
