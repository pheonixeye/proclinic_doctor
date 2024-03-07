library mymongo;

import 'package:proclinic_doctor_windows/errors/db_connection.dart';
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Database._();

  static Database get instance => Database._();

  static final Db _mongo = _checkforkeys();
  static Db get mongo => _mongo;

  static Db _checkforkeys() {
    Db? _m;
    NetworkSettings.storage.ready.then((value) {
      if (NetworkSettings.storage.getItem('ip') == null ||
          NetworkSettings.storage.getItem('ip') == 'localhost') {
        _m = Db('mongodb://127.0.0.1:27017/proclinic');
      } else if (NetworkSettings.storage.getItem('ip') != null) {
        _m = Db(
            'mongodb://${NetworkSettings.storage.getItem('ip')}:${NetworkSettings.storage.getItem('port')}/proclinic');
      }
      print('keys checked');
    });
    return _m ?? Db('mongodb://127.0.0.1:27017/proclinic');
  }

  static final DbCollection _allPatients = mongo.collection('patients');
  static final DbCollection _visitData = mongo.collection('visitdata');
  static final DbCollection _allDoctors = mongo.collection('allDoctors');
  static final DbCollection _appOrganizer = mongo.collection('apporganizer');

  static Future<void> openYaMongo() async {
    if (mongo.state == State.opening) {
      await mongo.close();
    }
    try {
      await mongo.open();
      if (!mongo.masterConnection.connected) {
        await mongo.masterConnection.connect();
      }
      print('shobeek lobeek El mongo been eidek, totlob eih??');
    } catch (e) {
      throw MongoDbConnectionException(message: e.toString());
      // return false;
    }
    // await _checkforkeys();
  }

  DbCollection get allPatients => Database._allPatients;
  DbCollection get visitData => Database._visitData;
  DbCollection get allDoctors => Database._allDoctors;
  DbCollection get appOrganizer => Database._appOrganizer;
}
