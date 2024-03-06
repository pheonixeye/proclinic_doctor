import 'package:proclinic_doctor_windows/Alert_dialogs_random/snackbar_custom.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class LabsAndRadsSettingsPage extends StatefulWidget {
  const LabsAndRadsSettingsPage({super.key});

  @override
  _LabsAndRadsSettingsPageState createState() =>
      _LabsAndRadsSettingsPageState();
}

class _LabsAndRadsSettingsPageState extends State<LabsAndRadsSettingsPage> {
  late final TextEditingController labController;
  late final TextEditingController radController;
  late final ScrollController _scrollController;

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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: ThemeConstants.cd,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: CupertinoScrollbar(
                controller: _scrollController,
                thickness: 10,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      //row of add lab field + button
                      Padding(
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
                                child: TextField(
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    icon: Icon(Icons.add_to_queue),
                                    hintText: '...',
                                    labelText:
                                        'Add Laboratory Requests / Items',
                                    alignLabelWithHint: true,
                                    fillColor: Colors.white,
                                  ),
                                  maxLines: null,
                                  controller: labController,
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
                                    await d.updateSelectedDoctor(
                                      docname: d.doctor!.docnameEN,
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
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      //container list view of labs from db
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
                                    child: Text(d.doctor!.labs[index]),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      final newLabs = [...d.doctor!.labs]
                                        ..remove(index);

                                      await d.updateSelectedDoctor(
                                        docname: d.doctor!.docnameEN,
                                        attribute: SxDoctor.LABS,
                                        value: newLabs,
                                      );
                                    },
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
                      Padding(
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
                                color: Colors.purple[100],
                                child: TextField(
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    icon: Icon(Icons.add_to_queue),
                                    hintText: '...',
                                    labelText: 'Add Radiology Requests / Items',
                                    alignLabelWithHint: true,
                                    fillColor: Colors.white,
                                  ),
                                  maxLines: null,
                                  controller: radController,
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
                                    await d.updateSelectedDoctor(
                                      docname: d.doctor!.docnameEN,
                                      attribute: SxDoctor.RADS,
                                      value: [
                                        ...d.doctor!.rads,
                                        radController.text
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
                                    radController.clear();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      //container list view of rads from db
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
                                    child: Text(d.doctor!.rads[index]),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      final newRads = [...d.doctor!.rads]
                                        ..remove(index);

                                      await d.updateSelectedDoctor(
                                        docname: d.doctor!.docnameEN,
                                        attribute: SxDoctor.RADS,
                                        value: newRads,
                                      );
                                    },
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
      ),
    );
  }
}
