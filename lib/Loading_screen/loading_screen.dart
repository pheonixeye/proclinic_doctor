import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:proclinic_doctor_windows/Login_screen/login_page.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/Not_Connected_To_Db/not_connected_db.dart';
import 'package:proclinic_doctor_windows/functions/print_logic.dart';
import 'package:proclinic_doctor_windows/get_mac_adress_fns/get_mac_adress.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/theme_changer.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with AfterLayoutMixin {
  @override
  void initState() {
    runshellmac(context);
    super.initState();
    PdfPrinter.init();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await Database.openYaMongo().then((_) {
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
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, t, _) {
        return Scaffold(
          backgroundColor:
              t.currentTheme == ThemeMode.dark ? null : Colors.blue.shade400,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: const Card(
                elevation: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/color.png'),
                      width: 400,
                      height: 400,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Custom Integrated \nClinic Management Systems : \nProClinic v1.5',
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
            ),
          ),
        );
      },
    );
  }
}
