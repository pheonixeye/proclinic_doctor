import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_supplies/widgets/supplies_prescription.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_supplies/widgets/supplies_store.dart';
import 'package:proclinic_doctor_windows/providers/supplies_provider.dart';
import 'package:provider/provider.dart';

class SuppliesSection extends StatefulWidget {
  const SuppliesSection({super.key});

  @override
  State<SuppliesSection> createState() => _SuppliesSectionState();
}

class _SuppliesSectionState extends State<SuppliesSection>
    with AfterLayoutMixin {
  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxSupplies>().fetchAllDoctorSupplies().whenComplete(() {
      if (context.mounted) {
        context.read<PxSupplies>().filterSupplies('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            // doctor supplies list
            SuppliesStore(),
            // supplies list view + remove or alter item
            SuppliesPrescription(),
          ],
        ),
      ),
    );
  }
}
