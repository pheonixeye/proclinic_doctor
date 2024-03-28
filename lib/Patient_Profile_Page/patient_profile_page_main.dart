import 'dart:math' show Random;

import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/manual_entry_page.dart';
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
  List<BottomNavigationBarItem> _items(bool fromNew) => [
        if (fromNew == true)
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
      ];
  List<Widget> _scaffoldBodyWidgets(bool fromNew) => [
        if (fromNew == true) const EntryPageByDoctor(),
        const PreviousVisitsPage(),
      ];

  BottomNavigationBar? _buildBar(bool fromNew) {
    if (fromNew) {
      return BottomNavigationBar(
        mouseCursor: MouseCursor.uncontrolled,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedIconTheme:
            Theme.of(context).iconTheme.copyWith(size: 50, color: Colors.blue),
        unselectedItemColor: Colors.grey[900],
        selectedItemColor: Colors.blue,
        selectedFontSize: 24,
        iconSize: 30,
        elevation: 10,
        type: BottomNavigationBarType.shifting,
        items: _items(widget.fromnew),
        currentIndex: currentindex,
        onTap: (int index) {
          setState(() {
            currentindex = index;
          });
        },
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Patient Profile Page',
              textScaler: TextScaler.linear(1.4),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: _scaffoldBodyWidgets(widget.fromnew)[currentindex],
          bottomNavigationBar: _buildBar(widget.fromnew),
        );
      },
    );
  }
}
