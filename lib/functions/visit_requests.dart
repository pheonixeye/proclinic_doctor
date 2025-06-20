import 'package:mongo_dart/mongo_dart.dart';
import 'package:proclinic_doctor/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_models/proclinic_models.dart';

class VisitRequests {
  static Future<Visit?> fetchVisitById(String oid) async {
    final result = await Database.visits.findOne(
      where.eq("_id", ObjectId.fromHexString(oid)),
    );
    if (result != null) {
      final visit = Visit.fromJson(result);
      return visit;
    } else {
      return null;
    }
  }
}
