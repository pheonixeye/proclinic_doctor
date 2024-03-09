import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: ThemeConstants.cd,
        alignment: Alignment.center,
        child: Consumer2<PxSelectedDoctor, PxVisitData>(
          builder: (context, d, vd, _) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: ThemeConstants.cd,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: "Search Drugs..",
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: d.doctor!.drugs.length,
                              itemBuilder: (context, index) {
                                final drug = d.doctor!.drugs[index];
                                return ListTile(
                                  leading: const CircleAvatar(),
                                  trailing: Checkbox(
                                    value: vd.data!.drugs.contains(drug),
                                    onChanged: (value) {
                                      //TODO: select drug
                                    },
                                  ),
                                  title: Text(drug.name),
                                  subtitle: Wrap(
                                    children: [
                                      ...drug.dosage.map((e) {
                                        return RadioListTile<String>(
                                          value: e,
                                          groupValue: null,
                                          onChanged: (val) {
                                            //TODO: add dose to drug
                                          },
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                //TODO: save drug list into prescription
                              },
                              icon: const Icon(Icons.save),
                              label: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: ThemeConstants.cd,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: "Search Labs..",
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: d.doctor!.labs.length,
                              itemBuilder: (context, index) {
                                final lab = d.doctor!.labs[index];
                                return ListTile(
                                  leading: const CircleAvatar(),
                                  trailing: Checkbox(
                                    value: vd.data!.labs.contains(lab),
                                    onChanged: (value) {
                                      //TODO: select lab
                                    },
                                  ),
                                  title: Text(lab),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                //TODO: save lab list into prescription
                              },
                              icon: const Icon(Icons.save),
                              label: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: ThemeConstants.cd,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: "Search Rads..",
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              itemCount: d.doctor!.rads.length,
                              itemBuilder: (context, index) {
                                final rad = d.doctor!.rads[index];
                                return ListTile(
                                  leading: const CircleAvatar(),
                                  trailing: Checkbox(
                                    value: vd.data!.rads.contains(rad),
                                    onChanged: (value) {
                                      //TODO: select lab
                                    },
                                  ),
                                  title: Text(rad),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                //TODO: save rad list into prescription
                              },
                              icon: const Icon(Icons.save),
                              label: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
