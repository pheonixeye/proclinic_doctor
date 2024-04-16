import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class _sheetState {
  //todo: extract state into a private object
  final String field;
  final String? value;
  final TextEditingController controller;

  const _sheetState({
    required this.field,
    required this.value,
    required this.controller,
  });

  _sheetState copyWith(String? value) {
    return _sheetState(
      field: field,
      value: value,
      controller: controller,
    );
  }

  static List<_sheetState> list(
      List<String> fields, Map<String, dynamic> values) {
    return fields
        .map((e) => _sheetState(
              field: e,
              value: values[e],
              controller: TextEditingController(),
            ))
        .toList();
  }
}

class SectionSheet extends StatefulWidget {
  const SectionSheet({super.key});
  @override
  State<SectionSheet> createState() => _SectionSheetState();
}

class _SectionSheetState extends State<SectionSheet> with AfterLayoutMixin {
  final _formKey = GlobalKey<FormState>();
  //todo: maintain state of controllers between transitions
  //todo: get rid of set state called during build

  List<_sheetState>? _state;

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _state = _sheetState.list(
          context.read<PxSelectedDoctor>().doctor!.fields,
          context.read<PxVisitData>().data!.data,
        );
      });
    });
  }

  @override
  void dispose() {
    _state?.map((e) => e.controller.dispose()).toList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<PxSelectedDoctor, PxVisitData>(
        builder: (context, d, vd, _) {
          while (d.doctor == null || vd.data == null || _state == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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
                        return Card.outlined(
                          elevation: 8,
                          child: ListTile(
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
                                  child: TextFormField(
                                    controller: _state![index].controller
                                      ..text = _state![index].value ?? "",
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      labelText: d.doctor?.fields[index],
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _state?[index] =
                                            _state![index].copyWith(value);
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                IconButton.filledTonal(
                                  icon: const Icon(Icons.clear_all),
                                  tooltip: 'Clear Field',
                                  onPressed: () {
                                    _state?[index].controller.clear();
                                  },
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
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
                                heroTag: 'view-sheet',
                                tooltip: "View Sheet",
                                child: const Icon(Icons.image_search),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FinalPrescription(
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
                                    id: d.doctor!.id,
                                    attribute: 'grid',
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
                                  final data = <String, dynamic>{};
                                  if (_formKey.currentState!.validate()) {
                                    _state?.map((e) {
                                      (e.value != null && e.value!.isEmpty)
                                          ? data[e.field] =
                                              vd.data!.data[e.field]
                                          : data[e.field] = e.value;
                                    }).toList();

                                    await EasyLoading.show(
                                        status: "Loading...");
                                    await vd.updateVisitData(
                                      "medicaldata",
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
