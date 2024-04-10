import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:provider/provider.dart';

class CustomSettingsNavDrawer extends StatefulWidget {
  const CustomSettingsNavDrawer({super.key});

  @override
  State<CustomSettingsNavDrawer> createState() =>
      _CustomSettingsNavDrawerState();
}

class _CustomSettingsNavDrawerState extends State<CustomSettingsNavDrawer> {
  @override
  void initState() {
    super.initState();
  }

  ButtonStyle _btnTheme(String routeName) {
    final name = ModalRoute.of(context)?.settings.name;
    if (routeName == name) {
      return ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
      );
    } else {
      return ElevatedButton.styleFrom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: Card(
        child: ListView(
          children: [
            //avatar
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.person_pin,
                size: 180,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<PxSelectedDoctor>(
                    builder: (context, d, c) {
                      return Text(
                        'Dr. ${d.doctor!.docnameEN.toUpperCase()} Clinic',
                        textScaler: const TextScaler.linear(2.0),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(
                color: Colors.blueGrey,
                thickness: 5,
                height: 10,
              ),
            ),
            //fields and layout
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: _btnTheme('/fields'),
                icon: const Icon(Icons.layers_outlined),
                label: const Text('Fields & Layout'),
                onPressed: () {
                  const newRouteName = "/fields";
                  bool isNewRouteSameAsCurrent = false;

                  Navigator.popUntil(context, (route) {
                    if (route.settings.name == newRouteName) {
                      isNewRouteSameAsCurrent = true;
                    }
                    Navigator.pop(context);
                    return true;
                  });

                  if (!isNewRouteSameAsCurrent) {
                    Navigator.popAndPushNamed(context, newRouteName);
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(
                color: Colors.blueGrey,
                thickness: 5,
                height: 10,
              ),
            ),
            //drugs and prescriptions
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: _btnTheme('/drugs'),
                icon: const Icon(Icons.local_pharmacy),
                label: const Text('Drugs & Prescriptions'),
                onPressed: () {
                  const newRouteName = "/drugs";
                  bool isNewRouteSameAsCurrent = false;

                  Navigator.popUntil(context, (route) {
                    if (route.settings.name == newRouteName) {
                      isNewRouteSameAsCurrent = true;
                    }
                    Navigator.pop(context);
                    return true;
                  });

                  if (!isNewRouteSameAsCurrent) {
                    Navigator.popAndPushNamed(context, newRouteName);
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(
                color: Colors.blueGrey,
                thickness: 5,
                height: 10,
              ),
            ),
            //labs and rads
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: _btnTheme('/labsrads'),
                icon: const Icon(Icons.home_repair_service),
                label: const Text('Labs & Rads'),
                onPressed: () {
                  const newRouteName = "/labsrads";
                  bool isNewRouteSameAsCurrent = false;

                  Navigator.popUntil(context, (route) {
                    if (route.settings.name == newRouteName) {
                      isNewRouteSameAsCurrent = true;
                    }
                    Navigator.pop(context);
                    return true;
                  });

                  if (!isNewRouteSameAsCurrent) {
                    Navigator.popAndPushNamed(context, newRouteName);
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(
                color: Colors.blueGrey,
                thickness: 5,
                height: 10,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: _btnTheme('/clinicdetails'),
                icon: const Icon(Icons.details),
                label: const Text('Clinic Details'),
                onPressed: () {
                  const newRouteName = "/clinicdetails";
                  bool isNewRouteSameAsCurrent = false;

                  Navigator.popUntil(context, (route) {
                    if (route.settings.name == newRouteName) {
                      isNewRouteSameAsCurrent = true;
                    }
                    Navigator.pop(context);
                    return true;
                  });

                  if (!isNewRouteSameAsCurrent) {
                    Navigator.popAndPushNamed(context, newRouteName);
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(
                color: Colors.blueGrey,
                thickness: 5,
                height: 10,
              ),
            ),
            //control panel (back nav)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: _btnTheme('/controlpanel'),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Control Panel'),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName('/controlpanel'));
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(
                color: Colors.blueGrey,
                thickness: 5,
                height: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
