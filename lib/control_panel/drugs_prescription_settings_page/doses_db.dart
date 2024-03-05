import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DosesClass {
  final String docname;

  DosesClass({required this.docname}) {
    doctordoselist.listen((list) {
      _dosestream.add(list);
    });
  }

  //add dose to doctor in mongo
  Future updateDoctorDosestoMongo({required String docname, dose}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$addToSet': {'doses': dose}
    });
  }

//delete dose from doctor in mongo
  Future deleteDoctorDosesFromMongo({required String docname, dose}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$pull': {'doses': dose}
    });
  }

//Doses list stream
  Stream<dynamic> get doctordoselist async* {
    Map<String, dynamic>? doclistdose =
        await allDoctors.findOne(where.eq('docname', docname));
    List titlelist = await doclistdose?['doses'];
    yield titlelist;
  }

  final StreamController<dynamic> _dosestream = StreamController.broadcast();

  Stream<dynamic> get dosestream => _dosestream.stream;
}
