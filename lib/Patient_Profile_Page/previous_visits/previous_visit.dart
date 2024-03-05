import 'package:proclinic_doctor_windows/Patient_Profile_Page/final_prescription/final_presc.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/manual_medical_mongo.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/patient_profile_page_main.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/previous_visits/popupmenubutton_custom.dart';
import 'package:proclinic_doctor_windows/print_sheet_page/print_sheet_page.dart';
import 'package:flutter/material.dart';

class PreviousVisitsPage extends StatefulWidget {
  const PreviousVisitsPage({super.key});

  @override
  _PreviousVisitsPageState createState() => _PreviousVisitsPageState();
}

class _PreviousVisitsPageState extends State<PreviousVisitsPage> {
  late final forwardedData;
  List? _medinfolist;
  get medinfolist => _medinfolist;

  @override
  void initState() {
    // MedicalFieldsClass medfield =
    //     MedicalFieldsClass(docname: globallySelectedDoctor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    forwardedData = ModalRoute.of(context)?.settings.arguments;
    // int index;
    // event_.forEach((element) {
    //   index = event_.indexOf(element);
    // });
    // print(forwardedData);
    ManualEntryMedicalInfo medinfo = ManualEntryMedicalInfo(
      id: forwardedData['id'],
      // day: forwardedData['day'],
      ptname: forwardedData['ptname'],
      docname: forwardedData['docname'],
      // month: forwardedData['month'],
      // year: forwardedData['year'],
      phone: forwardedData['phone'],
      procedure: forwardedData['procedure'],
      age: forwardedData['age'],
      amount: forwardedData['amount'],
      visit: forwardedData['visit'],
      remaining: forwardedData['remaining'],
      cashtype: forwardedData['cashtype'],
      clinic: forwardedData['clinic'],
      dob: forwardedData['dob'],
      // index: index
    );
    void callUpdateinpopButton() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const PatientProfilePage(
                  fromnew: true,
                ),
            settings: RouteSettings(arguments: {
              'id': forwardedData['id'],
              'day': forwardedData['day'],
              'month': forwardedData['month'],
              'year': forwardedData['year'],
              'dob': forwardedData['dob'],
              'ptname': forwardedData['ptname'],
              'age': forwardedData['age'],
              'phone': forwardedData['phone'],
              'amount': forwardedData['amount'],
              'visit': forwardedData['visit'],
              'procedure': forwardedData['procedure'],
              'remaining': forwardedData['remaining'],
              'cashtype': forwardedData['cashtype'],
              'clinic': forwardedData['clinic'],
              'docname': forwardedData['docname'],
            })),
      );
    }

    void callprescinpopupbutton() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FinalPrescription(
              forwardedData: forwardedData,
            ),
          ));
    }

    return StreamBuilder(
        stream: medinfo.medinfoStream,
        builder: (context, snapshot) {
          // print(snapshot.data);

          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purple[300]?.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                leading: const SizedBox.shrink(),
                title: const Text(
                  'Previous Visits :',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              body: Container(
                child: StreamBuilder(
                  stream: medinfo.medinfoStream,
                  builder: (context, snapshot) {
                    List data1 = snapshot.data;

                    // print(' returned data ==>> ${data1}');
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        List? medinfolist = data1[index]['medinfo'];
                        _medinfolist = medinfolist;
                        print(medinfolist);

                        return ListTile(
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                          trailing: CustomPOPUPBUTTON(
                            callUpdate: callUpdateinpopButton,
                            callPrint: callprintinpopupbutton,
                            callPresc: callprescinpopupbutton,
                          ),
                          title: Card(
                            elevation: 10,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 30,
                                        child: Icon(Icons.person),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${data1[index]['ptname']}',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 30,
                                        child: Icon(Icons.calendar_today),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${data1[index]['day']}-${data1[index]['month']}-${data1[index]['year']}',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                          subtitle: Card(
                            elevation: 10,
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: medinfolist == null
                                    ? 0.0
                                    : medinfolist.length * 150.0.toDouble(),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.separated(
                                    itemCount: medinfolist == null
                                        ? 0
                                        : medinfolist.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          tileColor: Colors.grey[300],
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.purple[500]
                                                ?.withOpacity(0.5),
                                          ),
                                          title: FractionallySizedBox(
                                            alignment: Alignment.topLeft,
                                            widthFactor: medinfolist![index]
                                                    .keys
                                                    .toString()
                                                    .length /
                                                50.toDouble(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        offset: Offset(2, 2),
                                                        spreadRadius: 2,
                                                        blurRadius: 2)
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    medinfolist[index]
                                                        .keys
                                                        .toString()
                                                        .substring(
                                                            1,
                                                            medinfolist[index]
                                                                    .keys
                                                                    .toString()
                                                                    .length -
                                                                1),
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                medinfolist[index]
                                                    .values
                                                    .toString()
                                                    .substring(
                                                        1,
                                                        medinfolist[index]
                                                                .values
                                                                .toString()
                                                                .length -
                                                            1),
                                                style: const TextStyle(
                                                    fontSize: 24),
                                              ),
                                            ),
                                          ),
                                          trailing: IconButton(
                                            tooltip: 'Delete Entry',
                                            icon: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.red,
                                            ),
                                            onPressed: () async {
                                              //TODO: make delete entry function
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      title: const Text(
                                                          'Delete Entry ??'),
                                                      content:
                                                          const SingleChildScrollView(
                                                        child: Text(
                                                            'Deleting this entry makes this data no longer available. \n Are You Sure ?'),
                                                      ),
                                                      actions: [
                                                        ElevatedButton.icon(
                                                          icon: const Icon(
                                                            Icons.check,
                                                            color: Colors.green,
                                                          ),
                                                          label: const Text(
                                                              'Confirm'),
                                                          onPressed: () async {
                                                            await medinfo
                                                                .deleteEntryFromListmedinfo(
                                                              id_:
                                                                  forwardedData[
                                                                      'id'],
                                                              day_:
                                                                  forwardedData[
                                                                      'day'],
                                                              ptName_:
                                                                  forwardedData[
                                                                      'ptname'],
                                                              docName_:
                                                                  forwardedData[
                                                                      'docname'],
                                                              month_:
                                                                  forwardedData[
                                                                      'month'],
                                                              year_:
                                                                  forwardedData[
                                                                      'year'],
                                                              phone_:
                                                                  forwardedData[
                                                                      'phone'],
                                                              procedure_:
                                                                  forwardedData[
                                                                      'procedure'],
                                                              age_:
                                                                  forwardedData[
                                                                      'age'],
                                                              amount_:
                                                                  forwardedData[
                                                                      'amount'],
                                                              visit_:
                                                                  forwardedData[
                                                                      'visit'],
                                                              remaining_:
                                                                  forwardedData[
                                                                      'remaining'],
                                                              cashtype_:
                                                                  forwardedData[
                                                                      'cashtype'],
                                                              clinic_:
                                                                  forwardedData[
                                                                      'clinic'],
                                                              dob_:
                                                                  forwardedData[
                                                                      'dob'],
                                                              // index: index,
                                                              fieldname: medinfolist[
                                                                      index]
                                                                  .keys
                                                                  .toString()
                                                                  .substring(
                                                                      1,
                                                                      medinfolist[index]
                                                                              .keys
                                                                              .toString()
                                                                              .length -
                                                                          1),
                                                              fieldvalue: medinfolist[
                                                                      index]
                                                                  .values
                                                                  .toString()
                                                                  .substring(
                                                                      1,
                                                                      medinfolist[index]
                                                                              .values
                                                                              .toString()
                                                                              .length -
                                                                          1),
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                        ),
                                                        ElevatedButton.icon(
                                                          icon: const Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                          ),
                                                          label: const Text(
                                                              'Cancel'),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  });

                                              print(
                                                  'delete fns called on ${medinfolist[index].keys} & ${medinfolist[index].values}');
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        color: Colors.blueGrey,
                                        thickness: 3,
                                        height: 10,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: !snapshot.hasData ? 0 : data1.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.blueGrey,
                          thickness: 5,
                          height: 15,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        });
  }

  void callprintinpopupbutton() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const PrintSheetPage(),
          settings: RouteSettings(arguments: {
            'id': forwardedData['id'],
            'day': forwardedData['day'],
            'month': forwardedData['month'],
            'year': forwardedData['year'],
            'dob': forwardedData['dob'],
            'ptname': forwardedData['ptname'],
            'age': forwardedData['age'],
            'phone': forwardedData['phone'],
            'amount': forwardedData['amount'],
            'visit': forwardedData['visit'],
            'procedure': forwardedData['procedure'],
            'remaining': forwardedData['remaining'],
            'cashtype': forwardedData['cashtype'],
            'clinic': forwardedData['clinic'],
            'docname': forwardedData['docname'],
            'medicalvisitinfo': medinfolist
          })),
    );
  }
}
