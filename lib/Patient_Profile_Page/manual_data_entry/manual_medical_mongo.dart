import 'dart:async';

import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ManualEntryMedicalInfo {
  final String? id;
  final String? docname;
  final String? clinic;
  final String? ptname;
  final String? phone;
  // final Str?ing year;
  // final Str?ing month;
  // final Str?ing day;
  final String? visit;
  final String? procedure;
  final String? amount;
  final String? dob;
  final String? age;
  final String? remaining;
  final String? cashtype;
  // final int index;

  ManualEntryMedicalInfo({
    // this.index,
    this.id,
    this.docname,
    this.clinic,
    this.ptname,
    this.phone,
    // year,
    // month,
    // day,
    this.visit,
    this.procedure,
    this.amount,
    this.dob,
    this.age,
    this.remaining,
    this.cashtype,
  }) {
    oneptmedicalhistorylist.listen((event) {
      _medinfoStream.add(event);
    });
  }

  Future insertMedicalInfo({
    String? id_,
    docName_,
    clinic_,
    ptName_,
    phone_,
    year_,
    month_,
    day_,
    visit_,
    procedure_,
    amount_,
    dob_,
    age_,
    remaining_,
    cashtype_,
    List? fieldname,
    List? fieldvalue,
    int? index,
  }) async {
    await allPatients.update(
        where
            .eq('ptname', ptName_)
            .and(where.eq('phone', phone_))
            .and(where.eq('id', id_))
            .and(where.eq('visit', visit_))
            .and(where.eq('day', day_))
            .and(where.eq('month', month_))
            .and(where.eq('year', year_))
            .and(where.eq('docname', docName_))
            .and(where.eq('procedure', procedure_))
            .and(where.eq('cashtype', cashtype_))
            .and(where.eq('remaining', remaining_))
            .and(where.eq('dob', dob_))
            .and(where.eq('age', age_))
            .and(where.eq('amount', amount_)),
        //TODO: method 1(adds replicated entries regardless of value)
        // {
        //   r'$push': {
        //     'medinfo': [
        //       {fieldname[index]: fieldvalue[index]}
        //     ]
        //   }
        // }
        //TODO: method 2
        // {
        //   r'$set': {
        //     'medinfo${index}': {fieldname[index]: fieldvalue[index]}
        //   }
        // }
        //TODO: method 4(adds entries as key:value pairs)
        // {
        //   r'$set': {fieldname[index]: fieldvalue[index]}
        // }

        //TODO: method 3(not working)
        // {fieldname[index]: fieldvalue[index]}
        //TODO: method 4(adds entries to a list & only adds new entries if they are not replicated)
        {
          r'$addToSet': {
            'medinfo': {
              r'$each': [
                {fieldname![index!]: fieldvalue![index]}
              ],
            }
          }
        });
  }

  Future deleteEntryFromListmedinfo(
      {String? id_,
      docName_,
      clinic_,
      ptName_,
      phone_,
      year_,
      month_,
      day_,
      visit_,
      procedure_,
      amount_,
      dob_,
      age_,
      remaining_,
      cashtype_,
      fieldname,
      fieldvalue,
      int? index}) async {
    await allPatients.update(
        where
            .eq('ptname', ptName_)
            .and(where.eq('phone', phone_))
            .and(where.eq('id', id_))
            .and(where.eq('visit', visit_))
            .and(where.eq('day', day_))
            .and(where.eq('month', month_))
            .and(where.eq('year', year_))
            .and(where.eq('docname', docName_))
            .and(where.eq('procedure', procedure_))
            .and(where.eq('cashtype', cashtype_))
            .and(where.eq('remaining', remaining_))
            .and(where.eq('dob', dob_))
            .and(where.eq('age', age_))
            .and(where.eq('amount', amount_)),
        {
          r'$pull': {
            'medinfo': {
              r'$in': [
                {fieldname: fieldvalue}
              ]
            }
          }
        });
  }

  Stream<dynamic> get oneptmedicalhistorylist async* {
    List ptmedinfolist = await allPatients
        .find(where
                .eq('ptname', ptname)
                .and(where.eq('phone', phone))
                .and(where.eq('id', id))
                // .and(where.eq('visit', visit))
                // .and(where.eq('day', day))
                // .and(where.eq('month', month))
                // .and(where.eq('year', year))
                .and(where.eq('docname', docname))
                // .and(where.eq('procedure', procedure))
                // .and(where.eq('cashtype', cashtype))
                // .and(where.eq('remaining', remaining))
                .and(where.eq('dob', dob))
                .and(where.eq('age', age))
            // .and(where.eq('amount', amount))
            )
        .toList();
    // List medinfo = await ptmedinfolist['medinfo${index}'];
    // List medinfo = await ptmedinfolist.map((event) {
    //   return event['medinfo'];
    // }).toList();

    yield ptmedinfolist;
  }

  final StreamController<dynamic> _medinfoStream = StreamController.broadcast();

  Stream<dynamic> get medinfoStream => _medinfoStream.stream;
}
