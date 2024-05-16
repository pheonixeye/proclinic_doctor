import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/errors/db_query.dart';
import 'package:proclinic_models/proclinic_models.dart';

class PxSelectedDoctor extends ChangeNotifier {
  Doctor? _doctor;
  Doctor? get doctor => _doctor;

  void selectDoctor(Doctor? value) {
    if (value == null) {
      _doctor = value;
      notifyListeners();
    } else {
      _doctor = value;
      notifyListeners();
      _labs = _doctor!.labs;
      _rads = _doctor!.rads;
      _drugs = _doctor!.drugs;
      notifyListeners();
    }
  }

  void onLogout() {
    _doctor = null;
    _labs = [];
    _rads = [];
    _drugs = [];
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

  Future<void> fetchDoctorByid(int id) async {
    try {
      final result =
          await Database.instance.doctors.findOne(where.eq('_id', id));
      if (result != null) {
        _doctor = Doctor.fromJson(result);
        notifyListeners();
      }
    } catch (e) {
      throw MongoDbQueryError(message: e.toString());
    }
  }

  Future<void> updateSelectedDoctor({
    required int id,
    required String attribute,
    required dynamic value,
    UpdateType updateType = UpdateType.set,
  }) async {
    await Database.instance.doctors.updateOne(
      where.eq('_id', id),
      switch (updateType) {
        UpdateType.set => {
            r'$set': {
              attribute: value,
            },
          },
        UpdateType.addToList => {
            r'$addToSet': {
              attribute: value,
            },
          },
        UpdateType.removeFromList => {
            r'$pull': {
              attribute: value,
            }
          },
      },
    );
    await fetchDoctorByid(id);
  }
}

enum UpdateType {
  set,
  addToList,
  removeFromList,
}
