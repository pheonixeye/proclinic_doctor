import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MiscClass {
  final String docname;

  MiscClass({required this.docname}) {
    doctormisclist.listen((list) {
      _misctream.add(list);
    });
  }

  //add misc to doctor in mongo
  Future updateDoctorMisctoMongo({required String docname, misc}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$addToSet': {'misc': misc}
    });
  }

//delete misc from doctor in mongo
  Future deleteDoctorMiscFromMongo({required String docname, misc}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$pull': {'misc': misc}
    });
  }

//Misc list stream
  Stream<dynamic> get doctormisclist async* {
    Map<String, dynamic>? doclistmisc =
        await allDoctors.findOne(where.eq('docname', docname));
    List titlelist = await doclistmisc?['misc'];
    yield titlelist;
  }

  final StreamController<dynamic> _misctream = StreamController.broadcast();

  Stream<dynamic> get misctream => _misctream.stream;
}
