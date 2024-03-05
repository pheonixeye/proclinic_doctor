import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DRLadder {
  Future addDRL(
      {String? id,
      docName,
      clinic,
      ptName,
      phone,
      year,
      month,
      day,
      visit,
      procedure,
      amount,
      dob,
      age,
      remaining,
      cashtype,
      fieldname,
      fieldvalue}) async {
    await allPatients.update(
        where
            .eq('ptname', ptName)
            .and(where.eq('phone', phone))
            .and(where.eq('id', id))
            .and(where.eq('visit', visit))
            .and(where.eq('day', day))
            .and(where.eq('month', month))
            .and(where.eq('year', year))
            .and(where.eq('docname', docName))
            .and(where.eq('procedure', procedure))
            .and(where.eq('cashtype', cashtype))
            .and(where.eq('remaining', remaining))
            .and(where.eq('dob', dob))
            .and(where.eq('age', age))
            .and(where.eq('amount', amount)),
        {
          r'$addToSet': {fieldname: fieldvalue}
        });
  }

  Future deleteDRL(
      {String? id,
      docName,
      clinic,
      ptName,
      phone,
      year,
      month,
      day,
      visit,
      procedure,
      amount,
      dob,
      age,
      remaining,
      cashtype,
      fieldname,
      fieldvalue}) async {
    await allPatients.update(
        where
            .eq('ptname', ptName)
            .and(where.eq('phone', phone))
            .and(where.eq('id', id))
            .and(where.eq('visit', visit))
            .and(where.eq('day', day))
            .and(where.eq('month', month))
            .and(where.eq('year', year))
            .and(where.eq('docname', docName))
            .and(where.eq('procedure', procedure))
            .and(where.eq('cashtype', cashtype))
            .and(where.eq('remaining', remaining))
            .and(where.eq('dob', dob))
            .and(where.eq('age', age))
            .and(where.eq('amount', amount)),
        {
          r'$pull': {
            fieldname: {
              r'$in': [fieldvalue]
            }
          }
        });
  }
}
