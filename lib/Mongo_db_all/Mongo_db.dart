import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:retry/retry.dart';

class Database {
  static late final Db mongo;

  static final DbCollection visits = mongo.collection('visits');
  static final DbCollection patients = mongo.collection('patients');
  static final DbCollection visitData = mongo.collection('visitdata');
  static final DbCollection doctors = mongo.collection('doctors');
  static final DbCollection appOrganizer = mongo.collection('apporganizer');
  static final DbCollection supplies = mongo.collection('supplies');
  static final DbCollection contracts = mongo.collection('contracts');
  static final DbCollection prescriptionSettings = mongo.collection(
    'prescriptionsettings',
  );
  static final DbCollection forms = mongo.collection('forms');

  static final GridFS grid = GridFS(mongo);

  static Future<void> openYaMongo() async {
    const url = String.fromEnvironment('MONGODB_URL');
    mongo = await retry<Db>(
      () => Db.create(url),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    // print('mongoURL => $url');
    await mongo.open();
    await _ensureConnection();
    if (kDebugMode) {
      // print("mongo-server-status => ${await mongo.serverStatus()}");
      print('shobeek lobeek El mongo been eidek, totlob eih??');
    }
  }

  static Future<void> _ensureConnection() async {
    if (!mongo.isConnected) {
      if (kDebugMode) {
        print('MongoDB disconnected—reconnecting...');
      }
      await mongo.close();
      await mongo.open();
      if (kDebugMode) {
        print('MongoDB reconnected');
      }
    }
  }
}
