import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/drug_src_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/entrt_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/lab_rad_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/pres_segments/pres_drugs_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/pres_segments/pres_labs_segment.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/segmental_widgets/pres_segments/pres_rads_segment.dart';

import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';

class EntryPageByDoctor extends StatefulWidget {
  const EntryPageByDoctor({super.key});

  @override
  _EntryPageByDoctorState createState() => _EntryPageByDoctorState();
}

class _EntryPageByDoctorState extends State<EntryPageByDoctor>
    with TickerProviderStateMixin {
  List<TextEditingController> controllerList = [];
  List controllervaluelist = [];
  Map forwardedData = {};
  late final TabController _tabcontroller;
  int? labrad;
  late final TextEditingController drugsearchcontroller;

  callback(int value) {
    setState(() {
      labrad = value;
    });
  }

  callvoidback() {
    setState(() {});
  }

  @override
  void initState() {
    _tabcontroller = TabController(vsync: this, initialIndex: 0, length: 2);
    drugsearchcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    drugsearchcontroller.dispose();
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            leading: const SizedBox.shrink(),
            centerTitle: true,
            title: const Text(
              'Medical Info Entry Page "Sheet"',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          AppBar(
            centerTitle: true,
            backgroundColor: Colors.purple[300]?.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            leading: const SizedBox.shrink(),
            title: const Text(
              'Medical Prescriptions Page',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabcontroller,
        children: [
          //1st tab page for clinic data entry
          const EntrySegment(),
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
                  ),
                );
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: ThemeConstants.cd,
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
                                  decoration: ThemeConstants.cd,
                                  child: Row(
                                    children: [
                                      //drug search listtile
                                      Expanded(
                                        flex: 5,
                                        child: DrugSearchSegment(
                                          drugsearchcontroller:
                                              drugsearchcontroller,
                                        ),
                                      ),
                                      //dosage segment
                                      const Expanded(
                                        flex: 3,
                                        child: SizedBox(),
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
                                  decoration: ThemeConstants.cd,
                                  child: const LabRadSegment(),
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
                            decoration: ThemeConstants.cd,
                            child: Column(
                              children: [
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
                                      const Expanded(
                                        flex: 1,
                                        //stream of labs
                                        child: LabGetterSegment(),
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
                              ],
                            ),
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
