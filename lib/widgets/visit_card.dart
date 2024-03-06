import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/patient_profile_page_main.dart';
import 'package:proclinic_doctor_windows/models/visitModel.dart';

class VisitCard extends StatelessWidget {
  const VisitCard({super.key, required this.visit, this.fromNew = false});
  final Visit visit;
  final bool fromNew;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientProfilePage(
                    fromnew: fromNew,
                  ),
                ),
              );
            },
            leading: const CircleAvatar(),
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
                  Text('Name : ${visit.toJson()['ptname']}'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.local_hospital_sharp),
                    ),
                  ),
                  Text('Doctor : ${visit.toJson()['docname']}'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.phone),
                    ),
                  ),
                  Text('Phone : ${visit.toJson()['phone']}'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.support_agent),
                    ),
                  ),
                  Text('DoB : ${visit.toJson()['dob']}'),
                  const SizedBox(
                    width: 30,
                  ),
                ]),
              ),
            ),
            subtitle: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 30,
                        child: Icon(Icons.monetization_on),
                      ),
                    ),
                    Text('Paid : ${visit.toJson()['amount']} L.E.'),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 30,
                        child: Icon(Icons.money_off),
                      ),
                    ),
                    Text('Remaining : ${visit.toJson()['remaining']} L.E.'),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 30,
                        child: Icon(Icons.report_problem),
                      ),
                    ),
                    Text('Visit Type : ${visit.toJson()['visittype']}'),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 30,
                        child: Icon(Icons.emoji_symbols),
                      ),
                    ),
                    Text(
                        'Procedure : ${visit.toJson()['procedure'] == '' ? 'No Procedure' : visit.toJson()['procedure']}'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
