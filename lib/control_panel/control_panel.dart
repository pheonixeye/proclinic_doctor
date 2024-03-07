import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/BookKeeping_Page/bookkeeping_page.dart';
import 'package:proclinic_doctor_windows/search_patients_under/search_patients_under.dart';
import 'package:proclinic_doctor_windows/Login_screen/login_page.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/today_patients_page/today_patients_page.dart';
import 'package:proclinic_doctor_windows/control_panel/popupbutton_logout_settings.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:provider/provider.dart';

class ControlPanelPage extends StatefulWidget {
  const ControlPanelPage({Key? key}) : super(key: key);
  @override
  _ControlPanelPageState createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage>
    with TickerProviderStateMixin, AfterLayoutMixin {
  late final TabController _tabController;
  final d = DateTime.now();

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );

    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxVisits>().fetchVisits(
          docname: context.read<PxSelectedDoctor>().doctor!.docnameEN,
          type: QueryType.Today,
        );
  }

  void callSettings() {
    Navigator.pushNamed(context, '/fields');
  }

  void callLogout() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Logout From Clinic Console ??'),
          content: const SingleChildScrollView(
            child: Text('Are You Sure ?'),
          ),
          actions: [
            ElevatedButton.icon(
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
              label: const Text('Confirm'),
              onPressed: () async {
                context.read<PxSelectedDoctor>().selectDoctor(null);
                Navigator.pop(context);
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              label: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopUpButtonLogOutSettings(
          callSettings: callSettings,
          callLogout: callLogout,
        ),
        title: Consumer<PxSelectedDoctor>(
          builder: (context, d, c) {
            return Text(
              'Dr. ${d.doctor!.docnameEN.toUpperCase()} Clinic',
              textScaler: const TextScaler.linear(2.0),
              style: const TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
        bottom: TabBar(
          onTap: (value) async {
            switch (value) {
              case 0:
                await EasyLoading.show(status: 'Loading...');
                if (context.mounted) {
                  await context.read<PxVisits>().fetchVisits(
                        docname:
                            context.read<PxSelectedDoctor>().doctor!.docnameEN,
                        type: QueryType.Today,
                      );
                }
                await EasyLoading.dismiss();
                break;
              default:
                await EasyLoading.show(status: 'Loading...');
                if (context.mounted) {
                  await context.read<PxVisits>().fetchVisits(
                        docname:
                            context.read<PxSelectedDoctor>().doctor!.docnameEN,
                        type: QueryType.All,
                      );
                }
                await EasyLoading.dismiss();
            }
          },
          controller: _tabController,
          tabs: <Tab>[
            Tab(
              icon: const Icon(Icons.person),
              text: 'Today ${d.day} - ${d.month} - ${d.year}',
            ),
            const Tab(
              icon: Icon(
                Icons.person_search,
              ),
              text: 'Find Patient',
            ),
            const Tab(
              icon: Icon(
                Icons.monetization_on,
              ),
              text: 'BookKeeping',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          TodayPatients(),
          SearchPatientsUnder(),
          BookKeepingPage()
        ],
      ),
    );
  }
}
