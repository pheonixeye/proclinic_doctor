import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Alert_dialogs_random/snackbar_custom.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:provider/provider.dart';

class LabsAndRadsSettingsPage extends StatefulWidget {
  const LabsAndRadsSettingsPage({super.key});

  @override
  State<LabsAndRadsSettingsPage> createState() =>
      _LabsAndRadsSettingsPageState();
}

class _LabsAndRadsSettingsPageState extends State<LabsAndRadsSettingsPage> {
  late final TextEditingController labController;
  late final TextEditingController radController;
  late final ScrollController _scrollController;
  final labFormKey = GlobalKey<FormState>();
  final radFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    labController = TextEditingController();
    radController = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    labController.dispose();
    radController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSettingsNavDrawer(),
      appBar: AppBar(
        title: const Text(
          'Labs & Rads',
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 6,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    //row of add lab field + button
                    Form(
                      key: labFormKey,
                      child: Card(
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(),
                              const SizedBox(width: 20),
                              const SizedBox(
                                width: 150,
                                child: Text('Labs :'),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              SizedBox(
                                width: 350,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      enableInteractiveSelection: true,
                                      enabled: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        labelText:
                                            'Add Laboratory Requests / Items',
                                      ),
                                      maxLines: null,
                                      controller: labController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Empty Inputs Are Not Allowed.";
                                        }
                                        return null;
                                      },
                                    ),
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
                                    label: const Text('Add to Lab List'),
                                    onPressed: () async {
                                      if (labFormKey.currentState!.validate()) {
                                        await EasyLoading.show(
                                            status: "Loading...");
                                        await d.updateSelectedDoctor(
                                          id: d.doctor!.id,
                                          attribute: 'labs',
                                          value: [
                                            ...d.doctor!.labs,
                                            labController.text
                                          ],
                                        );
                                        if (context.mounted) {
                                          showCustomSnackbar(
                                            context: context,
                                            message: 'Lab Added.',
                                          );
                                        }
                                        await Future.delayed(
                                            const Duration(milliseconds: 50));
                                        labController.clear();
                                        await EasyLoading.showSuccess(
                                            'Updated.');
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
                    //container list view of labs from db
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Consumer<PxSelectedDoctor>(
                        builder: (context, d, c) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 6,
                            ),
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 6,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(d.doctor!.labs[index]),
                                  ),
                                  trailing: IconButton.filled(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                    ),
                                    onPressed: () async {
                                      final newLabs = [...d.doctor!.labs]
                                        ..removeAt(index);
                                      await EasyLoading.show(
                                          status: "Loading...");
                                      await d.updateSelectedDoctor(
                                        id: d.doctor!.id,
                                        attribute: 'labs',
                                        value: newLabs,
                                      );
                                      await EasyLoading.showSuccess("Updated.");
                                    },
                                  ),
                                ),
                              );
                            },
                            itemCount: d.doctor!.labs.length,
                          );
                        },
                      ),
                    ),
                    //end of lab list + field + button
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Divider(
                        color: Colors.blueGrey,
                        thickness: 5,
                        height: 10,
                      ),
                    ),
                    // end of lab compartment
                    //---------------------------//
                    //------------------------------//
                    //begining of rad compartement
                    Form(
                      key: radFormKey,
                      child: Card(
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(),
                              const SizedBox(width: 20),
                              const SizedBox(
                                width: 150,
                                child: Text('Rads :'),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              SizedBox(
                                width: 350,
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      enableInteractiveSelection: true,
                                      enabled: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        labelText:
                                            'Add Radiology Requests / Items',
                                      ),
                                      maxLines: null,
                                      controller: radController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Empty Inputs Are Not Allowed.";
                                        }
                                        return null;
                                      },
                                    ),
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
                                    label: const Text('Add to Rad List'),
                                    onPressed: () async {
                                      if (radFormKey.currentState!.validate()) {
                                        await EasyLoading.show(
                                            status: "Loading...");
                                        await d.updateSelectedDoctor(
                                          id: d.doctor!.id,
                                          attribute: 'rads',
                                          value: [
                                            ...d.doctor!.rads,
                                            radController.text
                                          ],
                                        );
                                        if (context.mounted) {
                                          showCustomSnackbar(
                                            context: context,
                                            message: 'Rad Added.',
                                          );
                                        }
                                        await Future.delayed(
                                            const Duration(milliseconds: 50));
                                        radController.clear();
                                        await EasyLoading.showSuccess(
                                            'Updated.');
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
                    //container list view of rads from db
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Consumer<PxSelectedDoctor>(
                        builder: (context, d, c) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 6,
                            ),
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 6,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(d.doctor!.rads[index]),
                                  ),
                                  trailing: IconButton.filled(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                    ),
                                    onPressed: () async {
                                      final newRads = [...d.doctor!.rads]
                                        ..removeAt(index);
                                      await EasyLoading.show(
                                          status: "Loading...");
                                      await d.updateSelectedDoctor(
                                        id: d.doctor!.id,
                                        attribute: 'rads',
                                        value: newRads,
                                      );
                                      await EasyLoading.showSuccess('Updated.');
                                    },
                                  ),
                                ),
                              );
                            },
                            itemCount: d.doctor!.rads.length,
                          );
                        },
                      ),
                    ),
                    //end of rad list + field + button
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
