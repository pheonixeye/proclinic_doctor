import 'dart:convert';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_form/widgets/confim_detatch_form_dialog.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/section_form/widgets/select_form_dialog.dart';
import 'package:proclinic_doctor_windows/providers/form_loader.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_doctor_windows/widgets/central_loading.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class SectionForm extends StatefulWidget {
  const SectionForm({super.key});

  @override
  State<SectionForm> createState() => _SectionFormState();
}

class _SectionFormState extends State<SectionForm> {
  final formKey = GlobalKey<FormState>();
  late final ScrollController _controller;

  String? _textFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Input Is Required.";
    }
    return null;
  }

  String? _dropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Input Is Required.";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final vd = context.read<PxVisitData>();
      final fl = context.read<PxFormLoader>();
      if (vd.data != null && vd.data!.formId != null && fl.forms != null) {
        fl.selectForm(
            fl.forms!.firstWhere((x) => x.id == vd.data!.formId), vd.data);
      } else {
        fl.selectForm(null);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<PxSelectedDoctor, PxVisitData, PxFormLoader>(
      builder: (context, d, v, l, _) {
        while (d.doctor == null || v.data == null || l.forms == null) {
          return const CentralLoading();
        }
        final pages = l.selectedForm == null
            ? [0]
            : l.selectedForm!.elements.map((e) => e.page).toList();
        pages.sort();
        final totalPages = pages.last;
        if (kDebugMode) {
          print(l.formState);
        }
        return Form(
          key: formKey,
          child: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: 'select-form',
                      tooltip: "Select Form",
                      onPressed: () async {
                        //todo
                        await showDialog(
                          context: context,
                          builder: (context) => SelectFormDialog(
                            forms: l.forms!,
                          ),
                        );
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: 'unload-form',
                      tooltip: 'Remove Form',
                      onPressed: () async {
                        //todo
                        final result = await showDialog<bool>(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const ConfirmDetachFormDialog(),
                        );
                        if (result == true) {
                          await EasyLoading.show(status: "Loading...");
                          await v.updateVisitData(SxVD.FORMID, null);
                          await v.updateVisitData(SxVD.FORMDATA, null);
                          await EasyLoading.showSuccess("Form Detached...");
                          l.selectForm(null);
                        }
                      },
                      child: const Icon(Icons.close),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      heroTag: 'save-form',
                      tooltip: "Save Form",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          //todo
                          if (context.mounted) {
                            await EasyLoading.show(status: "Loading...")
                                .then((_) async => await l.saveForm(context));
                            await EasyLoading.showSuccess("Form Saved...");
                          }
                          if (kDebugMode) {
                            print(l.formState);
                          }
                        }
                      },
                      child: const Icon(Icons.save),
                    ),
                  ),
                ],
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                final height = constraints.maxHeight;
                if (kDebugMode) {
                  print(height);
                }
                return Card.outlined(
                  elevation: 6,
                  child: ListView(
                    controller: _controller,
                    itemExtentBuilder: (index, dimensions) {
                      return totalPages == 0
                          ? height
                          : (height + 50) * (totalPages);
                    },
                    children: [
                      Stack(
                        fit: StackFit.passthrough,
                        children: [
                          if (l.selectedForm != null)
                            ...l.selectedForm!.elements.map((e) {
                              return Positioned(
                                top: e.startY +
                                    ((e.page - 1) *
                                        (height + (20 * (totalPages)))),
                                left: e.startX,
                                width: e.spanX,
                                height: e.spanY,
                                child: switch (e.formElement) {
                                  FormElement.textfield => TextFormField(
                                      initialValue: l.formState?[e.title],
                                      decoration: InputDecoration(
                                        labelText: e.title,
                                        border: const OutlineInputBorder(),
                                      ),
                                      onChanged: (value) {
                                        //todo
                                        l.updateFormState(e.title, value);
                                      },
                                      validator: e.required
                                          ? _textFieldValidator
                                          : null,
                                    ),
                                  FormElement.checkbox => CheckboxListTile(
                                      title: Text(e.title),
                                      tristate: true,
                                      value: l.formState?[e.title],
                                      onChanged: (value) {
                                        //todo
                                        l.updateFormState(e.title, value);
                                      },
                                    ),
                                  FormElement.dropdown =>
                                    DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      alignment: Alignment.center,
                                      hint: Text(e.title),
                                      items: e.options.map((x) {
                                        return DropdownMenuItem<String>(
                                          alignment: Alignment.center,
                                          value: x.value,
                                          child: Text(x.title),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        //todo
                                        l.updateFormState(e.title, value);
                                      },
                                      value: l.formState?[e.title],
                                      validator: e.required
                                          ? _dropdownValidator
                                          : null,
                                    ),
                                  FormElement.image => Image.memory(
                                      base64Decode(e.options.first.value)),
                                  FormElement.text => Text(e.title),
                                },
                              );
                            })
                          else
                            const Center(
                              child: Card.outlined(
                                  elevation: 6,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("No Form Selected."),
                                  )),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
