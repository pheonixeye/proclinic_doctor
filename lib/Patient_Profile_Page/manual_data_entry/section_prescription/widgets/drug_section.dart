import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Alert_dialogs_random/snackbar_custom.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_prescription/widgets/add_new_button.dart';
import 'package:proclinic_doctor_windows/functions/first_where_or_null.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class DrugPrescriptionSection extends StatefulWidget {
  const DrugPrescriptionSection({super.key});

  @override
  State<DrugPrescriptionSection> createState() =>
      _DrugPrescriptionSectionState();
}

class _DrugPrescriptionSectionState extends State<DrugPrescriptionSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer2<PxSelectedDoctor, PxVisitData>(
          builder: (context, d, vd, _) {
            return Card.outlined(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: "Search Drugs..",
                            ),
                            onChanged: (value) {
                              //todo: filter drugs
                              // vd.filterDrugs(value);
                              d.filterList('drugs', value);
                            },
                          ),
                        ),
                        AddNewDrugLabRadButton(
                          value: _controller.text,
                          drugLabOrRad: 'drugs',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: d.drugs.length,
                      primary: true,
                      itemBuilder: (context, index) {
                        final drug = d.drugs[index];
                        final value_ = vd.drugs.any(
                            (d) => d.name.toLowerCase() == drug.toLowerCase());
                        final isPresent = vd.drugs.firstWhereOrNull(
                            (x) => x.name.toLowerCase() == drug.toLowerCase());
                        return ExpansionTile(
                          leading: Checkbox(
                            value: value_,
                            onChanged: (value) {
                              vd.setDrugs(PrescribedDrug(
                                name: drug,
                                dose: Dose.Initial(),
                              ));
                            },
                          ),
                          title: Text(drug),
                          children: [
                            //unit
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  const Text('Unit :'),
                                  ...<double>[
                                    0.25,
                                    0.5,
                                    1,
                                    2,
                                    3,
                                    4,
                                    5,
                                    6,
                                    7,
                                    8,
                                    9,
                                    10
                                  ].map((e) {
                                    return ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 150),
                                      child: RadioListTile<double>(
                                        title: Text(e.toString()),
                                        groupValue: isPresent?.dose.unit,
                                        value: e,
                                        onChanged: (value) {
                                          try {
                                            vd.setDose(drug, unit: value);
                                          } catch (e) {
                                            showSelectDrugFirstSnackbar(
                                                context);
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            const Divider(),
                            //form
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  const Text('Form :'),
                                  ...DosageForms.list.map((e) {
                                    return ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      child: RadioListTile<String>(
                                        title: Text(e),
                                        groupValue: isPresent?.dose.form,
                                        value: e,
                                        onChanged: (value) {
                                          try {
                                            vd.setDose(drug, form: value);
                                          } catch (e) {
                                            showSelectDrugFirstSnackbar(
                                                context);
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            const Divider(),
                            //frequency
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Frequency :'),
                                  ...<int>[1, 2, 3, 4, 5].map((e) {
                                    return ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 150),
                                      child: RadioListTile<int>(
                                        title: Text("$e times"),
                                        groupValue: isPresent?.dose.frequency,
                                        value: e,
                                        onChanged: (value) {
                                          try {
                                            vd.setDose(drug, frequency: value);
                                          } catch (e) {
                                            showSelectDrugFirstSnackbar(
                                                context);
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            //frequency unit (per)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Per :'),
                                  ...Frequency.list.map((e) {
                                    return ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 150),
                                      child: RadioListTile<String>(
                                        title: Text(e),
                                        groupValue:
                                            isPresent?.dose.frequencyUnit,
                                        value: e,
                                        onChanged: (value) {
                                          try {
                                            vd.setDose(drug,
                                                frequecyUnit: value);
                                          } catch (e) {
                                            showSelectDrugFirstSnackbar(
                                                context);
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            const Divider(),
                            //duration
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('For :'),
                                  ...<int>[1, 2, 3, 4, 5, 6].map((e) {
                                    return ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 150),
                                      child: RadioListTile<int>(
                                        title: Text("$e"),
                                        groupValue: isPresent?.dose.duration,
                                        value: e,
                                        onChanged: (value) {
                                          try {
                                            vd.setDose(drug, duration: value);
                                          } catch (e) {
                                            showSelectDrugFirstSnackbar(
                                                context);
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            //duration unit (for)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Duration :'),
                                  ...Frequency.list.map((e) {
                                    return ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 150),
                                      child: RadioListTile<String>(
                                        title: Text(e),
                                        groupValue:
                                            isPresent?.dose.durationUnit,
                                        value: e,
                                        onChanged: (value) {
                                          try {
                                            vd.setDose(drug,
                                                durationUnit: value);
                                          } catch (e) {
                                            showSelectDrugFirstSnackbar(
                                                context);
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            const Divider(),
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
                      onPressed: () async {
                        //todo: save drug list into prescription

                        if (vd.validateDrugPrescription()) {
                          await EasyLoading.show(status: "Loading...");
                          await vd.updateVisitData(
                            "drugs",
                            vd.drugs.map((e) => e.toJson()).toList(),
                          );
                          await EasyLoading.showSuccess(
                              "Prescription Updated.");
                        } else {
                          showSelectDrugFirstSnackbar(
                            context,
                            isDose: true,
                          );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
