// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_models/proclinic_models.dart';

class PxDoctorListProvider extends ChangeNotifier {
  PxDoctorListProvider() {
    _fetchAllDoctors();
  }
  List<Doctor>? _doctorList;
  List<Doctor>? get doctorList => _doctorList;

  Future<void> _fetchAllDoctors() async {
    final result = await Database.instance.doctors.find().toList();
    _doctorList = result.map((e) => Doctor.fromJson(e)).toList();
    notifyListeners();
  }
}
