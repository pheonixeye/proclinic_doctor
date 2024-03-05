import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ClinicDetailsClass {
  final String docname;

  ClinicDetailsClass({required this.docname}) {
    doctorClinicDetailslist.listen((list) {
      _clinicDetailsStream.add(list);
    });
  }

  //add ClinicDetails to doctor in mongo
  Future updateDoctorClinicDetailstoMongo(
      {required String docname, clinicDetails}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$addToSet': {'clinicdetails': clinicDetails}
    });
  }

//delete ClinicDetails from doctor in mongo
  Future deleteDoctorClinicDetailsFromMongo(
      {required String docname, clinicDetails}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$pull': {'clinicdetails': clinicDetails}
    });
  }

//ClinicDetailss list stream
  Stream<dynamic> get doctorClinicDetailslist async* {
    Map<String, dynamic>? doclistClinicDetails =
        await allDoctors.findOne(where.eq('docname', docname));
    List clinicDetailslist = await doclistClinicDetails?['clinicdetails'];
    yield clinicDetailslist;
  }

  final StreamController<dynamic> _clinicDetailsStream =
      StreamController.broadcast();

  Stream<dynamic> get clinicDetailsStream => _clinicDetailsStream.stream;
}
