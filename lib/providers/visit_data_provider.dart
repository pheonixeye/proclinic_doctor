import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/errors/no_visit_selected.dart';
import 'package:proclinic_doctor_windows/models/drug/drug_model.dart';
import 'package:proclinic_doctor_windows/models/visitModel.dart';
import 'package:proclinic_doctor_windows/models/visit_data/visit_data.dart';

class PxVisitData extends ChangeNotifier {
  Visit? _visit;
  Visit? get visit => _visit;

  void selectVisit(Visit? value) {
    _visit = value;
    notifyListeners();
  }

  VisitData? _data;
  VisitData? get data => _data;

  Future<void> fetchVisitData() async {
    if (visit == null) {
      throw NoVisitSelectedException();
    }
    final result = await Database.instance.visitData
        .findOne(where.eq(SxVD.VISITID, visit!.id));
    _data = VisitData.fromJson(result);
    notifyListeners();
    _drugs = _data!.drugs;
    _labs = _data!.labs;
    _rads = _data!.rads;
    notifyListeners();
  }

  List<String> _labs = [];
  List<String> get labs => _labs;

  List<String> _rads = [];
  List<String> get rads => _rads;

  List<Drug> _drugs = [];
  List<Drug> get drugs => _drugs;

  void setLabs(String value) {
    _labs.contains(value) ? _labs.remove(value) : _labs.add(value);
    notifyListeners();
  }

  void setRads(String value) {
    _rads.contains(value) ? _rads.remove(value) : _rads.add(value);
    notifyListeners();
  }

  void setDrugs(Drug value) {
    _drugs.contains(value) ? _drugs.remove(value) : _drugs.add(value);
    notifyListeners();
  }

  void filterLabs(String value) {
    value.isEmpty
        ? _labs = _data!.labs
        : _labs = _labs
            .where((e) => e.toLowerCase().startsWith(value.toLowerCase()))
            .toList();
    notifyListeners();
  }

  void filterRads(String value) {
    value.isEmpty
        ? _rads = _data!.rads
        : _rads = _rads
            .where((e) => e.toLowerCase().startsWith(value.toLowerCase()))
            .toList();
    notifyListeners();
  }

  void filterDrugs(String value) {
    value.isEmpty
        ? _drugs = _data!.drugs
        : _drugs = _drugs
            .where((e) => e.name.toLowerCase().startsWith(value.toLowerCase()))
            .toList();
    notifyListeners();
  }

  void setDose(
    String drug, {
    double? unit,
    int? frequency,
    int? duration,
    String? form,
    String? frequecyUnit,
    String? durationUnit,
  }) {
    var d = _drugs.firstWhere((element) => element.name == drug);
    var i = _drugs.indexOf(d);
    _drugs[i] = d.updateDose(
      unit: unit,
      frequency: frequency,
      duration: duration,
      form: form,
      frequencyUnit: frequecyUnit,
      durationUnit: durationUnit,
    );
    notifyListeners();
  }

  bool validateDrugPrescription() {
    bool isValid = false;
    _drugs.map((e) {
      final d = e.dose;
      if (d.duration == 0 ||
          d.unit == 0 ||
          d.durationUnit == '' ||
          d.form == '' ||
          d.frequency == 0 ||
          d.frequencyUnit == '') {
        isValid = false;
      } else {
        isValid = true;
      }
    }).toList();
    return isValid;
  }

  Future<void> updateVisitData(String attribute, dynamic value) async {
    await Database.instance.visitData.updateOne(
      where.eq(SxVD.VISITID, visit!.id),
      {
        r'$set': {
          attribute: value,
        }
      },
    );
    await fetchVisitData();
  }
}
