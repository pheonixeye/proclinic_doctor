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
    _labs = _doctor!.labs;
    _rads = _doctor!.rads;
    _drugs = _doctor!.drugs;
    notifyListeners();
  }

  List<String> _drugs = [];
  List<String> get drugs => _drugs;

  List<String> _labs = [];
  List<String> get labs => _labs;

  List<String> _rads = [];
  List<String> get rads => _rads;

  void filterList(String attribute, String filter) {
    switch (attribute) {
      case 'labs':
        filter.isEmpty
            ? _labs = _doctor!.labs
            : _labs = _labs
                .where((element) =>
                    element.toLowerCase().startsWith(filter.toLowerCase()))
                .toList();
        notifyListeners();
        break;
      case 'rads':
        filter.isEmpty
            ? _rads = _doctor!.rads
            : _rads = _rads
                .where((element) =>
                    element.toLowerCase().startsWith(filter.toLowerCase()))
                .toList();
        notifyListeners();
        break;
      case 'drugs':
        filter.isEmpty
            ? _drugs = _doctor!.drugs
            : _drugs = _drugs
                .where((element) =>
                    element.toLowerCase().startsWith(filter.toLowerCase()))
                .toList();
        notifyListeners();
        break;
      default:
        throw UnimplementedError();
    }
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
