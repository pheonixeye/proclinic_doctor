library mymongo;

import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Database._();

  static get instance => Database._();

  static final Db _mongo = _checkforkeys();
  static Db get mongo => _mongo;

  static Db _checkforkeys() {
    Db? _m;
    NetworkSettings.storage.ready.then((value) {
      if (NetworkSettings.storage.getItem('ip') == null ||
          NetworkSettings.storage.getItem('ip') == 'localhost') {
        _m = Db('mongodb://localhost/proclinic');
      } else if (NetworkSettings.storage.getItem('ip') != null) {
        _m = Db(
            'mongodb://${NetworkSettings.storage.getItem('ip')}:${NetworkSettings.storage.getItem('port')}/proclinic');
      }
      print('keys checked');
    });
    return _m ?? Db('mongodb://localhost/proclinic');
  }

  static final DbCollection _allPatients = mongo.collection('allpatients');
  static final DbCollection _allDoctors = mongo.collection('allDoctors');
  static final DbCollection _appOrganizer = mongo.collection('apporganizer');

  static Future<void> openYaMongo() async {
    if (mongo != null) {
      if (mongo.state == State.opening) {
        await mongo.close();
      }
    }
    // await _checkforkeys();
    await mongo.open();
    if (!mongo.masterConnection.connected) {
      await mongo.masterConnection.connect();
    }

    print('shobeek lobeek El mongo been eidek, totlob eih??');
  }
}

DbCollection allPatients = Database._allPatients;
DbCollection allDoctors = Database._allDoctors;
DbCollection appOrganizer = Database._appOrganizer;
