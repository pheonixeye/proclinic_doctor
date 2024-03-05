import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AllPatientsSingleDoctor {
  final String docname;

  AllPatientsSingleDoctor({
    required this.docname,
  }) {
    allPatientsofOneDoctor.listen((list) => _allptsonedoctor.add(list));
  }

  //patients of a single doctor in all times//
  Stream<List<Map<String, dynamic>>> get allPatientsofOneDoctor async* {
    List<Map<String, dynamic>> allptsonedoctor = await allPatients
        .find(where
            .match('docname', docname)
            .sortBy('year', descending: true)
            .sortBy('month', descending: true)
            .sortBy('day', descending: true))
        .toList();
    yield allptsonedoctor;
  }

  StreamController<List<Map<String, dynamic>>> _allptsonedoctor =
      StreamController.broadcast();

  Stream<List<Map<String, dynamic>>> get allptsonedoctorname =>
      _allptsonedoctor.stream;
}
