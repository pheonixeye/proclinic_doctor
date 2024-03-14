import 'dart:math' show Random;

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Loading_screen/loading_screen.dart';
import 'package:proclinic_doctor_windows/control_panel/clinic_details_page/clinic_details_page.dart';
// import 'package:proclinic_doctor_windows/Mongo_db_all/Mongo_db.dart';
import 'package:proclinic_doctor_windows/control_panel/control_panel.dart';
import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/add_drugs_page_UI.dart';
import 'package:proclinic_doctor_windows/control_panel/labs_rads_settings_page/labs_rads_Settings_UI.dart';
import 'package:proclinic_doctor_windows/control_panel/settings_page.dart';

import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/_main.dart';
import 'package:proclinic_doctor_windows/scroll/scroll_behaviour.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: 'ProClinic Doctors',
          builder: EasyLoading.init(),
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: Colors.blueGrey,
            primarySwatch: Colors.orange,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            cardTheme: CardTheme(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              shadowColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
            ),
            appBarTheme: const AppBarTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              centerTitle: true,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          darkTheme: ThemeData.dark(),
          home: const LoadingScreen(),
          routes: {
            '/fields': (context) => const FieldCreationPage(),
            '/drugs': (context) => const AddDrugsPage(),
            '/controlpanel': (context) => const ControlPanelPage(),
            '/labsrads': (context) => const LabsAndRadsSettingsPage(),
            '/clinicdetails': (context) => const ClinicDetailsPage(),
          },
        );
      },
    );
  }
}
