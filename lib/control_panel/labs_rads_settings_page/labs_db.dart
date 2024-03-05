import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class LabsClass {
  final String docname;

  LabsClass({required this.docname}) {
    doctorlablist.listen((list) {
      _labstream.add(list);
    });
  }
  closeStream() async {
    await _labstream.close();
  }

  //add field to doctor in mongo
  Future updateDoctorLabstoMongo({required String docname, lab}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$addToSet': {'labs': lab}
    });
  }

//delete field from doctor in mongo
  Future deleteDoctorLabsFromMongo({required String docname, lab}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$pull': {'labs': lab}
    });
  }

//procedure list stream
  Stream<dynamic> get doctorlablist async* {
    Map<String, dynamic>? doclistlab =
        await allDoctors.findOne(where.eq('docname', docname));
    List lablist = await doclistlab?['labs'];
    yield lablist;
  }

  final StreamController<dynamic> _labstream = StreamController.broadcast();

  Stream<dynamic> get labstream => _labstream.stream;
}
