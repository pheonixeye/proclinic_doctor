import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:provider/provider.dart';

class DrugInputForm extends StatefulWidget {
  const DrugInputForm({super.key});

  @override
  State<DrugInputForm> createState() => _DrugInputFormState();
}

class _DrugInputFormState extends State<DrugInputForm> {
  late final TextEditingController drugController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    drugController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    drugController.dispose();
    super.dispose();
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
                const SizedBox(width: 150, child: Text('Prescription Drugs :')),
                const SizedBox(
                  width: 50,
                ),
                SizedBox(
                  width: 350,
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
                        labelText: 'Add Prescription Drugs',
                      ),
                      maxLines: null,
                      controller: drugController,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Consumer<PxSelectedDoctor>(
                  builder: (context, d, c) {
                    return ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add to Drug List'),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await EasyLoading.show(status: 'Loading...');

                          await d.updateSelectedDoctor(
                            id: d.doctor!.id,
                            attribute: 'drugs',
                            value: [
                              ...d.doctor!.drugs,
                              drugController.text,
                            ],
                          );

                          await EasyLoading.dismiss();

                          await Future.delayed(
                              const Duration(milliseconds: 50));
                          drugController.clear();
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
