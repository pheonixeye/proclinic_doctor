import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class ProcedureInputForm extends StatefulWidget {
  const ProcedureInputForm({super.key});

  @override
  State<ProcedureInputForm> createState() => _ProcedureInputFormState();
}

class _ProcedureInputFormState extends State<ProcedureInputForm> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController enController;
  late final TextEditingController arController;
  late final TextEditingController priceController;

  @override
  void initState() {
    enController = TextEditingController();
    arController = TextEditingController();
    priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    enController.dispose();
    arController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _clearControllers() {
    enController.clear();
    arController.clear();
    priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(),
                const SizedBox(width: 20),
                const SizedBox(width: 150, child: Text('Procedures :')),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 350,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Empty Inputs Are Not Allowed.";
                              }
                              return null;
                            },
                            enableInteractiveSelection: true,
                            enabled: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Add English Name',
                            ),
                            maxLines: null,
                            controller: enController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Empty Inputs Are Not Allowed.";
                              }
                              return null;
                            },
                            enableInteractiveSelection: true,
                            enabled: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Add Arabic Name',
                            ),
                            maxLines: null,
                            controller: arController,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Empty Inputs Are Not Allowed.";
                              }
                              return null;
                            },
                            enableInteractiveSelection: true,
                            enabled: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Add Price',
                            ),
                            maxLines: null,
                            controller: priceController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Consumer<PxSelectedDoctor>(
                  builder: (context, d, c) {
                    return ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Procedure'),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await EasyLoading.show(status: 'Loading...');
                          final procedure = Procedure.create(
                            nameEn: enController.text,
                            nameAr: arController.text,
                            price: double.parse(priceController.text),
                          );
                          await d.updateSelectedDoctor(
                            updateType: UpdateType.addToList,
                            id: d.doctor!.id,
                            attribute: 'procedures',
                            value: procedure.toJson(),
                          );

                          await EasyLoading.dismiss();

                          await Future.delayed(
                              const Duration(milliseconds: 50));
                          _clearControllers();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
