import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_prescription/widgets/add_new_button.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class LabRadPrescriptionSection extends StatefulWidget {
  const LabRadPrescriptionSection({super.key, required this.labOrRad});
  final LabOrRad labOrRad;
  @override
  State<LabRadPrescriptionSection> createState() =>
      _LabRadPrescriptionSectionState();
}

class _LabRadPrescriptionSectionState extends State<LabRadPrescriptionSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: ThemeConstants.cd,
          child: Consumer2<PxSelectedDoctor, PxVisitData>(
            builder: (context, d, vd, _) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: switch (widget.labOrRad) {
                                LabOrRad.lab => "Seach Labs..",
                                LabOrRad.rad => "Search Rads..",
                              },
                            ),
                            onChanged: (value) {
                              switch (widget.labOrRad) {
                                case LabOrRad.lab:
                                  d.filterList("labs", value);
                                case LabOrRad.rad:
                                  d.filterList("rads", value);
                              }
                            },
                          ),
                        ),
                        AddNewDrugLabRadButton(
                          value: _controller.text,
                          drugLabOrRad: switch (widget.labOrRad) {
                            LabOrRad.lab => 'labs',
                            LabOrRad.rad => 'rads',
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        final list = switch (widget.labOrRad) {
                          LabOrRad.lab => d.labs,
                          LabOrRad.rad => d.rads,
                        };
                        return ListView.separated(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final val = list[index];
                            return ListTile(
                              leading: const CircleAvatar(),
                              trailing: Checkbox(
                                value: switch (widget.labOrRad) {
                                  LabOrRad.lab => vd.labs.contains(val),
                                  LabOrRad.rad => vd.rads.contains(val),
                                },
                                onChanged: (value) {
                                  switch (widget.labOrRad) {
                                    case LabOrRad.lab:
                                      vd.setLabs(val);
                                    case LabOrRad.rad:
                                      vd.setRads(val);
                                  }
                                },
                              ),
                              title: Text(val),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        //todo: save lab list into prescription
                        await EasyLoading.show(status: "Loading...");
                        switch (widget.labOrRad) {
                          case LabOrRad.lab:
                            await vd.updateVisitData(
                              'labs',
                              vd.labs,
                            );
                          case LabOrRad.rad:
                            await vd.updateVisitData(
                              'rads',
                              vd.rads,
                            );
                        }

                        await EasyLoading.showSuccess("Updated...");
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

enum LabOrRad {
  lab,
  rad,
}
