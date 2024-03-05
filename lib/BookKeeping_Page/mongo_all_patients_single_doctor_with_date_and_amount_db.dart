import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AllPatientsSingleDoctorWithDateAndAmount {
  final String ptname;
  final String phone;
  final String docname;
  final String day;
  final String month;
  final String year;

  AllPatientsSingleDoctorWithDateAndAmount({
    required this.ptname,
    required this.phone,
    required this.docname,
    required this.day,
    required this.month,
    required this.year,
  }) {
    allPatientsofOneDoctorinsetdatewithamount
        .listen((list) => _allptsonedoctorinsetdatewithamount.add(list));
  }

  //patients of a single doctor in set date with amount added//
  Stream get allPatientsofOneDoctorinsetdatewithamount async* {
    List<Map<String, dynamic>> allptsonedoctorsetdatewithamount =
        await allPatients
            .find(where.match('docname', docname).and(where
                .eq('year', year)
                .and(where
                    .eq('month', month)
                    .and(where.lte('day', day).and(where.ne('amount', '0'))))))
            .toList();
    List<int> amountdata = allptsonedoctorsetdatewithamount.map((e) {
      return int.parse(e['amount']);
    }).toList();
    var datafolded =
        amountdata.fold<int>(0, (int prev, int element) => prev + element);
    yield datafolded;
  }

  final StreamController _allptsonedoctorinsetdatewithamount =
      StreamController.broadcast();

  Stream get allptsonedoctornameinsetdatewithamount =>
      _allptsonedoctorinsetdatewithamount.stream;
}
