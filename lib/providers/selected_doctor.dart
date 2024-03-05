import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/errors/db_query.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';

class PxSelectedDoctor extends ChangeNotifier {
  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  void selectDoctor(Doctor? value) {
    _doctor = value;
    notifyListeners();
  }

  Future<void> fetchDoctorByDocName(String docname) async {
    try {
      final result = await Database.instance.allDoctors
          .findOne(where.eq('docname', docname));
      _doctor = Doctor.fromJson(result);
      notifyListeners();
    } catch (e) {
      throw MongoDbQueryError(message: e.toString());
    }
  }

  Future<void> updateSelectedDoctor({
    required String docname,
    required String attribute,
    required dynamic value,
  }) async {
    await Database.instance.allDoctors.updateOne(
      where.eq('docname', docname),
      {
        r'$set': {
          attribute: value,
        },
      },
    );
    await fetchDoctorByDocName(docname);
  }
}
