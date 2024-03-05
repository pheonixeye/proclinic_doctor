import 'dart:async' show Timer;

import 'package:proclinic_doctor_windows/Login_screen/login_Page.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:proclinic_doctor_windows/Not_Connected_To_Db/not_connected_db.dart';
import 'package:proclinic_doctor_windows/get_mac_adress_fns/get_mac_adress.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    runshellmac(context);
    super.initState();
    Database.openYaMongo().then((value) {
      Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage(),
          ),
        ),
      );
    }).catchError((e) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => NoDBConnectionPage(
                    error: e.toString(),
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[500],
      body: Container(
        alignment: Alignment.center,
        color: Colors.white70.withOpacity(0.3),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/color.png'),
              width: 500,
              height: 500,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Custom Integrated \nClinic Management Systems : \nProClinic v1.0',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('\n \n \n by Dr.Kareem Zaher'),
              ],
            ),
            Image(
              image: AssetImage('assets/loading.gif'),
              width: 300,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
