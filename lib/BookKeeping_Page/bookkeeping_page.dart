import 'dart:math';

import 'package:proclinic_doctor_windows/BookKeeping_Page/mongo_all_patients_single_doctor_with_date_and_amount_db.dart';
import 'package:proclinic_doctor_windows/BookKeeping_Page/mongo_all_patients_single_doctor_with_date_db.dart';
import 'package:proclinic_doctor_windows/Date_Cupertino_selectors/date_cupertino_selectors.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/patient_profile_page_main.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';

class BookKeepingPage extends StatefulWidget {
  const BookKeepingPage({super.key});

  @override
  _BookKeepingPageState createState() => _BookKeepingPageState();
}

class _BookKeepingPageState extends State<BookKeepingPage> {
  @override
  Widget build(BuildContext context) {
    AllPatientsSingleDoctorWithDate allptsdate =
        AllPatientsSingleDoctorWithDate(
      docname: globallySelectedDoctor,
      day: globalDay,
      month: globalMonth.toString(),
      year: globalYear.toString(),
      phone: '',
      ptname: '',
    );
    AllPatientsSingleDoctorWithDateAndAmount allptsamount =
        AllPatientsSingleDoctorWithDateAndAmount(
      docname: globallySelectedDoctor,
      day: globalDay,
      month: globalMonth.toString(),
      year: globalYear.toString(),
      phone: '',
      ptname: '',
    );

    return StreamBuilder(
      stream: allptsdate.allptsonedoctornameinsetdate,
      builder: (context, snapshot) {
        final data =
            snapshot.hasData ? snapshot.data : [] as List<Map<String, dynamic>>;
        return Scaffold(
          body: SizedBox(
            child: Column(
              children: [
                //date selection card
                Expanded(
                  flex: 2,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          shadowColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          elevation: 10,
                          color: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)],
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Card(
                              color: Colors.white.withOpacity(0.8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(4.0, 4.0),
                                            blurRadius: 4.0,
                                          ),
                                        ],
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                          child: Text('   Select Date : ')),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 100,
                                    child: YearClinicPicker(),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 150,
                                    child: MonthClinicPicker(),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 100,
                                    child: DayClinicPicker(),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.primaries[
                                            Random().nextInt(
                                                Colors.primaries.length)],
                                      ),
                                      icon: const Icon(Icons.search),
                                      label: const Text('Search'),
                                      onPressed: () {
                                        setState(() {});
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                ),
                //list view of findings
                Expanded(
                  flex: 6,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    shadowColor: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        shadowColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                            itemCount: !snapshot.hasData ? 0 : data!.length,
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
                                            settings: RouteSettings(
                                              arguments: {
                                                'id': data?[index]['id'],
                                                'day': data?[index]['day'],
                                                'month': data?[index]['month'],
                                                'year': data?[index]['year'],
                                                'dob': data?[index]['dob'],
                                                'ptname': data?[index]
                                                    ['ptname'],
                                                'age': data?[index]['age'],
                                                'phone': data?[index]['phone'],
                                                'amount': data?[index]
                                                    ['amount'],
                                                'visit': data?[index]['visit'],
                                                'procedure': data?[index]
                                                    ['procedure'],
                                                'remaining': data?[index]
                                                    ['remaining'],
                                                'cashtype': data?[index]
                                                    ['cashtype'],
                                                'clinic': data?[index]
                                                    ['clinic'],
                                                'docname': data?[index]
                                                    ['docname'],
                                              },
                                            ),
                                          ),
                                        );
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
                                            Text(
                                                'Name : ${data?[index]['ptname']}'),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 30,
                                                child: Icon(
                                                    Icons.local_hospital_sharp),
                                              ),
                                            ),
                                            Text(
                                                'Doctor : ${data?[index]['docname']}'),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 30,
                                                child: Icon(Icons.phone),
                                              ),
                                            ),
                                            Text(
                                                'Phone : ${data?[index]['phone']}'),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 30,
                                                child:
                                                    Icon(Icons.support_agent),
                                              ),
                                            ),
                                            Text(
                                                'Age : ${data?[index]['age']}'),
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
                                                child:
                                                    Icon(Icons.monetization_on),
                                              ),
                                            ),
                                            Text(
                                                'Paid : ${data?[index]['amount']} L.E.'),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 30,
                                                child: Icon(Icons.money_off),
                                              ),
                                            ),
                                            Text(
                                                'Remaining : ${data?[index]['remaining']} L.E.'),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 30,
                                                child:
                                                    Icon(Icons.report_problem),
                                              ),
                                            ),
                                            Text(
                                                'Visit Type : ${data?[index]['visit']}'),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 30,
                                                child:
                                                    Icon(Icons.emoji_symbols),
                                              ),
                                            ),
                                            Text(
                                                'Procedure : ${data?[index]['procedure'] == '' ? 'No Procedure' : data?[index]['procedure']}'),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 30,
                                                child:
                                                    Icon(Icons.calendar_today),
                                              ),
                                            ),
                                            Text(
                                                'Visit Date : ${data?[index]['day']}-${data?[index]['month']}-${data?[index]['year']}'),
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
                  ),
                ),
                //amount calculator
                Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        shadowColor: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        elevation: 5.0,
                        child: ListTile(
                          trailing: const Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 1,
                                ),
                              ]),
                          title: !snapshot.hasData
                              ? const SizedBox.shrink()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Text(
                                          'Total Number of Patients of Dr. $globallySelectedDoctor in year $globalYear - month $globalMonth - till day $globalDay'),
                                      const SizedBox(width: 20),
                                      CircleAvatar(
                                        backgroundColor: Colors.primaries[
                                            Random().nextInt(
                                                Colors.primaries.length)],
                                        child: Text(
                                          '${data?.length}'.toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ]),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                  'Total income in searched duration in L.E.'),
                              const SizedBox(
                                width: 20,
                              ),
                              StreamBuilder(
                                stream: allptsamount
                                    .allPatientsofOneDoctorinsetdatewithamount,
                                builder: (context, snapshot) {
                                  var money1 = snapshot.data;
                                  return !snapshot.hasData
                                      ? const CircularProgressIndicator()
                                      : CircleAvatar(
                                          child: Text('$money1'),
                                        );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
