import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AllPatientsSingleDoctorTodayDate {
  final String ptname;
  final String phone;
  final String docname;
  final String day;
  final String month;
  final String year;

  AllPatientsSingleDoctorTodayDate({
    required this.ptname,
    required this.phone,
    required this.docname,
    required this.day,
    required this.month,
    required this.year,
  }) {
    allPatientsofOneDoctorinsetdate
        .listen((list) => _allptsonedoctorinsetdate.add(list));
  }

  //patients of a single doctor in set date//
  Stream<List<Map<String, dynamic>>>
      get allPatientsofOneDoctorinsetdate async* {
    List<Map<String, dynamic>> allptsonedoctorsetdate = await allPatients
        .find(where.match('docname', docname).and(where
            .eq('year', year)
            .and(where.eq('month', month).and(where.eq('day', day)))))
        .toList();
    yield allptsonedoctorsetdate;
  }

  final StreamController<List<Map<String, dynamic>>> _allptsonedoctorinsetdate =
      StreamController.broadcast();

  Stream<List<Map<String, dynamic>>> get allptsonedoctornameinsetdate =>
      _allptsonedoctorinsetdate.stream;
}
