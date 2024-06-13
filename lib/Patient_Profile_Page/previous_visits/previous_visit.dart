import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/paperwork_page/paperwork_page.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/previous_visits/popupmenubutton_custom.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/one_patient_visits.dart';
import 'package:proclinic_doctor_windows/providers/scanned_documents.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class PreviousVisitsPage extends StatefulWidget {
  const PreviousVisitsPage({super.key});

  @override
  State<PreviousVisitsPage> createState() => _PreviousVisitsPageState();
}

class _PreviousVisitsPageState extends State<PreviousVisitsPage>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    return Card.outlined(
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
                                callPresc: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FinalPrescription(
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
                            Card.outlined(
                              elevation: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TabBar(
                                  controller: _controller,
                                  tabs: const [
                                    Tab(
                                      child: Text(
                                        "Sheet Data",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        "Form Data",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _controller,
                                children: [
                                  ListView(
                                    children: [
                                      ...(o.database.values.toList()[index]
                                              ["data"] as VisitData)
                                          .data
                                          .entries
                                          .map((e) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 7,
                                              ),
                                              const SizedBox(width: 30),
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  e.key,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 30),
                                              Expanded(
                                                child: Text(e.value ?? ""),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList()
                                    ],
                                  ),
                                  ListView(
                                    children: [
                                      if ((o.database.values.toList()[index]
                                                  ["data"] as VisitData)
                                              .formData !=
                                          null)
                                        ...(o.database.values.toList()[index]
                                                ["data"] as VisitData)
                                            .formData!
                                            .entries
                                            .map((e) {
                                          if (e.value == null) {
                                            return const SizedBox();
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const CircleAvatar(
                                                  radius: 7,
                                                ),
                                                const SizedBox(width: 30),
                                                SizedBox(
                                                  width: 250,
                                                  child: Text(
                                                    e.key,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 30),
                                                Expanded(
                                                  child:
                                                      Text(e.value.toString()),
                                                )
                                              ],
                                            ),
                                          );
                                        }).toList()
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
