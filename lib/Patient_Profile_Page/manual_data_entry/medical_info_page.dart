import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/sheet_prescription.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/models/visit_data/visit_data.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class MedicalInfoPage extends StatefulWidget {
  const MedicalInfoPage({
    super.key,
  });
  @override
  State<MedicalInfoPage> createState() => _MedicalInfoPageState();
}

class _MedicalInfoPageState extends State<MedicalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  // @override
  // FutureOr<void> afterFirstLayout(BuildContext context) async {}

  @override
  void initState() {
    context.read<PxSelectedDoctor>().doctor?.fields.map((e) {
      _controllers[e] = TextEditingController();
    }).toList();
    super.initState();
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
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: ThemeConstants.cd,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Card(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GridView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              tileColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.all(8.0),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(d.doctor!.fields[index]),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      maxLines: null,
                                      controller:
                                          _controllers[d.doctor!.fields[index]],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    tooltip: 'Clear Field',
                                    onPressed: () {
                                      _controllers[d.doctor!.fields[index]]
                                          ?.clear();
                                    },
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Builder(
                                  builder: (context) {
                                    final isEmpty = (vd.data == null ||
                                        vd.data!.data.isEmpty);
                                    return SelectableText(
                                      isEmpty
                                          ? ""
                                          : vd.data
                                              ?.data[d.doctor!.fields[index]],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          itemCount: d.doctor!.fields.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: d.doctor!.grid ? 2 : 1,
                            childAspectRatio: d.doctor!.grid ? 6 : 11,
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
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SheetPrescription(
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
                                      await EasyLoading.show(
                                          status: 'Loading...');
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
                                              ? data[e.key] =
                                                  vd.data?.data[e.key]
                                              : data[e.key] = e.value.text;
                                        }).toList();

                                        await EasyLoading.show(
                                            status: "Loading...");
                                        if (context.mounted) {
                                          await context
                                              .read<PxVisitData>()
                                              .updateVisitData(
                                                SxVD.DATA,
                                                data,
                                              );
                                        }
                                        await EasyLoading.dismiss();

                                        await EasyLoading.showSuccess(
                                            "Sheet Saved.");

                                        _controllers.entries
                                            .map((e) => e.value.clear())
                                            .toList();
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
              ),
            ),
          );
        },
      ),
    );
  }
}
