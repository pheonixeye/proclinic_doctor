import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/widgets/drug_section.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/widgets/lab_rad_section.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        elevation: 50,
        backgroundColor: Colors.orange[400],
        tooltip: 'Print Prescription',
        child: const Icon(Icons.print),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FinalPrescription(),
            ),
          );
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: ThemeConstants.cd,
        alignment: Alignment.center,
        child: const Row(
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
    );
  }
}
