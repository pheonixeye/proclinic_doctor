import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

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
              builder: (context) => const FinalPrescription(
                forwardedData: {},
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: ThemeConstants.cd,
          alignment: Alignment.center,
          child: Consumer<PxVisitData>(
            builder: (context, vd, _) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${vd.data?.toString()}'),
              );
            },
          ),
        ),
      ),
    );
  }
}
