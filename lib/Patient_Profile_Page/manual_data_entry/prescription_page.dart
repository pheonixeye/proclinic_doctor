import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/functions/first_where_or_null.dart';
import 'package:proclinic_doctor_windows/models/dosage_forms.dart';
import 'package:proclinic_doctor_windows/models/drug/drug_model.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({super.key});

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

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
                                final _value =
                                    vd.drugs.any((d) => d.name == drug);
                                return ExpansionTile(
                                  leading: Checkbox(
                                    value: _value,
                                    onChanged: (value) {
                                      vd.setDrugs(Drug(
                                        name: drug,
                                        dose: Dose.Initial(),
                                      ));
                                    },
                                  ),
                                  title: Text(drug),
                                  children: [
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxHeight: 100),
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          const Text('Unit :'),
                                          ...<double>[0.25, 0.5, 1, 2, 3, 4, 5]
                                              .map((e) {
                                            final isPresent = vd.drugs
                                                .firstWhereOrNull(
                                                    (x) => x.name == drug);
                                            final gp = (isPresent != null &&
                                                    isPresent.dose.unit == e)
                                                ? e
                                                : null;
                                            return ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 200),
                                              child: RadioListTile<double>(
                                                title: Text(e.toString()),
                                                groupValue: gp,
                                                value: e,
                                                onChanged: (value) {
                                                  vd.setDose(drug, unit: value);
                                                },
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    ),
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxHeight: 100),
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          const Text('Form :'),
                                          ...DosageForms.list.map((e) {
                                            final isPresent = vd.drugs
                                                .firstWhereOrNull(
                                                    (x) => x.name == drug);
                                            final gp = (isPresent != null &&
                                                    isPresent.dose.form == e)
                                                ? e
                                                : null;
                                            return ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 200),
                                              child: RadioListTile<String>(
                                                title: Text(e),
                                                groupValue: gp,
                                                value: e,
                                                onChanged: (value) {
                                                  vd.setDose(drug, form: value);
                                                },
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     ListView(
                                    //       scrollDirection: Axis.horizontal,
                                    //     ),
                                    //   ],
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     ListView(
                                    //       scrollDirection: Axis.horizontal,
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
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
                              onChanged: (value) {
                                //TODO: filter labs
                              },
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
                                    value: vd.labs.contains(lab),
                                    onChanged: (value) {
                                      vd.setLabs(lab);
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
                              onChanged: (value) {
                                //TODO: filter rads
                              },
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
                                    value: vd.rads.contains(rad),
                                    onChanged: (value) {
                                      vd.setRads(rad);
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
