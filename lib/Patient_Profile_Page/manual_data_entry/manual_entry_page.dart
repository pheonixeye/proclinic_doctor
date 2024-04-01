import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_sheet/section_sheet.dart';

import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_prescription/section_prescription.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_supplies/section_supplies.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/paperwork_page/paperwork_page.dart';
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
      length: 4,
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
              'Sheet',
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
              'Prescription',
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
              'Supplies',
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
              'Visit Documents',
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
          SectionSheet(),
          SectionPrescription(),
          SuppliesSection(),
          PaperWorkPage(),
        ],
      ),
    );
  }
}
