import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/medical_info_page.dart';

import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/prescription_page.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:provider/provider.dart';

class EntryPageByDoctor extends StatefulWidget {
  const EntryPageByDoctor({super.key});

  @override
  State<EntryPageByDoctor> createState() => _EntryPageByDoctorState();
}

class _EntryPageByDoctorState extends State<EntryPageByDoctor>
    with TickerProviderStateMixin, AfterLayoutMixin {
  late final TabController _tabcontroller;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxVisitData>().fetchVisitData();
  }

  @override
  void initState() {
    _tabcontroller = TabController(
      vsync: this,
      initialIndex: 0,
      length: 2,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabcontroller,
        tabs: [
          AppBar(
            backgroundColor: Colors.purple[300]?.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            leading: const SizedBox.shrink(),
            centerTitle: true,
            title: const Text(
              'Info Entry Page "Sheet"',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          AppBar(
            centerTitle: true,
            backgroundColor: Colors.purple[300]?.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            leading: const SizedBox.shrink(),
            title: const Text(
              'Prescriptions Page',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabcontroller,
        children: const [
          MedicalInfoPage(),
          PrescriptionPage(),
        ],
      ),
    );
  }
}