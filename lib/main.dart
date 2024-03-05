import 'package:proclinic_doctor_windows/Loading_screen/loading_screen.dart';
// import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:proclinic_doctor_windows/control_panel/control_panel.dart';
import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/add_drugs_page_UI.dart';
import 'package:proclinic_doctor_windows/control_panel/labs_rads_settings_page/labs_rads_Settings_UI.dart';
import 'package:proclinic_doctor_windows/control_panel/settings_page.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  // await checkforkeys();
  runApp(const Prodoctor());
}

class Prodoctor extends StatelessWidget {
  const Prodoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProClinic Doctors',
      theme: ThemeData(
          primaryColor: Colors.blueGrey,
          primarySwatch: Colors.orange,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          )),
      darkTheme: ThemeData.dark(),
      home: LoadingScreen(),
      routes: {
        '/fields': (context) => const FieldCreationPage(),
        '/drugs': (context) => const AddDrugsPage(),
        '/controlpanel': (context) => const ControlPanelPage(),
        '/labsrads': (context) => const LabsAndRadsSettingsPage(),
      },
    );
  }
}
