import 'dart:math';

import 'package:proclinic_doctor_windows/control_panel/labs_rads_settings_page/labs_db.dart';
import 'package:proclinic_doctor_windows/control_panel/labs_rads_settings_page/rads_db.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabsAndRadsSettingsPage extends StatefulWidget {
  const LabsAndRadsSettingsPage({super.key});

  @override
  _LabsAndRadsSettingsPageState createState() =>
      _LabsAndRadsSettingsPageState();
}

class _LabsAndRadsSettingsPageState extends State<LabsAndRadsSettingsPage> {
  TextEditingController labController = TextEditingController();
  TextEditingController radController = TextEditingController();
  LabsClass labs = LabsClass(docname: globallySelectedDoctor);
  RadsClass rads = RadsClass(docname: globallySelectedDoctor);
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSettingsNavDrawer(),
      appBar: AppBar(
        title: const Text(
          'Labs & Rads',
          textScaler: TextScaler.linear(2.0): 2,
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
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    offset: const Offset(5, 5),
                    blurRadius: 5,
                    spreadRadius: 5),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              shadowColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
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
                            const SizedBox(width: 150, child: Text('Labs :')),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 350,
                              child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(10),
                                  )),
                                  color: Colors.purple[100],
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
                                    onChanged: (String value) async {
                                      setState(() {});
                                    },
                                    maxLines: null,
                                    controller: labController,
                                  )),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add to Lab List'),
                              onPressed: () async {
                                await labs.updateDoctorLabstoMongo(
                                    docname: globallySelectedDoctor,
                                    lab: labController.text.toLowerCase());
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                labController.clear();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      //container list view of labs from db
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
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
                        child: StreamBuilder(
                            stream: labs.doctorlablist,
                            builder: (context, snapshot) {
                              List labdata =
                                  !snapshot.hasData ? [] : snapshot.data;
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, childAspectRatio: 6),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(labdata[index]
                                          .toString()
                                          .toUpperCase()),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await labs.deleteDoctorLabsFromMongo(
                                            docname: globallySelectedDoctor,
                                            lab: labdata[index]);
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                                itemCount:
                                    !snapshot.hasData ? 0 : labdata.length,
                              );
                            }),
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
                            const SizedBox(width: 150, child: Text('Rads :')),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 350,
                              child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(10),
                                  )),
                                  color: Colors.purple[100],
                                  child: TextField(
                                    enableInteractiveSelection: true,
                                    enabled: true,
                                    decoration: const InputDecoration(
                                      isDense: true,
                                      icon: Icon(Icons.add_to_queue),
                                      hintText: '...',
                                      labelText:
                                          'Add Radiology Requests / Items',
                                      alignLabelWithHint: true,
                                      fillColor: Colors.white,
                                    ),
                                    onChanged: (String value) async {
                                      setState(() {});
                                    },
                                    maxLines: null,
                                    controller: radController,
                                  )),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add to Rad List'),
                              onPressed: () async {
                                await rads.updateDoctorRadstoMongo(
                                    docname: globallySelectedDoctor,
                                    rad: radController.text.toLowerCase());
                                await Future.delayed(
                                    const Duration(milliseconds: 50));

                                radController.clear();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      //container list view of rads from db
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
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
                        child: StreamBuilder(
                            stream: rads.doctorradlist,
                            builder: (context, snapshot) {
                              List raddata =
                                  !snapshot.hasData ? [] : snapshot.data;
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, childAspectRatio: 6),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)],
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(raddata[index]
                                          .toString()
                                          .toUpperCase()),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await rads.deleteDoctorRadsFromMongo(
                                            docname: globallySelectedDoctor,
                                            rad: raddata[index]);
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                                itemCount:
                                    !snapshot.hasData ? 0 : raddata.length,
                              );
                            }),
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
