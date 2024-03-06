import 'dart:math';

import 'package:proclinic_doctor_windows/Patient_Profile_Page/patient_profile_page_main.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/today_patients_page/mongo_all_patients_single_doctor_with__today_date_db.dart';
import 'package:flutter/material.dart';

class TodayPatients extends StatefulWidget {
  const TodayPatients({super.key});

  @override
  _TodayPatientsState createState() => _TodayPatientsState();
}

class _TodayPatientsState extends State<TodayPatients> {
  AllPatientsSingleDoctorTodayDate todaypts = AllPatientsSingleDoctorTodayDate(
    docname: globallySelectedDoctor,
    day: DateTime.now().toString().substring(8, 10),
    month: DateTime.now().toString().substring(5, 7),
    year: DateTime.now().toString().substring(0, 4),
    phone: '',
    ptname: '',
  );

  List data = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: todaypts.allPatientsofOneDoctorinsetdate,
      builder: (context, snapshot) {
        data = snapshot.data!;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.80,
              child: Container(
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
                child: (snapshot.data != null && data.isEmpty)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemCount: !snapshot.hasData ? 0 : data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PatientProfilePage(
                                                  fromnew: true,
                                                ),
                                            settings: RouteSettings(arguments: {
                                              'id': data[index]['id'],
                                              'day': data[index]['day'],
                                              'month': data[index]['month'],
                                              'year': data[index]['year'],
                                              'dob': data[index]['dob'],
                                              'ptname': data[index]['ptname'],
                                              'age': data[index]['age'],
                                              'phone': data[index]['phone'],
                                              'amount': data[index]['amount'],
                                              'visit': data[index]['visit'],
                                              'procedure': data[index]
                                                  ['procedure'],
                                              'remaining': data[index]
                                                  ['remaining'],
                                              'cashtype': data[index]
                                                  ['cashtype'],
                                              'clinic': data[index]['clinic'],
                                              'docname': data[index]['docname'],
                                            })));
                                  },
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 30,
                                            child: Icon(Icons.person),
                                          ),
                                        ),
                                        Text('Name : ${data[index]['ptname']}'),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 30,
                                            child: Icon(
                                                Icons.local_hospital_sharp),
                                          ),
                                        ),
                                        Text(
                                            'Doctor : ${data[index]['docname']}'),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 30,
                                            child: Icon(Icons.phone),
                                          ),
                                        ),
                                        Text('Phone : ${data[index]['phone']}'),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 30,
                                            child: Icon(Icons.support_agent),
                                          ),
                                        ),
                                        Text('Age : ${data[index]['age']}'),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                      ]),
                                    ),
                                  ),
                                  subtitle: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 30,
                                            child: Icon(Icons.monetization_on),
                                          ),
                                        ),
                                        Text(
                                            'Paid : ${data[index]['amount']} L.E.'),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 30,
                                            child: Icon(Icons.money_off),
                                          ),
                                        ),
                                        Text(
                                            'Remaining : ${data[index]['remaining']} L.E.'),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 30,
                                            child: Icon(Icons.report_problem),
                                          ),
                                        ),
                                        Text(
                                            'Visit Type : ${data[index]['visit']}'),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 30,
                                            child: Icon(Icons.emoji_symbols),
                                          ),
                                        ),
                                        Text(
                                            'Procedure : ${data[index]['procedure'] == '' ? 'No Procedure' : data[index]['procedure']}'),
                                      ]),
                                    ),
                                  ),
                                ),
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
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
