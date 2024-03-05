import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AppOrganizedMongo {
  final String docname;
  // final String clinic;
  // final String phone;
  // final String date;
  // final String time;

  AppOrganizedMongo({required this.docname}) {
    ptsOfOrganizer.listen((list) =>
        _allOrganizerMongoPts.add(list as List<Map<String, dynamic>>));
  }

  Future addptToOrganizer(
      {required String ptname, docname, phone, date, time}) async {
    await appOrganizer.insert({
      'ptname': ptname,
      'phone': phone,
      'docname': docname,
      'date': date,
      'time': time,
      'registered': false
    });
  }

  Future updateregisteration({required String ptname}) async {
    await appOrganizer
        .update(await appOrganizer.findOne(where.eq('ptname', ptname)), {
      r'$set': {'registered': true}
    });
  }

  Future deleteptFromOrganizer({required String ptname}) async {
    await appOrganizer.remove(where.eq('ptname', ptname));
  }

  Stream<List> get ptsOfOrganizer async* {
    List orgpts = await appOrganizer
        .find(where
            .eq('docname', docname)
            .sortBy('date', descending: false)
            .sortBy('time', descending: false))
        .toList();
    yield orgpts;
  }

  final StreamController<List<Map<String, dynamic>>> _allOrganizerMongoPts =
      StreamController.broadcast();

  Stream<List<Map<String, dynamic>>> get orgPatientlist =>
      _allOrganizerMongoPts.stream;
}
