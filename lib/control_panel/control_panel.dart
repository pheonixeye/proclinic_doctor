import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/BookKeeping_Page/bookkeeping_page.dart';
import 'package:proclinic_doctor_windows/control_panel/notifier_popupmenu_btn.dart';
import 'package:proclinic_doctor_windows/providers/notification_provider.dart';
import 'package:proclinic_doctor_windows/providers/prescription_settings_provider.dart';
import 'package:proclinic_doctor_windows/providers/socket_provider.dart';
import 'package:proclinic_doctor_windows/providers/supplies_provider.dart';
import 'package:proclinic_doctor_windows/search_patients_under/search_patients_under.dart';
import 'package:proclinic_doctor_windows/Login_screen/login_page.dart';
import 'package:proclinic_doctor_windows/today_patients_page/today_patients_page.dart';
import 'package:proclinic_doctor_windows/control_panel/popupbutton_logout_settings.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:proclinic_doctor_windows/widgets/notification_card.dart';
import 'package:provider/provider.dart';

class ControlPanelPage extends StatefulWidget {
  const ControlPanelPage({Key? key}) : super(key: key);
  @override
  State<ControlPanelPage> createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage>
    with TickerProviderStateMixin, AfterLayoutMixin {
  late final TabController _tabController;
  final d = DateTime.now();

  void _onLogout() {
    context.read<PxSocketProvider>().disconnect(context);
    context.read<PxPrescriptionSettings>().onLogout();
    context.read<PxSupplies>().onLogout();
    context.read<PxSelectedDoctor>().onLogout();
    if (kDebugMode) {
      print("ControlPanel()._onLogout()");
    }
  }

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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxVisits>().fetchVisits(
          type: QueryType.Today,
        );
    if (context.mounted) {
      context.read<PxSocketProvider>().listenToSocket(context);
    }
    if (context.mounted) {
      await context.read<PxPrescriptionSettings>().init;
    }
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
              onPressed: () {
                Navigator.pop(context);
                _onLogout();
                Navigator.pushReplacement(
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
        actions: [
          Builder(
            builder: (context) {
              return IconButton.filled(
                tooltip: "Notifications - التنبيهات",
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(Icons.notifications),
              );
            },
          ),
          const SizedBox(
            width: 20,
          ),
          Consumer<PxSocketProvider>(
            builder: (context, s, _) {
              while (s.isConnected) {
                return IconButton.filled(
                  tooltip: 'Notification Service Online, Disconnect.',
                  onPressed: () async {
                    await EasyLoading.show(status: "Loading...");
                    if (context.mounted) {
                      s.disconnect(context);
                    }
                    await EasyLoading.dismiss();
                  },
                  icon: const Icon(Icons.wifi_rounded),
                );
              }
              return IconButton.outlined(
                tooltip: "Notifications Service Offline, Try Again.",
                onPressed: () async {
                  await EasyLoading.show(status: "Loading...");
                  if (context.mounted) {
                    await s.initSocketConnection(context);
                  }
                  await EasyLoading.dismiss();
                },
                icon: const Icon(Icons.wifi_off),
              );
            },
          ),
          const SizedBox(
            width: 20,
          ),
          const NotifierPopupMenuBtn(),
          const SizedBox(
            width: 20,
          ),
        ],
        title: Consumer<PxSelectedDoctor>(
          builder: (context, d, c) {
            while (d.doctor == null) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
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
                        type: QueryType.Today,
                      );
                }
                await EasyLoading.dismiss();
                break;
              default:
                await EasyLoading.show(status: 'Loading...');
                if (context.mounted) {
                  await context
                      .read<PxVisits>()
                      .fetchVisits(type: QueryType.All);
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
      endDrawer: Builder(
        builder: (context) {
          return Container(
            width: 350,
            decoration: BoxDecoration(
              border: const Border.symmetric(),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(3, 3),
                  blurRadius: 3,
                  spreadRadius: 3,
                  color: ThemeConstants.randomShadowColor,
                ),
              ],
            ),
            child: Card(
              elevation: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Card(
                          elevation: 8,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Notifications",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton.filled(
                          tooltip:
                              "delete all notifications - الغاء كل التنبيهات",
                          onPressed: () async {
                            await EasyLoading.show(status: "Loading...");
                            if (context.mounted) {
                              await context
                                  .read<PxAppNotifications>()
                                  .deleteAllNotifications();
                            }
                            await EasyLoading.dismiss();
                          },
                          icon: const Icon(Icons.clear_all),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: Consumer<PxAppNotifications>(
                      builder: (context, n, _) {
                        while (n.notifications.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('No Notifications Found.'),
                                ),
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: n.notifications.length,
                          itemBuilder: (context, index) {
                            final item = n.notifications[index];
                            return NotificationCard(
                              index: index,
                              item: item,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
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
