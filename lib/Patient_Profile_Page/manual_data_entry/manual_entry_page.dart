import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:proclinic_doctor/Patient_Profile_Page/manual_data_entry/section_form/section_form.dart';
import 'package:proclinic_doctor/Patient_Profile_Page/manual_data_entry/section_sheet/section_sheet.dart';

import 'package:flutter/material.dart';
import 'package:proclinic_doctor/Patient_Profile_Page/manual_data_entry/section_prescription/section_prescription.dart';
import 'package:proclinic_doctor/Patient_Profile_Page/manual_data_entry/section_supplies/section_supplies.dart';
import 'package:proclinic_doctor/Patient_Profile_Page/paperwork_page/paperwork_page.dart';
import 'package:proclinic_doctor/providers/visit_data_provider.dart';
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
      length: 5,
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
        dividerHeight: 2,
        controller: _tabcontroller,
        tabs: const [
          Card(
            elevation: 6,
            child: Row(
              children: [
                Expanded(
                  child: Tab(
                    text: 'Sheet',
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 6,
            child: Row(
              children: [
                Expanded(
                  child: Tab(
                    text: 'Form',
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 6,
            child: Row(
              children: [
                Expanded(
                  child: Tab(
                    text: 'Prescription',
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 6,
            child: Row(
              children: [
                Expanded(
                  child: Tab(
                    text: 'Supplies',
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 6,
            child: Row(
              children: [
                Expanded(
                  child: Tab(
                    text: 'Visit Documents',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabcontroller,
        children: const [
          SectionSheet(),
          SectionForm(),
          SectionPrescription(),
          SuppliesSection(),
          PaperWorkPage(),
        ],
      ),
    );
  }
}
