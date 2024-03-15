library mymongo;

import 'package:flutter/foundation.dart';
import 'package:proclinic_doctor_windows/errors/db_connection.dart';
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Database._();

  static Database get instance => Database._();

  static final Db _mongo = _checkforkeys();
  static Db get mongo => _mongo;

  static Db _checkforkeys() {
    Db? m;
    if (NetworkSettings.storage == null) {
      NetworkSettings.init().whenComplete(() {
        if (NetworkSettings.storage?.get('ip') == null ||
            NetworkSettings.storage?.get('ip') == 'localhost') {
          m = Db('mongodb://127.0.0.1:27017/proclinic');
        } else if (NetworkSettings.storage?.get('ip') != null) {
          m = Db(
              'mongodb://${NetworkSettings.storage?.get('ip')}:${NetworkSettings.storage?.get('port')}/proclinic');
        }
      });
    }
    return m ?? Db('mongodb://127.0.0.1:27017/proclinic');
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
      if (kDebugMode) {
        print('shobeek lobeek El mongo been eidek, totlob eih??');
      }
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
