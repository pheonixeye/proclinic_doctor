library mymongo;

import 'package:flutter/foundation.dart';
import 'package:proclinic_doctor_windows/errors/db_connection.dart';
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Database._();

  factory Database._instance() => Database._();

  static Database get instance => Database._instance();

  static late final Db _mongo;
  static Db get mongo => _mongo;

  static Future<void> _checkforkeys() async {
    await NetworkSettings.init().then((_) async {
      if (NetworkSettings.storage != null) {
        if (await NetworkSettings.storage?.get('ip') == null ||
            await NetworkSettings.storage?.get('ip') == 'localhost') {
          _mongo = Db('mongodb://127.0.0.1:27017/proclinic');
        } else if (await NetworkSettings.storage?.get('ip') != null) {
          _mongo = Db(
              'mongodb://${await NetworkSettings.storage?.get('ip')}:${await NetworkSettings.storage?.get('port')}/proclinic');
        } else {
          throw MongoDbConnectionException(message: 'Initialization Error.');
        }
      }
    });
    // return _mongo;
  }

  final DbCollection _visits = mongo.collection('visits');
  final DbCollection _patients = mongo.collection('patients');
  final DbCollection _visitData = mongo.collection('visitdata');
  final DbCollection _allDoctors = mongo.collection('doctors');
  final DbCollection _appOrganizer = mongo.collection('apporganizer');
  final DbCollection _supplies = mongo.collection('supplies');
  final DbCollection _contracts = mongo.collection('contracts');
  final DbCollection _prescriptionSettings =
      mongo.collection('prescriptionsettings');

  final GridFS _grid = GridFS(mongo);

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
    }
  }

  DbCollection get visits => _visits;
  DbCollection get visitData => _visitData;
  DbCollection get doctors => _allDoctors;
  DbCollection get patients => _patients;
  DbCollection get supplies => _supplies;
  DbCollection get contracts => _contracts;
  DbCollection get appOrganizer => _appOrganizer;
  DbCollection get prescriptionSettings => _prescriptionSettings;
  GridFS get gird => _grid;
}
