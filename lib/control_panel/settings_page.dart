import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:proclinic_doctor_windows/functions/print_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/theme_changer.dart';
import 'package:provider/provider.dart';

class FieldCreationPage extends StatefulWidget {
  const FieldCreationPage({super.key});

  @override
  State<FieldCreationPage> createState() => _FieldCreationPageState();
}

class _FieldCreationPageState extends State<FieldCreationPage> {
  late final TextEditingController _medfieldController;
  late final ScrollController _controller;

  // int? selectedvalue;

  @override
  void initState() {
    _medfieldController = TextEditingController();
    _controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _medfieldController.dispose();
    _controller.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  final List<DropdownMenuItem<bool>> _items = [
    const DropdownMenuItem<bool>(
      value: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.table_rows),
          SizedBox(
            width: 10,
          ),
          Text('Single Column')
        ],
      ),
    ),
    const DropdownMenuItem<bool>(
      value: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.view_column),
          SizedBox(
            width: 10,
          ),
          Text('Two Columns')
        ],
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          drawer: const CustomSettingsNavDrawer(),
          appBar: AppBar(
            title: const Text(
              'Settings Page',
              textScaler: TextScaler.linear(2.0),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CupertinoScrollbar(
                  controller: _controller,
                  thickness: 10,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 16.0, 8.0, 8.0),
                              child: ListTile(
                                leading: const CircleAvatar(),
                                title: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Select Application Theme'),
                                ),
                                trailing: FloatingActionButton(
                                  heroTag: 'theme-btn',
                                  onPressed: () {
                                    if (context.mounted) {
                                      context
                                          .read<ThemeChanger>()
                                          .switchTheme();
                                    }
                                  },
                                  child: const Icon(Icons.theater_comedy),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  8.0, 16.0, 8.0, 8.0),
                              child: ListTile(
                                leading: const CircleAvatar(),
                                title: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Select Pdf Documents Path'),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Consumer<PdfPrinter>(
                                    builder: (context, p, _) {
                                      return Text(p.path ?? "Unselected.");
                                    },
                                  ),
                                ),
                                trailing: FloatingActionButton(
                                  heroTag: 'set-storage-path-btn',
                                  onPressed: () async {
                                    if (context.mounted) {
                                      await context
                                          .read<PdfPrinter>()
                                          .setStoragePath();
                                    }
                                  },
                                  child: const Icon(Icons.search),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //textfield for addition of medical field + add Button
                        //layout selection button
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.40,
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text('Choose Layout :'),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Consumer<PxSelectedDoctor>(
                                          builder: (context, d, c) {
                                            return Card(
                                              elevation: 6,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DropdownButton<bool>(
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_drop_down_circle,
                                                    color: Colors.blue,
                                                  ),
                                                  underline: Container(
                                                    height: 2,
                                                    color: Colors.blue,
                                                  ),
                                                  hint: const Center(
                                                    child: Text(
                                                        'Select Layout ... '),
                                                  ),
                                                  isExpanded: true,
                                                  items: _items,
                                                  value: d.doctor!.grid,
                                                  onChanged:
                                                      (bool? value) async {
                                                    await EasyLoading.show(
                                                        status: 'Loading...');
                                                    await d
                                                        .updateSelectedDoctor(
                                                      docname:
                                                          d.doctor!.docnameEN,
                                                      attribute: SxDoctor.GRID,
                                                      value: value,
                                                    );
                                                    await EasyLoading
                                                        .showSuccess(
                                                            'Updated.');
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text('Add Clinic Fields : '),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 6,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Empty Inputs Are Not Allowed";
                                                  }
                                                  return null;
                                                },
                                                enableInteractiveSelection:
                                                    true,
                                                enabled: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  labelText:
                                                      'Add Patient Data Fields',
                                                ),
                                                controller: _medfieldController,
                                              ),
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
                                            label: const Text('Add Field'),
                                            onPressed: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                final fields = d.doctor!.fields;
                                                final newFields = [
                                                  ...fields,
                                                  _medfieldController.text
                                                ];
                                                await EasyLoading.show(
                                                    status: "Loading...");
                                                await d.updateSelectedDoctor(
                                                  docname: d.doctor!.docnameEN,
                                                  attribute: SxDoctor.FIELDS,
                                                  value: newFields,
                                                );

                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 50));
                                                _medfieldController.clear();
                                                await EasyLoading.showSuccess(
                                                    "Field ${_medfieldController.text} Added.");
                                              }
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //choose layout
                        // +
                        //List of medical fields created
                        Consumer<PxSelectedDoctor>(
                          builder: (context, d, c) {
                            // 0 = false = single column = listview.builder
                            //1 = true = double column = gridview.builder
                            Widget deleteBtn(int index) {
                              return IconButton.filled(
                                icon: const Icon(
                                  Icons.delete_forever,
                                ),
                                onPressed: () async {
                                  final fields = d.doctor!.fields;
                                  final newFields =
                                      fields.remove(fields[index]);
                                  await EasyLoading.show(status: "Loading...");
                                  await d.updateSelectedDoctor(
                                    docname: d.doctor!.docnameEN,
                                    attribute: SxDoctor.FIELDS,
                                    value: newFields,
                                  );
                                  await EasyLoading.showSuccess(
                                      'Field ${d.doctor!.fields[index]} Deleted.');
                                },
                              );
                            }

                            Widget item(int index) {
                              return Card(
                                elevation: 6,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        d.doctor!.fields[index],
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    trailing: deleteBtn(index),
                                  ),
                                ),
                              );
                            }

                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.92,
                              child: d.doctor!.grid == false
                                  ? Card(
                                      elevation: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView.separated(
                                          itemCount: d.doctor!.fields.length,
                                          itemBuilder: (context, index) {
                                            return item(index);
                                          },
                                          separatorBuilder: (context, index) {
                                            return const Divider(
                                              thickness: 5,
                                              height: 15,
                                              color: Colors.blueGrey,
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Card(
                                      elevation: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GridView.builder(
                                          itemCount: d.doctor!.fields.length,
                                          itemBuilder: (context, index) {
                                            return item(index);
                                          },
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 5,
                                            crossAxisCount: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
