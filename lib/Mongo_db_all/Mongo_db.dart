library mymongo;

import 'package:flutter/foundation.dart';
import 'package:proclinic_doctor_windows/errors/db_connection.dart';
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Database._();

  static Database get instance => Database._();

  static late final Db _mongo;
  static Db get mongo => _mongo;

  static Future<void> _checkforkeys() async {
    if (NetworkSettings.storage != null) {
      if (await NetworkSettings.storage?.get('ip') == null ||
          await NetworkSettings.storage?.get('ip') == 'localhost') {
        _mongo = Db('mongodb://127.0.0.1:27017/proclinic');
      } else if (await NetworkSettings.storage?.get('ip') != null) {
        _mongo = Db(
            'mongodb://${await NetworkSettings.storage?.get('ip')}:${await NetworkSettings.storage?.get('port')}/proclinic');
      }
    }
    // return _mongo;
  }

  static final DbCollection _visits = mongo.collection('visits');
  static final DbCollection _patients = mongo.collection('patients');
  static final DbCollection _visitData = mongo.collection('visitdata');
  static final DbCollection _allDoctors = mongo.collection('doctors');
  static final DbCollection _appOrganizer = mongo.collection('apporganizer');
  static final DbCollection _supplies = mongo.collection('supplies');
  static final DbCollection _contracts = mongo.collection('contracts');
  static final GridFS _grid = GridFS(mongo);

  static Future<void> openYaMongo() async {
    await _checkforkeys();
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

  DbCollection get visits => Database._visits;
  DbCollection get visitData => Database._visitData;
  DbCollection get doctors => Database._allDoctors;
  DbCollection get patients => Database._patients;
  DbCollection get supplies => Database._supplies;
  DbCollection get contracts => Database._contracts;
  DbCollection get appOrganizer => Database._appOrganizer;
  GridFS get gird => Database._grid;
}
