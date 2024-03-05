import 'dart:math';

import 'package:proclinic_doctor_windows/Alert_dialogs_random/snackbar_custom.dart';
import 'package:proclinic_doctor_windows/Mongo_db_doctors/mongo_doctors_db.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/manual_medical_mongo.dart';
import 'package:proclinic_doctor_windows/control_panel/fields_mongo_db.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';

class EntrySegment extends StatefulWidget {
  final Map forwardedData;
  final List<TextEditingController> controllerList;
  final List controllervaluelist;
  const EntrySegment({
    super.key,
    required this.forwardedData,
    required this.controllerList,
    required this.controllervaluelist,
  });
  @override
  _EntrySegmentState createState() => _EntrySegmentState();
}

class _EntrySegmentState extends State<EntrySegment> {
  ManualEntryMedicalInfo entryMedicalInfo = ManualEntryMedicalInfo();
  OneDoctorGridStream gridStream =
      OneDoctorGridStream(docname: globallySelectedDoctor);
  MedicalFieldsClass medfield =
      MedicalFieldsClass(docname: globallySelectedDoctor);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: medfield.fieldStream,
      builder: (context, snapshot) {
        List data = !snapshot.hasData ? [] : snapshot.data;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            heroTag: const Text('Save Button'),
            isExtended: true,
            elevation: 50,
            backgroundColor: Colors.purple[400],
            tooltip: 'Save Data',
            child: const Icon(Icons.save),
            onPressed: () async {
              data.forEach((element) async {
                for (var controller in widget.controllerList) {
                  widget.controllervaluelist
                      // .add(value);
                      .add(controller.text);
                  // print(controllervaluelist);
                }
                await entryMedicalInfo.insertMedicalInfo(
                    id_: widget.forwardedData['id'],
                    day_: widget.forwardedData['day'],
                    ptName_: widget.forwardedData['ptname'],
                    docName_: widget.forwardedData['docname'],
                    month_: widget.forwardedData['month'],
                    year_: widget.forwardedData['year'],
                    phone_: widget.forwardedData['phone'],
                    procedure_: widget.forwardedData['procedure'],
                    age_: widget.forwardedData['age'],
                    amount_: widget.forwardedData['amount'],
                    visit_: widget.forwardedData['visit'],
                    remaining_: widget.forwardedData['remaining'],
                    cashtype_: widget.forwardedData['cashtype'],
                    clinic_: widget.forwardedData['clinic'],
                    dob_: widget.forwardedData['dob'],
                    fieldname: data,
                    fieldvalue: widget.controllervaluelist,
                    index: data.indexOf(element));
              });
              setState(() {});

              showCustomSnackbar(context: context, message: 'Sheet Saved');
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          body: Builder(
            builder: (context) {
              return StreamBuilder(
                stream: gridStream.gridvaluestream,
                builder: (context, gridsnap) {
                  // bool grid_data = !gridsnap.hasData ? false : gridsnap.data;
                  return Padding(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          shadowColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: gridsnap.data == true
                              ? GridView.builder(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      tileColor: Colors.grey[200],
                                      contentPadding: const EdgeInsets.all(8.0),
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text('${data[index]}'),
                                      subtitle: Card(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(10),
                                          )),
                                          color: Colors.white,
                                          child: TextField(
                                            onChanged: (String value) async {
                                              setState(() {});
                                            },
                                            maxLines: null,
                                            controller:
                                                widget.controllerList[index],
                                          )),
                                      trailing: IconButton(
                                        icon: const Icon(
                                            Icons.clear_all_outlined),
                                        tooltip: 'Clear Field',
                                        onPressed: () {
                                          widget.controllerList[index].clear();
                                        },
                                      ),
                                    );
                                  },
                                  itemCount:
                                      !snapshot.hasData ? 0 : data.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 6),
                                )

                              //TODO: make option for listview.separated vs gridview.builder

                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      tileColor: Colors.grey[200],
                                      contentPadding: const EdgeInsets.all(8.0),
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: Text('${data[index]}'),
                                      subtitle: Card(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(10),
                                          )),
                                          color: Colors.white,
                                          child: TextField(
                                            onChanged: (String value) async {
                                              setState(() {});
                                            },
                                            maxLines: null,
                                            controller:
                                                widget.controllerList[index],
                                          )),
                                      trailing: IconButton(
                                        icon: const Icon(
                                            Icons.clear_all_outlined),
                                        tooltip: 'Clear Field',
                                        onPressed: () {
                                          widget.controllerList[index].clear();
                                        },
                                      ),
                                    );
                                  },
                                  itemCount:
                                      !snapshot.hasData ? 0 : data.length,
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      height: 15,
                                      thickness: 5,
                                      color: Theme.of(context).primaryColor,
                                    );
                                  }),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
