import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class SearchedPatients {
  final String ptname;
  final String phone;
  final String docname;

  SearchedPatients({
    required this.ptname,
    required this.phone,
    required this.docname,
  }) {
    searchedMongoPatients.listen((list) => _searchedMongoPts.add(list));
  }

  //searched patients of all doctors//
  Stream<List<Map<String, dynamic>>> get searchedMongoPatients async* {
    List<Map<String, dynamic>> searchedPatientsfromMongo = await allPatients
        .find(where
            .eq('docname', docname)
            .and(where.match('ptname', ptname).or(where.match('phone', phone))))
        .toList();

    yield searchedPatientsfromMongo;
  }

  final StreamController<List<Map<String, dynamic>>> _searchedMongoPts =
      StreamController.broadcast();

  Stream<List<Map<String, dynamic>>> get searchedpatientlist =>
      _searchedMongoPts.stream;
}
