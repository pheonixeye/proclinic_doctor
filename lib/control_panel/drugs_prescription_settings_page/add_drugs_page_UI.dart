import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class AddDrugsPage extends StatefulWidget {
  const AddDrugsPage({super.key});

  @override
  _AddDrugsPageState createState() => _AddDrugsPageState();
}

class _AddDrugsPageState extends State<AddDrugsPage> {
  late final TextEditingController drugController;
  late final TextEditingController doctitleController;
  late final TextEditingController clinicdetailController;
  late final TextEditingController doseController;
  late final TextEditingController miscController;
  late final ScrollController _controller;

  @override
  void initState() {
    drugController = TextEditingController();
    doctitleController = TextEditingController();
    clinicdetailController = TextEditingController();
    doseController = TextEditingController();
    miscController = TextEditingController();
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    drugController.dispose();
    doctitleController.dispose();
    clinicdetailController.dispose();
    doseController.dispose();
    miscController.dispose();
    _controller.dispose();
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: ThemeConstants.cd,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: CupertinoScrollbar(
                controller: _controller,
                thickness: 10,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      //row of add drugs field + button
                      Padding(
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
                                child: TextField(
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    icon: Icon(Icons.add_to_queue),
                                    hintText: '...',
                                    labelText: 'Drug',
                                    alignLabelWithHint: true,
                                    fillColor: Colors.white,
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
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      //container list view of drugs from db
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: ThemeConstants.cd,
                        child: Consumer<PxSelectedDoctor>(
                          builder: (context, d, c) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 6,
                              ),
                              itemBuilder: (context, index) {
                                return ListTile(
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
                                                drug == d.doctor!.drugs[index])
                                        ],
                                      );
                                      await EasyLoading.dismiss();
                                    },
                                  ),
                                );
                              },
                              itemCount: d.doctor!.drugs.length,
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

                      //clinic details
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(),
                            const SizedBox(width: 20),
                            const SizedBox(
                              width: 150,
                              child: Text('Clinic Details :'),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 350,
                              child: Card(
                                child: TextField(
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    icon: Icon(Icons.add_to_queue),
                                    hintText: '...',
                                    labelText: 'Add Clinic Details',
                                    alignLabelWithHint: true,
                                    fillColor: Colors.white,
                                  ),
                                  maxLines: null,
                                  controller: clinicdetailController,
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
                                  label: const Text('Add Clinic Detail'),
                                  onPressed: () async {
                                    await EasyLoading.show(
                                        status: "Loading...");

                                    await d.updateSelectedDoctor(
                                      docname: d.doctor!.docnameEN,
                                      attribute: SxDoctor.CLINICDETAILS,
                                      value: [
                                        ...d.doctor!.clinicDetails,
                                        clinicdetailController.text
                                      ],
                                    );

                                    await EasyLoading.dismiss();

                                    await Future.delayed(
                                        const Duration(milliseconds: 50));
                                    clinicdetailController.clear();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      // container to show clinic details
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: ThemeConstants.cd,
                        child: Consumer<PxSelectedDoctor>(
                            builder: (context, d, c) {
                          return Center(
                            child: ListView.builder(
                              itemCount: d.doctor!.clinicDetails.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(d.doctor!.clinicDetails[index]),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await EasyLoading.show(
                                          status: 'Loading...');
                                      await d.updateSelectedDoctor(
                                        docname: d.doctor!.docnameEN,
                                        attribute: SxDoctor.CLINICDETAILS,
                                        value: [...d.doctor!.clinicDetails]
                                          ..removeAt(index),
                                      );
                                      await EasyLoading.dismiss();
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),
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
      ),
    );
  }
}
