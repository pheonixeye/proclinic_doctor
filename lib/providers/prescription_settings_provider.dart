import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_models/proclinic_models.dart';

class PxPrescriptionSettings extends ChangeNotifier {
  final int docId;

  PxPrescriptionSettings({required this.docId});

  PrescriptionSettings? _settings;
  PrescriptionSettings? get settings => _settings;

  void onLogout() {
    _settings = null;
    notifyListeners();
  }

  Future<void> get init => _checkIfDoctorSettingsExists();

  Future<void> _checkIfDoctorSettingsExists() async {
    final result = await Database.instance.prescriptionSettings
        .findOne(where.eq('docId', docId));
    if (result == null) {
      //todo: perform add first time
      await Database.instance.prescriptionSettings
          .insertOne(PrescriptionSettings.create(docId).toJson());
      //todo: assign data
      final newResult = await Database.instance.prescriptionSettings
          .findOne(where.eq('docId', docId));
      _settings = PrescriptionSettings.fromJson(newResult!);
      notifyListeners();
      if (kDebugMode) {
        print(
            'PxPrescriptionSetting()._checkIfDoctorSettingsExists(create&assign)');
      }
    } else {
      //todo: assign data
      _settings = PrescriptionSettings.fromJson(result);
      notifyListeners();
      if (kDebugMode) {
        print('PxPrescriptionSetting()._checkIfDoctorSettingsExists(assign)');
      }
    }
  }

  Future<void> updatePrescriptionSettings() async {}
}
