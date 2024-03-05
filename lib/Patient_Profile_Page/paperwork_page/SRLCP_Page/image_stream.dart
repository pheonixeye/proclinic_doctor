import 'dart:async';
import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class GridFSimageFileReaderOneVisitDate {
  final String ptname;
  final String visitdate;
  final String docname;
  final String srlcp;
  final String phone;

  GridFSimageFileReaderOneVisitDate({
    required this.visitdate,
    required this.docname,
    required this.ptname,
    required this.srlcp,
    required this.phone,
  }) {
    allimagesdata.listen((list) {
      _allimgsPts.add(list);
      // print('returned list = > ${list}');
    });
  }

  //all images stream one doctor one visit//
  Stream<List> get allimagesdata async* {
    DbCollection patientNamedCollection = Database.mongo!.collection(phone);

    List alldata = await patientNamedCollection
        .find(where
            .eq('ptname', ptname)
            .eq('docname', docname)
            .eq('visitdate', visitdate)
            .exists(srlcp))
        .toList();

    // List imgdata = await alldata.map((e) {
    //   return e['sheet'];
    // }).toList();
    yield alldata;
  }

  final StreamController<List> _allimgsPts = StreamController.broadcast();

  Stream<List> get imglist => _allimgsPts.stream;
}

// //all images one doctor all visits
// class GridFSimageFileReaderAllVisitDate {
//   final String ptname;
//   final String visitdate;
//   final String docname;
//   final String srlcp;
//   final String phone;

//   GridFSimageFileReaderAllVisitDate(
//       {this.visitdate, this.docname, this.ptname, this.srlcp, this.phone}) {
//     allimagesdata.listen((list) {
//       _allimgsPts.add(list);
//       // print('returned list = > ${list}');
//     });
//   }

//   //all images stream one doctor all visits//
//   Stream<List> get allimagesdata async* {
//     DbCollection patientNamedCollection = await mongo.collection(phone);

//     List alldata = await patientNamedCollection
//         .find(where.eq('ptname', ptname).eq('docname', docname).exists(srlcp))
//         .toList();

//     // List imgdata = await alldata.map((e) {
//     //   return e['sheet'];
//     // }).toList();
//     yield alldata;
//   }

//   StreamController<List> _allimgsPts = StreamController.broadcast();

//   Stream<List> get imglist => _allimgsPts.stream;
// }
