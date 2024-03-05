import 'package:proclinic_doctor_windows/BookKeeping_Page/bookkeeping_page.dart';
import 'package:proclinic_doctor_windows/Find_Patients_page/find_patients_page.dart';
import 'package:proclinic_doctor_windows/Login_screen/login_page.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/today_patients_page/today_patients_page.dart';
import 'package:proclinic_doctor_windows/control_panel/popupbutton_logout_settings.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:provider/provider.dart';

class ControlPanelPage extends StatefulWidget {
  final String? docname;

  const ControlPanelPage({Key? key, this.docname}) : super(key: key);
  @override
  _ControlPanelPageState createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage>
    with TickerProviderStateMixin {
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopUpButtonLogOutSettings(
          callSettings: callSettings,
          callLogout: callLogout,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
              onPressed: () {
                //TODO: refetch data??
                setState(() {});
              },
            ),
          )
        ],
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
          FindPatients(),
          BookKeepingPage()
        ],
      ),
    );
  }
}
