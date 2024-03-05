import 'dart:math';
import 'dart:ui';

import 'package:proclinic_doctor_windows/Alert_dialogs_random/snackbar_custom.dart';
import 'package:proclinic_doctor_windows/Mongo_db_doctors/mongo_doctors_db.dart';
import 'package:proclinic_doctor_windows/control_panel/fields_mongo_db.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:proclinic_doctor_windows/control_panel/zTEST_TXT_open_dialog_ffi.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldCreationPage extends StatefulWidget {
  const FieldCreationPage({super.key});

  @override
  _FieldCreationPageState createState() => _FieldCreationPageState();
}

class _FieldCreationPageState extends State<FieldCreationPage> {
  final TextEditingController _medfieldController = TextEditingController();
  int? selectedvalue;

  final List<DropdownMenuItem<int>> _items = [
    const DropdownMenuItem<int>(
      value: 0,
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
    const DropdownMenuItem<int>(
      value: 1,
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
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    LocalStorageTextPath localtxtpath = LocalStorageTextPath();
    DoctorsMongoDatabase docmongodb =
        DoctorsMongoDatabase(docname: globallySelectedDoctor);
    MedicalFieldsClass medfield =
        MedicalFieldsClass(docname: globallySelectedDoctor);
    OneDoctorGridStream gridStream =
        OneDoctorGridStream(docname: globallySelectedDoctor);
    return StreamBuilder(
        stream: medfield.fieldStream,
        builder: (context, snapshot) {
          List data = snapshot.data;
          print(data);
          return Scaffold(
            drawer: const CustomSettingsNavDrawer(),
            appBar: AppBar(
              title: const Text(
                'Settings Page',
                textScaler: TextScaler.linear(2.0): 2.0,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white54.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          offset: const Offset(5, 5),
                          blurRadius: 5,
                          spreadRadius: 5),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    shadowColor: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
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
                            //print file selection method
                            StreamBuilder<Object>(
                                stream: localtxtpath.textPath,
                                builder: (context, textsnap) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.92,
                                    decoration: BoxDecoration(
                                        color: Colors.white54.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.primaries[Random()
                                                  .nextInt(
                                                      Colors.primaries.length)],
                                              offset: const Offset(5, 5),
                                              blurRadius: 5,
                                              spreadRadius: 5),
                                        ]),
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
                                            setState(() {});
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
                              decoration: BoxDecoration(
                                  color: Colors.white54.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)],
                                        offset: const Offset(5, 5),
                                        blurRadius: 5,
                                        spreadRadius: 5),
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(4.0, 4.0),
                                                blurRadius: 4.0,
                                              ),
                                            ],
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Text('Choose Layout :'),
                                          )),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  offset: Offset(4.0, 4.0),
                                                  blurRadius: 4.0,
                                                ),
                                              ],
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: DropdownButton<int>(
                                              icon: const Icon(
                                                Icons.arrow_drop_down_circle,
                                                color: Colors.blue,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.blue,
                                              ),
                                              hint: const Center(
                                                  child: Text(
                                                      'Select Layout ... ')),
                                              isExpanded: true,
                                              items: _items,
                                              value: selectedvalue,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  selectedvalue = value;
                                                  if (selectedvalue == 0) {
                                                    docmongodb
                                                        .updatelayoutintomongo(
                                                            docname:
                                                                globallySelectedDoctor,
                                                            grid: false);
                                                  } else if (selectedvalue ==
                                                      1) {
                                                    docmongodb
                                                        .updatelayoutintomongo(
                                                            docname:
                                                                globallySelectedDoctor,
                                                            grid: true);
                                                  }
                                                });
                                              },
                                            ),
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(4.0, 4.0),
                                                blurRadius: 4.0,
                                              ),
                                            ],
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(12.0),
                                            child: Text('Add Clinic Fields : '),
                                          )),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      Container(
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(4.0, 4.0),
                                                blurRadius: 4.0,
                                              ),
                                            ],
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                          )),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.add),
                                        label: const Text('Add Field'),
                                        onPressed: () async {
                                          await medfield
                                              .updateDoctorFieldtoMongo(
                                                  docname:
                                                      globallySelectedDoctor,
                                                  medfield:
                                                      _medfieldController.text);
                                          showCustomSnackbar(
                                              context: context,
                                              message:
                                                  'Field ${_medfieldController.text} Added.');
                                          await Future.delayed(
                                              const Duration(milliseconds: 50));
                                          _medfieldController.clear();
                                          setState(() {});
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
                            StreamBuilder(
                                stream: gridStream.gridValueStreambool,
                                builder: (context, snapofgrid) {
                                  bool griddata = !snapofgrid.hasData
                                      ? false
                                      : snapofgrid.data;

                                  print('grid = ${griddata}');
                                  // 0 = false = single column = listview.builder
                                  //1 = true = double column = gridview.builder
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    width: MediaQuery.of(context).size.width *
                                        0.92,
                                    decoration: BoxDecoration(
                                        color: Colors.white54.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.primaries[Random()
                                                  .nextInt(
                                                      Colors.primaries.length)],
                                              offset: const Offset(5, 5),
                                              blurRadius: 5,
                                              spreadRadius: 5),
                                        ]),
                                    child: griddata == false
                                        ? ListView.separated(
                                            itemCount: !snapshot.hasData
                                                ? 0
                                                : data.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  child: Text('${index + 1}'),
                                                ),
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    data[index],
                                                    style: const TextStyle(
                                                        fontSize: 32,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () async {
                                                      await medfield
                                                          .deleteDoctorFieldFromMongo(
                                                              docname:
                                                                  globallySelectedDoctor,
                                                              medfield:
                                                                  data[index]);

                                                      showCustomSnackbar(
                                                          context: context,
                                                          message:
                                                              'Field ${data[index]} Deleted.');
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              );
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
                                            itemCount: !snapshot.hasData
                                                ? 0
                                                : data.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor: Colors.black,
                                                  child: Text('${index + 1}'),
                                                ),
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    data[index],
                                                    style: const TextStyle(
                                                        fontSize: 32,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                                trailing: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                    ),
                                                    onPressed: () async {
                                                      await medfield
                                                          .deleteDoctorFieldFromMongo(
                                                              docname:
                                                                  globallySelectedDoctor,
                                                              medfield:
                                                                  data[index]);

                                                      showCustomSnackbar(
                                                          context: context,
                                                          message:
                                                              'Field ${data[index]} Deleted.');
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 5,
                                                    crossAxisCount: 2),
                                          ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
