import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:provider/provider.dart';

class AddDrugsPage extends StatefulWidget {
  const AddDrugsPage({super.key});

  @override
  State<AddDrugsPage> createState() => _AddDrugsPageState();
}

class _AddDrugsPageState extends State<AddDrugsPage> {
  late final TextEditingController drugController;
  // late final TextEditingController doctitleController;
  // late final TextEditingController clinicdetailController;
  // late final TextEditingController doseController;
  // late final TextEditingController miscController;
  // late final ScrollController _controller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    drugController = TextEditingController();
    // doctitleController = TextEditingController();
    // clinicdetailController = TextEditingController();
    // doseController = TextEditingController();
    // miscController = TextEditingController();
    // _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    drugController.dispose();
    // doctitleController.dispose();
    // clinicdetailController.dispose();
    // doseController.dispose();
    // miscController.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSettingsNavDrawer(),
      appBar: AppBar(
        title: const Text(
          'Drugs & Prescriptions',
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //row of add drugs field + button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(),
                              const SizedBox(width: 20),
                              const SizedBox(
                                  width: 150,
                                  child: Text('Prescription Drugs :')),
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
                                        await EasyLoading.show(
                                            status: 'Loading...');

                                        await d.updateSelectedDoctor(
                                          docname: d.doctor!.docnameEN,
                                          attribute: SxDoctor.DRUGS,
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
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Divider(
                        color: Colors.blueGrey,
                        thickness: 5,
                        height: 10,
                      ),
                    ),
                    //container list view of drugs from db
                    Expanded(
                      child: Consumer<PxSelectedDoctor>(
                        builder: (context, d, c) {
                          return Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 6,
                                ),
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child: Text('${index + 1}'),
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(d.doctor!.drugs[index]),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete_forever,
                                            color: Colors.red,
                                          ),
                                          onPressed: () async {
                                            await EasyLoading.show(
                                                status: "Loading...");
                                            await d.updateSelectedDoctor(
                                              docname: d.doctor!.docnameEN,
                                              attribute: SxDoctor.DRUGS,
                                              value: [
                                                ...d.doctor!.drugs
                                                  ..removeWhere((drug) =>
                                                      drug ==
                                                      d.doctor!.drugs[index])
                                              ],
                                            );
                                            await EasyLoading.dismiss();
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: d.doctor!.drugs.length,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    //end of drug list + field + button
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Divider(
                        color: Colors.blueGrey,
                        thickness: 5,
                        height: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
