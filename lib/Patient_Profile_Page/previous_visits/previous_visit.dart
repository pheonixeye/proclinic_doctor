import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/previous_prescription.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/sheet_prescription.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/paperwork_page/paperwork_page.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/previous_visits/popupmenubutton_custom.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/models/visitModel.dart';
import 'package:proclinic_doctor_windows/models/visit_data/visit_data.dart';
import 'package:proclinic_doctor_windows/providers/one_patient_visits.dart';
import 'package:proclinic_doctor_windows/providers/scanned_documents.dart';
import 'package:provider/provider.dart';

class PreviousVisitsPage extends StatefulWidget {
  const PreviousVisitsPage({super.key});

  @override
  State<PreviousVisitsPage> createState() => _PreviousVisitsPageState();
}

class _PreviousVisitsPageState extends State<PreviousVisitsPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          title: Builder(
            builder: (context) {
              final d = DateTime.now();
              return Text(
                'Previous Visits\nBefore ${d.day}-${d.month}-${d.year}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            },
          ),
          centerTitle: false,
        ),
        body: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<PxOnePatientVisits>(
              builder: (context, o, _) {
                if (o.database.isEmpty) {
                  return const Center(
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("No Previous Visits Found."),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: o.database.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 30,
                                  child: Icon(Icons.calendar_today),
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  final d = DateTime.parse((o.database.values
                                          .toList()[index]["visit"] as Visit)
                                      .visitDate);
                                  return Text(
                                    '${d.day}-${d.month}-${d.year}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 30,
                                  child: Icon(Icons.try_sms_star),
                                ),
                              ),
                              Text(
                                'Type: ${(o.database.values.toList()[index]["visit"] as Visit).visitType}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const Spacer(),
                              CustomPOPUPBUTTON(
                                callPrint: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SheetPrescription(
                                        visit: o.database.values.toList()[index]
                                            ["visit"] as Visit,
                                        data: o.database.values.toList()[index]
                                            ["data"] as VisitData,
                                      ),
                                    ),
                                  );
                                },
                                callPresc: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PreviousPrescription(
                                        visit: o.database.values.toList()[index]
                                            ["visit"] as Visit,
                                        data: o.database.values.toList()[index]
                                            ["data"] as VisitData,
                                      ),
                                    ),
                                  );
                                },
                                callDocs: () {
                                  context.read<PxScannedDocuments>().selectData(
                                      o.database.values.toList()[index]["data"]
                                          as VisitData);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PaperWorkPage(
                                        subPage: false,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          children: [
                            ...(o.database.values.toList()[index]["data"]
                                    as VisitData)
                                .data
                                .entries
                                .map((e) {
                              return ListTile(
                                title: Text(e.key),
                                subtitle: Text(e.value),
                              );
                            }).toList()
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blueGrey,
                      thickness: 5,
                      height: 15,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
