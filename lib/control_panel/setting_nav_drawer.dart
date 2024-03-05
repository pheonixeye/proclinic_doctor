import 'dart:math';

import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';

class CustomSettingsNavDrawer extends StatefulWidget {
  const CustomSettingsNavDrawer({super.key});

  @override
  _CustomSettingsNavDrawerState createState() =>
      _CustomSettingsNavDrawerState();
}

class _CustomSettingsNavDrawerState extends State<CustomSettingsNavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white54.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors
                      .primaries[Random().nextInt(Colors.primaries.length)],
                  offset: const Offset(5, 5),
                  blurRadius: 5,
                  spreadRadius: 5),
            ]),
        child: Column(
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
                  child: Text(
                    'Dr. ${globallySelectedDoctor.toUpperCase()} Clinic',
                    textScaleFactor: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
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
            //control panel (back nav)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
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
