import 'package:proclinic_doctor_windows/Alert_dialogs_random/snackbar_custom.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:proclinic_doctor_windows/control_panel/zTEST_TXT_open_dialog_ffi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class FieldCreationPage extends StatefulWidget {
  const FieldCreationPage({super.key});

  @override
  _FieldCreationPageState createState() => _FieldCreationPageState();
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
    LocalStorageTextPath localtxtpath = LocalStorageTextPath();
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
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: ThemeConstants.cd,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
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
                          //TODO:print file selection method
                          StreamBuilder<Object>(
                              stream: localtxtpath.textPath,
                              builder: (context, textsnap) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
                                  decoration: ThemeConstants.cd,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 16.0, 8.0, 8.0),
                                    child: ListTile(
                                      leading: const CircleAvatar(),
                                      title: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text('Select Print File Path'),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('${textsnap.data}'),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () {
                                          opendialogTXT();
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          //textfield for addition of medical field + add Button
                          //layout selection button
                          Container(
                            height: MediaQuery.of(context).size.height * 0.30,
                            width: MediaQuery.of(context).size.width * 0.92,
                            decoration: ThemeConstants.cd,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: ThemeConstants.cd,
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text('Choose Layout :'),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Container(
                                        decoration: ThemeConstants.cd,
                                        child: Consumer<PxSelectedDoctor>(
                                          builder: (context, d, c) {
                                            return DropdownButton<bool>(
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.blue,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.blue,
                                              ),
                                              hint: const Center(
                                                child:
                                                    Text('Select Layout ... '),
                                              ),
                                              isExpanded: true,
                                              items: _items,
                                              value: d.doctor!.grid,
                                              onChanged: (bool? value) async {
                                                await d.updateSelectedDoctor(
                                                  docname: d.doctor!.docnameEN,
                                                  attribute: SxDoctor.GRID,
                                                  value: value,
                                                );
                                                if (context.mounted) {
                                                  showCustomSnackbar(
                                                      context: context,
                                                      message: 'Updated');
                                                }
                                              },
                                            );
                                          },
                                        ),
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
                                    Container(
                                      decoration: ThemeConstants.cd,
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Text('Add Clinic Fields : '),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      decoration: ThemeConstants.cd,
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          enableInteractiveSelection: true,
                                          enabled: true,
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            icon: Icon(Icons.add_to_queue),
                                            hintText: '...',
                                            labelText:
                                                'Add Patient Data Fields',
                                            alignLabelWithHint: true,
                                            fillColor: Colors.white,
                                          ),
                                          controller: _medfieldController,
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
                                            final fields = d.doctor!.fields;
                                            final newFields = [
                                              ...fields,
                                              _medfieldController.text
                                            ];
                                            await d.updateSelectedDoctor(
                                              docname: d.doctor!.docnameEN,
                                              attribute: SxDoctor.FIELDS,
                                              value: newFields,
                                            );
                                            if (context.mounted) {
                                              showCustomSnackbar(
                                                context: context,
                                                message:
                                                    'Field ${_medfieldController.text} Added.',
                                              );
                                            }
                                            await Future.delayed(const Duration(
                                                milliseconds: 50));
                                            _medfieldController.clear();
                                          },
                                        );
                                      },
                                    )
                                  ],
                                )
                              ],
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
                              Widget _deleteBtn(int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      final fields = d.doctor!.fields;
                                      final newFields =
                                          fields.remove(fields[index]);
                                      await d.updateSelectedDoctor(
                                        docname: d.doctor!.docnameEN,
                                        attribute: SxDoctor.FIELDS,
                                        value: newFields,
                                      );
                                      if (context.mounted) {
                                        showCustomSnackbar(
                                          context: context,
                                          message:
                                              'Field ${d.doctor!.fields[index]} Deleted.',
                                        );
                                      }
                                    },
                                  ),
                                );
                              }

                              Widget _item(int index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.black,
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
                                  trailing: _deleteBtn(index),
                                );
                              }

                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                width: MediaQuery.of(context).size.width * 0.92,
                                decoration: ThemeConstants.cd,
                                child: d.doctor!.grid == false
                                    ? ListView.separated(
                                        itemCount: d.doctor!.fields.length,
                                        itemBuilder: (context, index) {
                                          return _item(index);
                                        },
                                        separatorBuilder: (context, index) {
                                          return const Divider(
                                            thickness: 5,
                                            height: 15,
                                            color: Colors.blueGrey,
                                          );
                                        },
                                      )
                                    : GridView.builder(
                                        itemCount: d.doctor!.fields.length,
                                        itemBuilder: (context, index) {
                                          return _item(index);
                                        },
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 5,
                                          crossAxisCount: 2,
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
          ),
        );
      },
    );
  }
}
