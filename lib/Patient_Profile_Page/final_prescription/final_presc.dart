import 'dart:ffi';
import 'dart:math';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/get_drug_lab_rad_from_db.dart';
import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/clinic_details_db.dart';
import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/doc_titles_db.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:win32/win32.dart';

Future runprintimg() async {
  // await Process.runSync('powershell.exe',
  //     ['start-process c:\\users\\kelsier_2\\desktop\\pres.png -verb print'],
  //     runInShell: true);
  await ShellExecute(
      1,
      TEXT('print'),
      TEXT('c:\\users\\kareemzaher\\desktop\\pres.png'),
      nullptr,
      nullptr,
      SW_SHOW);
}

class FinalPrescription extends StatefulWidget {
  final Map forwardedData;
  const FinalPrescription({super.key, required this.forwardedData});
  @override
  _FinalPrescriptionState createState() => _FinalPrescriptionState();
}

class _FinalPrescriptionState extends State<FinalPrescription> {
  TitlesClass titles = TitlesClass(docname: globallySelectedDoctor);
  ClinicDetailsClass clinicdetails =
      ClinicDetailsClass(docname: globallySelectedDoctor);

  @override
  Widget build(BuildContext context) {
    DrugGetterFromDb druggetter = DrugGetterFromDb(
        id: widget.forwardedData['id'],
        day: widget.forwardedData['day'],
        ptname: widget.forwardedData['ptname'],
        docname: widget.forwardedData['docname'],
        month: widget.forwardedData['month'],
        year: widget.forwardedData['year'],
        phone: widget.forwardedData['phone'],
        procedure: widget.forwardedData['procedure'],
        age: widget.forwardedData['age'],
        amount: widget.forwardedData['amount'],
        visit: widget.forwardedData['visit'],
        remaining: widget.forwardedData['remaining'],
        cashtype: widget.forwardedData['cashtype'],
        clinic: widget.forwardedData['clinic'],
        dob: widget.forwardedData['dob'],
        drl: 'drugs');
    DrugGetterFromDb labgetter = DrugGetterFromDb(
        id: widget.forwardedData['id'],
        day: widget.forwardedData['day'],
        ptname: widget.forwardedData['ptname'],
        docname: widget.forwardedData['docname'],
        month: widget.forwardedData['month'],
        year: widget.forwardedData['year'],
        phone: widget.forwardedData['phone'],
        procedure: widget.forwardedData['procedure'],
        age: widget.forwardedData['age'],
        amount: widget.forwardedData['amount'],
        visit: widget.forwardedData['visit'],
        remaining: widget.forwardedData['remaining'],
        cashtype: widget.forwardedData['cashtype'],
        clinic: widget.forwardedData['clinic'],
        dob: widget.forwardedData['dob'],
        drl: 'labs');
    DrugGetterFromDb radgetter = DrugGetterFromDb(
        id: widget.forwardedData['id'],
        day: widget.forwardedData['day'],
        ptname: widget.forwardedData['ptname'],
        docname: widget.forwardedData['docname'],
        month: widget.forwardedData['month'],
        year: widget.forwardedData['year'],
        phone: widget.forwardedData['phone'],
        procedure: widget.forwardedData['procedure'],
        age: widget.forwardedData['age'],
        amount: widget.forwardedData['amount'],
        visit: widget.forwardedData['visit'],
        remaining: widget.forwardedData['remaining'],
        cashtype: widget.forwardedData['cashtype'],
        clinic: widget.forwardedData['clinic'],
        dob: widget.forwardedData['dob'],
        drl: 'rads');
    ScreenshotController screenshotController = ScreenshotController();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.print),
        onPressed: () async {
          // await print('button pressed');
          await screenshotController
              .captureAndSave('c:/users/kareemzaher/desktop/pres.png');
          // await print('image generated');

          await Future.delayed(const Duration(seconds: 1));
          // await print('duration waited');
          await runprintimg();

          // await print('script ran');
        },
      ),
      body: Center(
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.99,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(1.0),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      offset: const Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 5),
                ]),
            child: Column(
              children: [
                //patient data, doctor titles ==>> (A)
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                    'Date: ${widget.forwardedData['day']}-${widget.forwardedData['month']}-${widget.forwardedData['year']}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                    'Name: ${widget.forwardedData['ptname']}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                    'Age: ${widget.forwardedData['age']} Years'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                    'Visit: ${widget.forwardedData['visit']}'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //doctor titles
                      Expanded(
                        flex: 1,
                        child: StreamBuilder(
                            stream: titles.doctortitlelist,
                            builder: (context, docsnap) {
                              List data = !docsnap.hasData ? [] : docsnap.data;
                              return ListView.builder(
                                itemCount: !docsnap.hasData ? 0 : data.length,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 4, 7, 4),
                                      child: Text(
                                          data[index].toString().toUpperCase()),
                                    ),
                                  );
                                },
                              );
                            }),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.blueGrey,
                  height: 10,
                  thickness: 3,
                ),
                //------------------------------//
                //drugs - labs - rads
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      //drugs
                      Expanded(
                        flex: 5,
                        child: StreamBuilder(
                          stream: druggetter.drugforptgetterstream,
                          builder: (context, snapshot) {
                            List data = !snapshot.hasData ? [] : snapshot.data;
                            return ListView.builder(
                              itemExtent: 45,
                              itemCount: !snapshot.hasData ? 0 : data.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const CircleAvatar(
                                    child: Text(
                                      '℞',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  title: Text(
                                      data[index].toString().toUpperCase()),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      //labs and rads
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            //labs
                            Expanded(
                              flex: 1,
                              child: StreamBuilder(
                                  stream: labgetter.drugforptgetterstream,
                                  builder: (context, snapshot) {
                                    List data =
                                        !snapshot.hasData ? [] : snapshot.data;

                                    return GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 6),
                                      itemCount:
                                          !snapshot.hasData ? 0 : data.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child: Text(
                                                '• ${data[index].toString().toUpperCase()}'));
                                      },
                                    );
                                  }),
                            ),
                            //rads
                            Expanded(
                              flex: 1,
                              child: StreamBuilder(
                                  stream: radgetter.drugforptgetterstream,
                                  builder: (context, snapshot) {
                                    List data =
                                        !snapshot.hasData ? [] : snapshot.data;

                                    return ListView.builder(
                                      // gridDelegate:
                                      //     SliverGridDelegateWithFixedCrossAxisCount(
                                      //         crossAxisCount: 3,
                                      //         childAspectRatio: 4),
                                      itemCount:
                                          !snapshot.hasData ? 0 : data.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                            child: Text(
                                                '• ${data[index].toString().toUpperCase()}'));
                                      },
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.blueGrey,
                  height: 10,
                  thickness: 3,
                ),
                //clinic details
                Expanded(
                  flex: 1,
                  child: StreamBuilder(
                      stream: clinicdetails.doctorClinicDetailslist,
                      builder: (context, clinicsnap) {
                        List data = !clinicsnap.hasData ? [] : clinicsnap.data;

                        return ListView.builder(
                          itemCount: !clinicsnap.hasData ? 0 : data.length,
                          itemBuilder: (context, index) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(data[index].toString()),
                            ));
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
