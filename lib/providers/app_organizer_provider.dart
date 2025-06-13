import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_models/proclinic_models.dart';

// ignore: must_be_immutable
class PxAppOrganizer extends ChangeNotifier with EquatableMixin {
  PxAppOrganizer({required this.visitId}) {
    fetchOrganizerAppointment();
  }

  OrgAppointement? _appointement;
  OrgAppointement? get appointement => _appointement;

  final ObjectId visitId;

  Future<void> fetchOrganizerAppointment() async {
    final result = await Database.appOrganizer.findOne(
      where.eq("_id", visitId),
    );
    if (result != null) {
      _appointement = OrgAppointement.fromJson(result);
      // if (kDebugMode) {
      //   print(_appointement.toString());
      // }
      notifyListeners();
    } else {
      _appointement = null;
      notifyListeners();
    }
  }

  void setOrganizerAppointment(Visit visit, DateTime dateTime) {
    _appointement = OrgAppointement(
      id: visit.id,
      ptname: visit.ptName,
      phone: visit.phone,
      docnameEN: visit.docNameEN,
      docnameAR: visit.docNameAR,
      clinicEN: visit.speciality.nameEn,
      clinicAR: visit.speciality.nameAr,
      dateTime: dateTime.toIso8601String(),
      dob: visit.dob,
      docid: visit.docid!,
    );
    notifyListeners();
  }

  Future<void> createFollowUpDate() async {
    if (_appointement != null) {
      final oldApp = await Database.appOrganizer.findOne(
        where.eq("_id", visitId),
      );
      if (oldApp == null) {
        await Database.appOrganizer.insertOne(_appointement!.toJson());
      } else {
        await Database.appOrganizer.updateOne(
          where.eq("_id", _appointement!.id),
          {r'$set': _appointement!.toJson()},
        );
      }
      await fetchOrganizerAppointment();
    }
  }

  @override
  List<Object?> get props => [visitId, appointement];

  static Future<OrgAppointement?> fetctAppointmentById(ObjectId visitId) async {
    final result = await Database.appOrganizer.findOne(
      where.eq("_id", visitId),
    );
    if (result != null) {
      return OrgAppointement.fromJson(result);
    } else {
      return null;
    }
  }
}
