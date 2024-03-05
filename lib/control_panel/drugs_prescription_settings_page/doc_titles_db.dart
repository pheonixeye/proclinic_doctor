import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class TitlesClass {
  final String docname;

  TitlesClass({required this.docname}) {
    doctortitlelist.listen((list) {
      _titleStream.add(list);
    });
  }

  //add title to doctor in mongo
  Future updateDoctorTitlestoMongo({required String docname, title}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$addToSet': {'titles': title}
    });
  }

//delete title from doctor in mongo
  Future deleteDoctorTitlesFromMongo({required String docname, title}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$pull': {'titles': title}
    });
  }

//titles list stream
  Stream<dynamic> get doctortitlelist async* {
    Map<String, dynamic>? doclisttitle =
        await allDoctors.findOne(where.eq('docname', docname));
    List titlelist = await doclisttitle?['titles'];
    yield titlelist;
  }

  final StreamController<dynamic> _titleStream = StreamController.broadcast();

  Stream<dynamic> get titleStream => _titleStream.stream;
}
