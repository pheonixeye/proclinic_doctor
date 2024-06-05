import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_models/proclinic_models.dart';

class PxFormLoader extends ChangeNotifier {
  Future<void> _init() async {
    final result = await Database.instance.forms.find().toList();
    _forms = result.map((e) => ProClinicForm.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> get init => _init();

  List<ProClinicForm>? _forms;
  List<ProClinicForm>? get forms => _forms;

  ProClinicForm? _selectedForm;
  ProClinicForm? get selectedForm => _selectedForm;

  void selectForm(ProClinicForm? value) {
    _selectedForm = value;
    notifyListeners();
  }

  Future<void> saveForm() async {
    //TODO
  }
}
