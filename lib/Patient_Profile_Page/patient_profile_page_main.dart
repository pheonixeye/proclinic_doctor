import 'dart:math';

import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/Manual_Data_Entry_Page.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/paperwork_page/paperwork_page.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/previous_visits/previous_visit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PatientProfilePage extends StatefulWidget {
  final bool fromnew;
  const PatientProfilePage({super.key, required this.fromnew});
  @override
  _PatientProfilePageState createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  int currentindex = 0;
  late final forwardedData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    forwardedData = ModalRoute.of(context)?.settings.arguments;
    List<BottomNavigationBarItem> _items = (widget.fromnew == true)
        ? [
            BottomNavigationBarItem(
                backgroundColor: Colors.grey[Random.secure().nextInt(700)],
                label: "Today's Visit",
                activeIcon: const Icon(Icons.person_add),
                icon: const Icon(
                  Icons.today_rounded,
                )),
            BottomNavigationBarItem(
                backgroundColor: Colors.grey[Random.secure().nextInt(700)],
                label: "Previous Visits",
                activeIcon: const Icon(Icons.person_search),
                icon: const Icon(
                  Icons.photo_size_select_large,
                )),
            BottomNavigationBarItem(
                backgroundColor: Colors.grey[Random.secure().nextInt(700)],
                activeIcon: const Icon(Icons.data_usage),
                label: "Paper Work",
                icon: const Icon(
                  Icons.scanner_rounded,
                )),
          ]
        : [
            BottomNavigationBarItem(
                backgroundColor: Colors.grey[Random.secure().nextInt(700)],
                label: "Previous Visits",
                activeIcon: const Icon(Icons.person_search),
                icon: const Icon(
                  Icons.photo_size_select_large,
                )),
            BottomNavigationBarItem(
                backgroundColor: Colors.grey[Random.secure().nextInt(700)],
                activeIcon: const Icon(Icons.data_usage),
                label: "Paper Work",
                icon: const Icon(
                  Icons.scanner_rounded,
                )),
          ];
    List<Widget> _scaffoldBodyWidgets = (widget.fromnew == true)
        ? [
            EntryPageByDoctor(),
            PreviousVisitsPage(),
            PaperWorkPage(
              ptname: forwardedData['ptname'],
              phone: forwardedData['phone'],
              docname: forwardedData['docname'],
              day: forwardedData['day'],
              month: forwardedData['month'],
              year: forwardedData['year'],
              id: forwardedData['id'],
            ),
          ]
        : [
            PreviousVisitsPage(),
            PaperWorkPage(
              ptname: forwardedData['ptname'],
              phone: forwardedData['phone'],
              docname: forwardedData['docname'],
              day: forwardedData['day'],
              month: forwardedData['month'],
              year: forwardedData['year'],
              id: forwardedData['id'],
            ),
          ];
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Patient Profile Page',
                  textScaleFactor: 2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              body: _scaffoldBodyWidgets[currentindex],
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
                items: _items,
                currentIndex: currentindex,
                onTap: (int index) {
                  setState(() {
                    currentindex = index;
                  });
                },
              ));
        });
  }
}
