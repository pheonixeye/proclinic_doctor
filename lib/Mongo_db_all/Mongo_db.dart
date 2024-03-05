library mymongo;

import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:mongo_dart/mongo_dart.dart';

NetworkSettings netset = NetworkSettings();

Future checkforkeys() async {
  await NetworkSettings.storage.ready;

  if (NetworkSettings.storage.getItem('ip') == null ||
      NetworkSettings.storage.getItem('ip') == 'localhost') {
    mongo = Db('mongodb://localhost/proclinic');
  } else if (NetworkSettings.storage.getItem('ip') != null) {
    mongo = Db(
        'mongodb://${await NetworkSettings.storage.getItem('ip')}:${await NetworkSettings.storage.getItem('port')}/proclinic');
  }
  print('keys checked');
}

late final Db? mongo;
// netset.storage.stream.isEmpty != null
// ?
// Db('mongodb://localhost/proclinic');
// :
//  Db('mongodb://${netset.ip}:${netset.port}/proclinic');

DbCollection allPatients = mongo!.collection('allpatients');
DbCollection allDoctors = mongo!.collection('allDoctors');
DbCollection appOrganizer = mongo!.collection('apporganizer');

Future openYaMongo() async {
  if (mongo != null) {
    if (mongo!.state == State.opening) {
      await mongo!.close();
    }
  }
  await checkforkeys();
  await mongo!.open();
  await mongo!.isConnected;
  await mongo!.masterConnection.connected;
  if (!mongo!.masterConnection.connected) {
    mongo!.masterConnection.connect();
  }

  print('shobeek lobeek El mongo been eidek, totlob eih??');
}
