import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

class _MedicalInfoPageState extends State<MedicalInfoPage>
    with AfterLayoutMixin {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    context.read<PxSelectedDoctor>().doctor!.fields.map((e) {
      _controllers[e] = TextEditingController();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PxSelectedDoctor>(
        builder: (context, d, _) {
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
                              title: Text(d.doctor!.fields[index]),
                              subtitle: Card(
                                color: Colors.white,
                                child: TextFormField(
                                  maxLines: null,
                                  controller:
                                      _controllers[d.doctor!.fields[index]],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.close),
                                tooltip: 'Clear Field',
                                onPressed: () {
                                  _controllers[d.doctor!.fields[index]]
                                      ?.clear();
                                },
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
                                      final _data = {};
                                      if (_formKey.currentState!.validate()) {
                                        _controllers.entries.map((e) {
                                          _data[e.key] = e.value.text;
                                        }).toList();
                                        print(_data);
                                        //TODO: find why the controller texts are not registered.
                                        await EasyLoading.show(
                                            status: "Loading...");
                                        if (context.mounted) {
                                          await context
                                              .read<PxVisitData>()
                                              .updateVisitData(
                                                SxVD.DATA,
                                                _data,
                                              );
                                        }
                                        await EasyLoading.dismiss();
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
