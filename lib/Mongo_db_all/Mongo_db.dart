// library mymongo;

import 'package:flutter/foundation.dart';
import 'package:proclinic_doctor_windows/errors/db_connection.dart';
// import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Database._();

  factory Database._instance() => Database._();

  static Database get instance => Database._instance();

  static late final Db mongo;

  final DbCollection _visits = mongo.collection('visits');
  final DbCollection _patients = mongo.collection('patients');
  final DbCollection _visitData = mongo.collection('visitdata');
  final DbCollection _allDoctors = mongo.collection('doctors');
  final DbCollection _appOrganizer = mongo.collection('apporganizer');
  final DbCollection _supplies = mongo.collection('supplies');
  final DbCollection _contracts = mongo.collection('contracts');
  final DbCollection _prescriptionSettings = mongo.collection(
    'prescriptionsettings',
  );
  final DbCollection forms = mongo.collection('forms');

  final GridFS _grid = GridFS(mongo);

  static Future<void> openYaMongo() async {
    try {
      mongo = await Db.create(const String.fromEnvironment('MONGODB_URL'));
      await mongo.open();
      await _ensureConnection();
      if (kDebugMode) {
        print('shobeek lobeek El mongo been eidek, totlob eih??');
      }
    } catch (e) {
      throw MongoDbConnectionException(message: e.toString());
    }
  }

  static Future<void> _ensureConnection() async {
    if (!mongo.isConnected) {
      print('MongoDB disconnected—reconnecting...');
      await mongo.close();
      await mongo.open();
      print('MongoDB reconnected');
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
