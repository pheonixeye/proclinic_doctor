// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';

class PxDoctorListProvider extends ChangeNotifier {
  PxDoctorListProvider() {
    _fetchAllDoctors();
  }
  List<Doctor>? _doctorList;
  List<Doctor>? get doctorList => _doctorList;

  Future<void> _fetchAllDoctors() async {
    var variable = await Database.instance.allDoctors
        .find(where.eq(SxDoctor.PUBLISHED, true))
        .toList();
    _doctorList = Doctor.doctorList(variable);
    notifyListeners();
  }
}
