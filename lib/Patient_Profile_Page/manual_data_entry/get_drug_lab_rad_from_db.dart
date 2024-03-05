import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DrugGetterFromDb {
  final String id;
  final String docname;
  final String clinic;
  final String ptname;
  final String phone;
  final String year;
  final String month;
  final String day;
  final String visit;
  final String procedure;
  final String amount;
  final String dob;
  final String age;
  final String remaining;
  final String cashtype;
  final String drl;

  DrugGetterFromDb({
    required this.drl,
    required this.id,
    required this.docname,
    required this.clinic,
    required this.ptname,
    required this.phone,
    required this.year,
    required this.month,
    required this.day,
    required this.visit,
    required this.procedure,
    required this.amount,
    required this.dob,
    required this.age,
    required this.remaining,
    required this.cashtype,
  }) {
    drugforptgetterstream.listen((event) {
      _controller.add(event);
    });
  }

  Stream get drugforptgetterstream async* {
    Map<String, dynamic>? onept = await allPatients.findOne(where
        .eq('ptname', ptname)
        .and(where.eq('phone', phone))
        .and(where.eq('id', id))
        .and(where.eq('visit', visit))
        .and(where.eq('day', day))
        .and(where.eq('month', month))
        .and(where.eq('year', year))
        .and(where.eq('docname', docname))
        .and(where.eq('procedure', procedure))
        .and(where.eq('cashtype', cashtype))
        .and(where.eq('remaining', remaining))
        .and(where.eq('dob', dob))
        .and(where.eq('age', age))
        .and(where.eq('amount', amount)));
    List druginfo = onept![drl];

    yield druginfo;
  }

  final StreamController _controller = StreamController.broadcast();

  Stream get druggetterstream => _controller.stream;
}
