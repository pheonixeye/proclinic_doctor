import 'dart:math';

import 'package:proclinic_doctor_windows/Find_Patients_page/organizer_pts/organizer_pts_db.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';

class OrganizerPatients extends StatefulWidget {
  const OrganizerPatients({super.key});

  @override
  _OrganizerPatientsState createState() => _OrganizerPatientsState();
}

class _OrganizerPatientsState extends State<OrganizerPatients> {
  AppOrganizedMongo orgpts = AppOrganizedMongo(docname: globallySelectedDoctor);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: orgpts.ptsOfOrganizer,
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
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      offset: const Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 5),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shadowColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
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
                            onTap: () {},
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
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: SizedBox(
                                  //     width: 30,
                                  //     child: Icon(Icons.local_hospital_sharp),
                                  //   ),
                                  // ),
                                  // Text(
                                  //     'Doctor : ${data[index]['docname'].toString().toUpperCase()}'),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 30,
                                      child: Icon(Icons.phone),
                                    ),
                                  ),
                                  Text('Phone : ${data[index]['phone']}'),
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
                                      child: Icon(Icons.calendar_today),
                                    ),
                                  ),
                                  Text(
                                      'Date : ${data[index]['date'].toString().substring(0, 10)} '),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 30,
                                      child: Icon(Icons.timer),
                                    ),
                                  ),
                                  Text(
                                      'Time : ${data[index]['time'].toString().substring(10, 15)}'),
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
        ));
      },
    );
  }
}
