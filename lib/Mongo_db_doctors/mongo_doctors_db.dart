import 'dart:async';
import 'dart:math';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

//all doctors stream from mongo//
class DoctorsMongoDatabase {
  final docname;

  DoctorsMongoDatabase({this.docname}) {
    allMongoDoctors.listen((list) {
      _allMongoDoctors.add(list);
    });
  }
  //add doctor to mongo
  Future addDoctorToMongo(
      {required String docname,
      clinic,
      password,
      List<String>? proceduers}) async {
    await allDoctors.insert({
      '_id': (docname.length * Random().nextInt(7) + clinic.length * 2020),
      'docname': docname,
      'clinic': clinic,
      'password': password,
    });
  }

//add procedure to doctor in mongo
  Future updateDoctorProcedurestoMongo(
      {required String docname, procedure}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$push': {'procedures': procedure}
    });
  }

//delete procedure from doctor in mongo
  Future deleteDoctorProcedureFromMongo(
      {required String docname, procedure}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$pull': {'procedures': procedure}
    });
  }

  Future updatepasswordintomongo({required String docname, password}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$set': {'password': password}
    });
  }

  //choose clinic view
  Future updatelayoutintomongo(
      {required String docname, required bool grid}) async {
    await allDoctors
        .update(await allDoctors.findOne(where.eq('docname', docname)), {
      r'$set': {'grid': grid}
    });
  }

//delete whole doctor instance from mongo
  Future deleteDoctorFromMongo({required String docname}) async {
    await allDoctors.remove(where.eq('docname', docname));
  }

//stream of all doctors
  Stream<List<Map<String, dynamic>>> get allDoctorsfromMongo async* {
    List<Map<String, dynamic>> doctornameList =
        await allDoctors.find().toList();
    yield doctornameList;
  }

  final StreamController<List<Map<String, dynamic>>> _allMongoDoctors =
      StreamController.broadcast();

  Stream<List<Map<String, dynamic>>> get allMongoDoctors =>
      _allMongoDoctors.stream;
}

//one doctor from mongo by name//
class OneMongoDoctor {
  final String docname;

  OneMongoDoctor({required this.docname}) {
    oneDoctorfromMongo.listen((event) {
      _oneMongoDoctor.add(event);
    });
  }

  //stream of one doctor
  Stream<List<Map<String, dynamic>>> get oneDoctorfromMongo async* {
    List<Map<String, dynamic>> doctorname =
        await allDoctors.find(where.eq('docname', docname)).toList();
    yield doctorname;
  }

  final StreamController<List<Map<String, dynamic>>> _oneMongoDoctor =
      StreamController.broadcast();

  Stream<List<Map<String, dynamic>>> get oneMongoDoctor =>
      _oneMongoDoctor.stream;
}

//proceduer list for doctor name class//
class DoctorProcedureList {
  final String docname;

  DoctorProcedureList({required this.docname}) {
    procStream.listen((list) {
      _procStream.add(list);
    });
  }

//procedure list stream
  Stream<dynamic> get allDoctorProceduersList async* {
    Map<String, dynamic>? doclistproc =
        await allDoctors.findOne(where.eq('docname', docname));
    List procedurelist = await doclistproc?['procedures'];
    yield procedurelist;
  }

  final StreamController<dynamic> _procStream = StreamController.broadcast();

  Stream<dynamic> get procStream => _procStream.stream;
}

//one doctor GRID Stream //
class OneDoctorGridStream {
  final String docname;

  OneDoctorGridStream({required this.docname}) {
    gridValueStreambool.listen((event) {
      _gridvalueStream.add(event);
    });
  }

  //stream of one doctor GRID Stream
  Stream get gridValueStreambool async* {
    Map<String, dynamic>? doctorname =
        await allDoctors.findOne(where.eq('docname', docname));
    // Map<String, dynamic> nonListdoc = await doctorname[0];
    bool gridvalue = await doctorname?['grid'];
    yield gridvalue;
  }

  final StreamController _gridvalueStream = StreamController.broadcast();

  Stream get gridvaluestream => _gridvalueStream.stream;
}
