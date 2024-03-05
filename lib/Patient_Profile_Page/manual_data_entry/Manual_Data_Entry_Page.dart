import 'dart:math';

import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/dosage_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/drug_src_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/entrt_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/lab_rad_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/pres_segments/pres_drugs_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/pres_segments/pres_labs_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/pres_segments/pres_rads_segment.dart';
import 'package:proclinic_doctor_windows/control_panel/fields_mongo_db.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';

class EntryPageByDoctor extends StatefulWidget {
  TextEditingController _drugsearchcontroller = TextEditingController();

  EntryPageByDoctor({super.key});

  TextEditingController get drugsearchcontroller => _drugsearchcontroller;

  set drugsearchcontroller(TextEditingController drugsearchcontroller) {
    _drugsearchcontroller = drugsearchcontroller;
  }

  @override
  _EntryPageByDoctorState createState() => _EntryPageByDoctorState();
}

class _EntryPageByDoctorState extends State<EntryPageByDoctor>
    with TickerProviderStateMixin {
  //rads and labs getter stream
  // LabsClass labs = LabsClass(docname: globallySelectedDoctor);
  // RadsClass rads = RadsClass(docname: globallySelectedDoctor);
  // DrugsClass drugs = DrugsClass(docname: globallySelectedDoctor);

  // AnimationController _animationController;
  List<TextEditingController> controllerList = [];
  List controllervaluelist = [];
  Map forwardedData = {};
  // bool gridview;
  // OneDoctorGridStream gridStream =
  //     OneDoctorGridStream(docname: globallySelectedDoctor);
  late final TabController _tabcontroller;
  int? labrad;

  callback(int value) {
    setState(() {
      labrad = value;
    });
  }

  callvoidback() {
    setState(() {});
  }

  // Stream drugstream;
  // Stream labradstream;

  // ManualEntryMedicalInfo entryMedicalInfo = ManualEntryMedicalInfo();

  MedicalFieldsClass medfield =
      MedicalFieldsClass(docname: globallySelectedDoctor);

  @override
  void initState() {
    // _animationController = AnimationController(
    //     vsync: this, duration: Duration(seconds: 2), value: 0.0);
    // _animationController.forward();
    _tabcontroller = TabController(vsync: this, initialIndex: 0, length: 2);

    medfield.fieldStream.listen((event) {
      for (var _ in event) {
        controllerList.add(TextEditingController());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // _animationController.dispose();
    // _tabcontroller.dispose();
    widget.drugsearchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    forwardedData = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: TabBar(
        controller: _tabcontroller,
        tabs: [
          AppBar(
            backgroundColor: Colors.purple[300]?.withOpacity(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            leading: const SizedBox.shrink(),
            centerTitle: true,
            title: const Text(
              'Medical Info Entry Page "Sheet"',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          AppBar(
            centerTitle: true,
            backgroundColor: Colors.purple[300]?.withOpacity(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            leading: const SizedBox.shrink(),
            title: const Text(
              'Medical Prescriptions Page',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabcontroller,
        children: [
          //1st tab page for clinic data entry
          EntrySegment(
            forwardedData: forwardedData,
            controllerList: controllerList,
            controllervaluelist: controllervaluelist,
          ),
          //2nd tab page for medical prescriptions
          //--------------------------------------//
          //***************************************// */
          Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndDocked,
            floatingActionButton: FloatingActionButton(
              isExtended: true,
              elevation: 50,
              backgroundColor: Colors.orange[400],
              tooltip: 'Print Prescription',
              child: const Icon(Icons.print),
              onPressed: () {
                //TODO: navigate to prescription page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinalPrescription(
                        forwardedData: forwardedData,
                      ),
                    ));
              },
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      //to write drugs labs and rads
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            //to write drugs
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
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
                                  child: Row(
                                    children: [
                                      //drug search listtile
                                      Expanded(
                                        flex: 5,
                                        child: DrugSearchSegment(
                                          drugsearchcontroller:
                                              widget.drugsearchcontroller,
                                        ),
                                      ),
                                      //dosage segment
                                      Expanded(
                                        flex: 3,
                                        child: DosageSegment(
                                          drugcont: widget.drugsearchcontroller,
                                          forwardedData: forwardedData,
                                          callback: callvoidback,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const Divider(
                              thickness: 5,
                              height: 10,
                              color: Colors.blueGrey,
                            ),
                            //to write labs and rads
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
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
                                  child: LabRadSegment(
                                    callstateback: callvoidback,
                                    callback: callback,
                                    labrad: labrad!,
                                    forwardedData: forwardedData,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                        thickness: 5,
                        color: Colors.blueGrey,
                      ),
                      //to show drugs labs and rads
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
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
                              ],
                            ),
                            child: Column(children: [
                              Expanded(
                                flex: 5,
                                //stream of drugs / prescription
                                child: DrugGetterSegment(
                                  forwardedData: forwardedData,
                                  callback: () {},
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      //stream of labs
                                      child: LabGetterSegment(
                                        forwardedData: forwardedData,
                                        callback: () {},
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      //stream of rads
                                      child: RadGetterSegment(
                                        forwardedData: forwardedData,
                                        callback: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
