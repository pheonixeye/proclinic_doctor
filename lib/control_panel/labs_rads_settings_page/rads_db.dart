import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class RadsClass {
  final String docname;

  RadsClass({required this.docname}) {
    doctorradlist.listen((list) {
      _radstream.add(list);
    });
  }

  //add field to doctor in mongo
  Future updateDoctorRadstoMongo({required String docname, rad}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$addToSet': {'rads': rad}
    });
  }

//delete field from doctor in mongo
  Future deleteDoctorRadsFromMongo({required String docname, rad}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$pull': {'rads': rad}
    });
  }

//procedure list stream
  Stream<dynamic> get doctorradlist async* {
    Map<String, dynamic>? doclistrad =
        await allDoctors.findOne(where.eq('docname', docname));
    List radlist = await doclistrad?['rads'];
    yield radlist;
  }

  final StreamController<dynamic> _radstream = StreamController.broadcast();

  Stream<dynamic> get radstream => _radstream.stream;
}
