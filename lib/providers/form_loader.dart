import 'package:flutter/material.dart';
import 'package:proclinic_doctor/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor/providers/visit_data_provider.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class PxFormLoader extends ChangeNotifier {
  Future<void> _init() async {
    final result = await Database.forms.find().toList();
    _forms = result.map((e) => ProClinicForm.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> get init => _init();

  List<ProClinicForm>? _forms;
  List<ProClinicForm>? get forms => _forms;

  ProClinicForm? _selectedForm;
  ProClinicForm? get selectedForm => _selectedForm;

  Map<String, dynamic>? _formState;
  Map<String, dynamic>? get formState => _formState;

  void selectForm(ProClinicForm? value, [VisitData? data]) {
    _selectedForm = value;
    if (_selectedForm != null) {
      _formState =
          (data != null && data.formData != null)
              ? {...data.formData!}
              : {..._selectedForm!.formState};
    }
    notifyListeners();
  }

  void updateFormState(String key, dynamic value) {
    _formState?[key] = value;
    notifyListeners();
  }

  Future<void> saveForm(BuildContext context) async {
    //todo
    final vd = context.read<PxVisitData>();
    await vd.updateVisitData(SxVD.FORMDATA, _formState);
    selectForm(_selectedForm, vd.data);
  }
}
