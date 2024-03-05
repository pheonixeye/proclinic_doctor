import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MedicalFieldsClass {
  final String docname;

  MedicalFieldsClass({required this.docname}) {
    doctormedicalfieldlist.listen((list) {
      _fieldStream.add(list);
    });
  }

  //add field to doctor in mongo
  Future updateDoctorFieldtoMongo({required String docname, medfield}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$push': {'fields': medfield}
    });
  }

//delete field from doctor in mongo
  Future deleteDoctorFieldFromMongo({required String docname, medfield}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$pull': {'fields': medfield}
    });
  }

//procedure list stream
  Stream<dynamic> get doctormedicalfieldlist async* {
    Map<String, dynamic>? doclistfield =
        await allDoctors.findOne(where.eq('docname', docname));
    List fieldlist = await doclistfield?['fields'];
    yield fieldlist;
  }

  final StreamController<dynamic> _fieldStream = StreamController.broadcast();

  Stream<dynamic> get fieldStream => _fieldStream.stream;
}
