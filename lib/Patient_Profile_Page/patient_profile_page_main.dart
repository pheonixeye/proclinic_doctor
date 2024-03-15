import 'dart:math' show Random;

import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/manual_entry_page.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/paperwork_page/paperwork_page.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/previous_visits/previous_visit.dart';
import 'package:flutter/material.dart';

class PatientProfilePage extends StatefulWidget {
  final bool fromnew;
  const PatientProfilePage({
    super.key,
    this.fromnew = false,
  });
  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> items = (widget.fromnew == true)
        ? [
            BottomNavigationBarItem(
              backgroundColor: Colors.grey[Random.secure().nextInt(700)],
              label: "Today's Visit",
              activeIcon: const Icon(Icons.person_add),
              icon: const Icon(
                Icons.today_rounded,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.grey[Random.secure().nextInt(700)],
              label: "Previous Visits",
              activeIcon: const Icon(Icons.person_search),
              icon: const Icon(
                Icons.photo_size_select_large,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.grey[Random.secure().nextInt(700)],
              activeIcon: const Icon(Icons.data_usage),
              label: "Paper Work",
              icon: const Icon(
                Icons.scanner_rounded,
              ),
            ),
          ]
        : [
            BottomNavigationBarItem(
              backgroundColor: Colors.grey[Random.secure().nextInt(700)],
              label: "Previous Visits",
              activeIcon: const Icon(Icons.person_search),
              icon: const Icon(
                Icons.photo_size_select_large,
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.grey[Random.secure().nextInt(700)],
              activeIcon: const Icon(Icons.data_usage),
              label: "Paper Work",
              icon: const Icon(
                Icons.scanner_rounded,
              ),
            ),
          ];
    final List<Widget> scaffoldBodyWidgets = (widget.fromnew == true)
        ? [
            const EntryPageByDoctor(),
            const PreviousVisitsPage(),
            const PaperWorkPage(),
          ]
        : [
            const PreviousVisitsPage(),
            const PaperWorkPage(),
          ];
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Patient Profile Page',
              textScaler: TextScaler.linear(2.0),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: scaffoldBodyWidgets[currentindex],
          bottomNavigationBar: BottomNavigationBar(
            mouseCursor: MouseCursor.uncontrolled,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedIconTheme: Theme.of(context)
                .iconTheme
                .copyWith(size: 50, color: Colors.blue),
            unselectedItemColor: Colors.grey[900],
            selectedItemColor: Colors.blue,
            selectedFontSize: 24,
            iconSize: 30,
            elevation: 10,
            type: BottomNavigationBarType.shifting,
            items: items,
            currentIndex: currentindex,
            onTap: (int index) {
              setState(() {
                currentindex = index;
              });
            },
          ),
        );
      },
    );
  }
}
