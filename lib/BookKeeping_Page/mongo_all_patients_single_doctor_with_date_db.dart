import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AllPatientsSingleDoctorWithDate {
  final String ptname;
  final String phone;
  final String docname;
  final String day;
  final String month;
  final String year;

  AllPatientsSingleDoctorWithDate({
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
        .find(where.match('docname', docname).and(where.eq('year', year).and(
            where
                .eq('month', month)
                .and(where.lte('day', day).and(where.ne('amount', '0'))))))
        .toList();
    yield allptsonedoctorsetdate;
  }

  final StreamController<List<Map<String, dynamic>>> _allptsonedoctorinsetdate =
      StreamController.broadcast();

  Stream<List<Map<String, dynamic>>> get allptsonedoctornameinsetdate =>
      _allptsonedoctorinsetdate.stream;
}
