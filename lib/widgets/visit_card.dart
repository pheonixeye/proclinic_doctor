import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:proclinic_doctor/Patient_Profile_Page/patient_profile_page_main.dart';
import 'package:proclinic_doctor/providers/one_patient_visits.dart';
import 'package:proclinic_doctor/providers/scanned_documents.dart';
import 'package:proclinic_doctor/providers/visit_data_provider.dart';
import 'package:proclinic_doctor/widgets/qr_dialog.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class VisitCard extends StatelessWidget {
  const VisitCard({
    super.key,
    required this.visit,
    this.fromNew = false,
    this.forSearch = true,
  });
  final Visit visit;
  final bool fromNew;
  final bool forSearch;

  @override
  Widget build(BuildContext context) {
    //todo: ADD ABILITY TO CHANGE VISIT TYPE
    //todo: NOTIFY RECEPTION VIA SOCKETS
    //todo: ADD PROCEDURES IN LIST FORMAT

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () async {
              //todo: add qr code with mongodb object id to scan in both reception & doctor apps.
              //todo: fetch visitData associated with scanned visit in mobile scanner.

              await EasyLoading.show(status: "Loading...");
              if (context.mounted) {
                context.read<PxVisitData>().selectVisit(visit);
                await context.read<PxVisitData>().fetchVisitData();
              }
              if (context.mounted) {
                await context
                    .read<PxScannedDocuments>()
                    .fetchVisitData(visit.id);
              }
              if (context.mounted) {
                await context
                    .read<PxOnePatientVisits>()
                    .fetchOnePatientVisits(visit: visit);
              }
              await EasyLoading.dismiss();
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientProfilePage(
                      fromnew: fromNew,
                    ),
                  ),
                );
              }
            },
            leading: const CircleAvatar(),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.person),
                    ),
                  ),
                  Text('Name :\n${visit.toJson()['ptname']}'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.phone),
                    ),
                  ),
                  Text('Phone :\n${visit.toJson()['phone']}'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.support_agent),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final d = DateTime.parse(visit.toJson()['dob']);
                      final today = DateTime.now();
                      final age = today.year - d.year;
                      return Text('Age :\n$age Years');
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.report_problem),
                    ),
                  ),
                  Text('Visit Type :\n${visit.toJson()['visittype']}'),
                  if (forSearch)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 30,
                        child: Icon(Icons.calendar_month),
                      ),
                    ),
                  if (forSearch)
                    Builder(
                      builder: (context) {
                        final d = DateTime.parse(visit.toJson()['visitdate']);
                        return Text(
                            'Visit Date :\n${d.day}-${d.month}-${d.year}');
                      },
                    ),
                  //todo: ADD QR BTN
                  const SizedBox(width: 30),
                  IconButton.outlined(
                    icon: const Icon(Icons.qr_code_2),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => QrDialog(
                          code: QrCode.fromData(
                            data: visit.id.oid,
                            errorCorrectLevel: QrErrorCorrectLevel.H,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
