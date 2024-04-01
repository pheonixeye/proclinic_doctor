import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/sheet_prescription.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/models/visit_data/visit_data.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:provider/provider.dart';

class SectionSheet extends StatefulWidget {
  const SectionSheet({super.key});
  @override
  State<SectionSheet> createState() => _SectionSheetState();
}

class _SectionSheetState extends State<SectionSheet> with AfterLayoutMixin {
  final _formKey = GlobalKey<FormState>();
  //TODO: maintain state of controllers between transitions
  final Map<String, TextEditingController> _controllers =
      <String, TextEditingController>{};

  @override
  void afterFirstLayout(BuildContext context) {
    context.read<PxSelectedDoctor>().doctor?.fields.map((e) {
      _controllers[e] = TextEditingController();
    }).toList();
  }

  @override
  void dispose() {
    _controllers.entries.map((e) => e.value.dispose()).toList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<PxSelectedDoctor, PxVisitData>(
        builder: (context, d, vd, _) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Form(
              key: _formKey,
              child: Card(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GridView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          child: ListTile(
                            tileColor: Colors.grey[200],
                            contentPadding: const EdgeInsets.all(8.0),
                            title: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 3,
                                  child: Builder(
                                    builder: (context) {
                                      final controller =
                                          _controllers[d.doctor?.fields[index]];
                                      return TextFormField(
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          hintText:
                                              "Enter ${d.doctor?.fields[index]}",
                                          labelText: d.doctor?.fields[index],
                                        ),
                                        controller: controller
                                          ?..text =
                                              "${vd.data?.data[d.doctor?.fields[index]]}",
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                IconButton.filledTonal(
                                  icon: const Icon(Icons.close),
                                  tooltip: 'Clear Field',
                                  onPressed: () {
                                    _controllers[d.doctor?.fields[index]]
                                        ?.clear();
                                  },
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                            //todo:
                            // subtitle: Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Builder(
                            //     builder: (context) {
                            //       final isEmpty =
                            //           (vd.data == null || vd.data!.data.isEmpty);
                            //       return SelectableText(
                            //         isEmpty
                            //             ? ""
                            //             : vd.data?.data[d.doctor!.fields[index]],
                            //         style: const TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //         textAlign: TextAlign.center,
                            //       );
                            //     },
                            //   ),
                            // ),
                          ),
                        );
                      },
                      itemCount: d.doctor!.fields.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: d.doctor!.grid ? 2 : 1,
                        childAspectRatio: d.doctor!.grid ? 6 : 11,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                heroTag: 'print-sheet',
                                tooltip: "Print Sheet",
                                child: const Icon(Icons.print),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SheetPrescription(
                                        visit: vd.visit!,
                                        data: vd.data!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                heroTag: 'grid',
                                tooltip: "Grid",
                                child: const Icon(Icons.grid_3x3),
                                onPressed: () async {
                                  await EasyLoading.show(status: 'Loading...');
                                  await d.updateSelectedDoctor(
                                    docname: d.doctor!.docnameEN,
                                    attribute: SxDoctor.GRID,
                                    value: !d.doctor!.grid,
                                  );
                                  await EasyLoading.dismiss();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                tooltip: 'Save',
                                heroTag: 'save',
                                child: const Icon(Icons.save),
                                onPressed: () async {
                                  //working
                                  final data = <String, String>{};
                                  if (_formKey.currentState!.validate()) {
                                    _controllers.entries.map((e) {
                                      e.value.text.isEmpty
                                          ? data[e.key] = vd.data?.data[e.key]
                                          : data[e.key] = e.value.text;
                                    }).toList();

                                    await EasyLoading.show(
                                        status: "Loading...");
                                    await vd.updateVisitData(
                                      SxVD.DATA,
                                      data,
                                    );
                                    await EasyLoading.showSuccess(
                                        "Sheet Saved.");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
