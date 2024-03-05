import 'dart:math';

import 'package:proclinic_doctor_windows/Find_Patients_page/all_patients_under/mongo_all_patients_single_doctor_db.dart';
import 'package:proclinic_doctor_windows/Find_Patients_page/search_patients_under/mongo_searched_patients_db.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/patient_profile_page_main.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';

class SearchPatientsUnder extends StatefulWidget {
  const SearchPatientsUnder({super.key});

  @override
  _SearchPatientsUnderState createState() => _SearchPatientsUnderState();
}

class _SearchPatientsUnderState extends State<SearchPatientsUnder> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AllPatientsSingleDoctor allpts =
        AllPatientsSingleDoctor(docname: globallySelectedDoctor);
    SearchedPatients srcpts = SearchedPatients(
        docname: globallySelectedDoctor,
        ptname: _controller.text,
        phone: _controller.text);
    return StreamBuilder(
      stream: _controller.text.isEmpty
          ? allpts.allPatientsofOneDoctor
          : srcpts.searchedMongoPatients,
      builder: (context, snapshot) {
        List data = snapshot.data!;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
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
              child: Column(
                children: [
                  //search bar
                  Expanded(
                      flex: 2,
                      child: Card(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        child: Card(
                          color: Colors.white.withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 10,
                          shadowColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 10,
                                  shadowColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  child: const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text('Search Patients : '),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 10,
                                  shadowColor: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  child: SizedBox(
                                      width: 400,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            50, 3, 50, 3),
                                        child: TextField(
                                          onChanged: (String value) {
                                            setState(() {});
                                          },
                                          controller: _controller,
                                          enableInteractiveSelection: true,
                                          enabled: true,
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            icon: Icon(Icons.search),
                                            hintText: '...',
                                            labelText: 'Search by Name / Phone',
                                            alignLabelWithHint: true,
                                            fillColor: Colors.white,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  //search results
                  Expanded(
                    flex: 8,
                    child: Card(
                      child: ListView.separated(
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
                                                PatientProfilePage(
                                                  fromnew: false,
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
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 30,
                                            child: Icon(Icons.calendar_today),
                                          ),
                                        ),
                                        Text(
                                            'Visit Date : ${data[index]['day']}-${data[index]['month']}-${data[index]['year']}'),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
