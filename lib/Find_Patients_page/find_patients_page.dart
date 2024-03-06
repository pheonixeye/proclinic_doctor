import 'package:proclinic_doctor_windows/Find_Patients_page/all_patients_under/all_patients_under_page.dart';
import 'package:proclinic_doctor_windows/Find_Patients_page/search_patients_under/search_patients_under.dart';
import 'package:flutter/material.dart';

class FindPatients extends StatefulWidget {
  const FindPatients({super.key});

  @override
  _FindPatientsState createState() => _FindPatientsState();
}

class _FindPatientsState extends State<FindPatients>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              title: TabBar(
                controller: _tabController,
                tabs: const <Tab>[
                  Tab(
                    icon: Icon(
                      Icons.person_pin,
                    ),
                    text: 'All Patients',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person_search,
                    ),
                    text: 'Search Patients',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: const <Widget>[
                AllPatientsUnder(),
                SearchPatientsUnder(),
              ],
            ),
          ),
        );
      },
    );
  }
}
