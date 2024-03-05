import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DrugsClass {
  final String docname;

  DrugsClass({required this.docname}) {
    doctordruglist.listen((list) {
      _drugstream.add(list);
    });
  }

  //add field to doctor in mongo
  Future updateDoctorDrugstoMongo({required String docname, drug}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$addToSet': {'drugs': drug}
    });
  }

//delete field from doctor in mongo
  Future deleteDoctorDrugsFromMongo({required String docname, drug}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$pull': {'drugs': drug}
    });
  }

//drug srch list stream
  Stream<dynamic> get doctordruglist async* {
    Map<String, dynamic>? doclistfield =
        await allDoctors.findOne(where.eq('docname', docname));
    List druglist = await doclistfield?['drugs'];
    yield druglist;
  }

  final StreamController<dynamic> _drugstream = StreamController.broadcast();

  Stream<dynamic> get drugStream => _drugstream.stream;
}

class SearchDrugsClass {
  final String docname;
  final String drug;

  SearchDrugsClass({required this.docname, required this.drug}) {
    doctordrugsearchlist.listen((event) {
      _drugsrcstream.add(event);
    });
  }
//search drugs list stream
  Stream<dynamic> get doctordrugsearchlist async* {
    Map<String, dynamic>? doclistfield =
        await allDoctors.findOne(where.eq('docname', docname));
    List druglist = await doclistfield?['drugs'];
    List srcdrugs = druglist.where((element) {
      return element.toString().contains(drug);
    }).toList();
    yield srcdrugs;
  }

  final StreamController<dynamic> _drugsrcstream = StreamController.broadcast();

  Stream<dynamic> get drugsrcStream => _drugsrcstream.stream;
}
