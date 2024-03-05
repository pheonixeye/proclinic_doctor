import 'dart:io';
import 'package:proclinic_doctor_windows/get_mac_adress_fns/wrong_mac_adress_page/wrong_mac_UI.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Future runshellmac(BuildContext context) async {
  // final macadr = LocalStorage('macadr');
  Hive.init('assets\\internals.hive');
  Box boxInternals = await Hive.openBox('internals');
  // await macadr.ready;
  ProcessResult netadapter = await Process.runSync('powershell.exe', [
    r'$CurrMac = get-netadapter | where {$_.name -ceq "Ethernet"}'
        '\n'
        r'$CurrMacAddr = $CurrMac.MacAddress'
        '\n'
        r'$CurrMacAddr'
  ]);
  if (await boxInternals.isEmpty) {
    await runscript().then((value) {
      boxInternals.put('macadr', value);
    });
    print(boxInternals.get('macadr'));
    // await macadr.setItem('macadr', netadapter.stdout);
  } else if (await boxInternals.get('macadr') != netadapter.stdout) {
    print('wrong address ${netadapter.stdout}');
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const WrongMacAddrPage()));
  } else if (await boxInternals.get('macadr') == netadapter.stdout) {
    print('true address ${netadapter.stdout}');

    // await Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => WrongMacAddrPage()));
  }
  await boxInternals.close();
}

Future runscript() async {
  var netadapter = await Process.runSync('powershell.exe', [
    r'$CurrMac = get-netadapter | where {$_.name -ceq "Ethernet"}'
        '\n'
        r'$CurrMacAddr = $CurrMac.MacAddress'
        '\n'
        r'$CurrMacAddr'
  ]);
  return netadapter.stdout;
}
