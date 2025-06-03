import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Loading_screen/loading_screen.dart';
import 'package:proclinic_doctor_windows/Mongo_db_all/mongo_db.dart';
import 'package:proclinic_doctor_windows/control_panel/clinic_details_page/clinic_details_page.dart';
import 'package:proclinic_doctor_windows/control_panel/control_panel.dart';
import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/drugs_procedures_page.dart';
import 'package:proclinic_doctor_windows/control_panel/labs_rads_settings_page/labs_rads_settings.dart';
import 'package:proclinic_doctor_windows/control_panel/prescription_settings/prescription_settings.dart';
import 'package:proclinic_doctor_windows/control_panel/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/main_init.dart';
import 'package:proclinic_doctor_windows/providers/_main.dart';
import 'package:proclinic_doctor_windows/providers/theme_changer.dart';
import 'package:proclinic_doctor_windows/scroll/scroll_behaviour.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //todo: IMPLEMENT TWO WAY NOTIFICATIONS
  //todo: ADD MODELS PACKAGE
  await initHive();

  initTheme();

  await Database.openYaMongo();

  runApp(const AppProvider());

  initSound();

  // await _initSocket();
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: providers, child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeChanger>(
      builder: (context, t, _) {
        return MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: 'ProClinic Doctors',
          builder: EasyLoading.init(),
          theme: theme.light(),
          darkTheme: theme.dark(),
          themeMode: t.currentTheme,
          home: const LoadingScreen(),
          routes: {
            '/fields': (context) => const FieldCreationPage(),
            '/drugs': (context) => const DrugsAndProceduresPage(),
            '/controlpanel': (context) => const ControlPanelPage(),
            '/labsrads': (context) => const LabsAndRadsSettingsPage(),
            '/clinicdetails': (context) => const ClinicDetailsPage(),
            '/prescriptionsettings': (context) =>
                const PrescriptionSettingsPage(),
          },
        );
      },
    );
  }
}
