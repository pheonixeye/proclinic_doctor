import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_prescription/widgets/drug_section.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_prescription/widgets/lab_rad_section.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:provider/provider.dart';

class SectionPrescription extends StatefulWidget {
  const SectionPrescription({super.key});

  @override
  State<SectionPrescription> createState() => _SectionPrescriptionState();
}

class _SectionPrescriptionState extends State<SectionPrescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          isExtended: true,
          heroTag: 'view-perescription',
          tooltip: 'View Prescription',
          child: const Icon(Icons.image_search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FinalPrescription(
                  visit: context.read<PxVisitData>().visit!,
                  data: context.read<PxVisitData>().data!,
                ),
              ),
            );
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: const Card(
          elevation: 6,
          child: Row(
            children: [
              //drug input row
              DrugPrescriptionSection(),
              //lab input row
              LabRadPrescriptionSection(labOrRad: LabOrRad.lab),
              //rad input row
              LabRadPrescriptionSection(labOrRad: LabOrRad.rad),
            ],
          ),
        ),
      ),
    );
  }
}
