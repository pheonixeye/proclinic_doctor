import 'dart:async';
import 'dart:math';

import 'package:proclinic_doctor_windows/network_settings/change_password_page.dart';
import 'package:proclinic_doctor_windows/Login_screen/set_password_page.dart';
import 'package:proclinic_doctor_windows/Mongo_db_doctors/mongo_doctors_db.dart';
import 'package:proclinic_doctor_windows/Not_Connected_To_Db/not_connected_db.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:proclinic_doctor_windows/network_settings/network_settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Alert_dialogs_random/alert_dialogs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final List docdata;
  TextEditingController passwordController = TextEditingController();

  Future listentoOnedoctorStream() async {
    OneMongoDoctor onedocdata = OneMongoDoctor(docname: globallySelectedDoctor);
    onedocdata.oneDoctorfromMongo.listen((event) {
      docdata = event;
      // print('-${event}***************************************');
    }).onError((e) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NoDBConnectionPage(
            error: e.toString(),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      listentoOnedoctorStream();
    });
    super.initState();
  }

  @override
  void dispose() {
    //TODO: dispose of listening to doctor stream
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double hor_size = MediaQuery.of(context).size.width / 5;
    double ver_size = MediaQuery.of(context).size.height / 6;

    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              title: const Text(
                'ProClinic Login Page',
                textScaleFactor: 2.0,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Builder(builder: (context) {
              return Padding(
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
                  child: Card(
                    shadowColor: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    margin: EdgeInsets.fromLTRB(
                        hor_size, ver_size, hor_size, ver_size),
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 150.0, child: Text('Clinic')),
                              SizedBox(
                                width: 20.0,
                              ),
                              SizedBox(
                                width: 350.0,
                                child: NewlyFormatedDoctorsDropDownButton(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                  width: 150.0, child: Text('Password')),
                              const SizedBox(
                                width: 20.0,
                              ),
                              SizedBox(
                                width: 350.0,
                                child: TextField(
                                  controller: passwordController,
                                  obscuringCharacter: '*',
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Password',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          SizedBox(
                            width: 400,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                        icon: const Icon(Icons.person),
                                        label: const Text('Login'),
                                        onPressed: () async {
                                          setState(() {});
                                          if (globallySelectedDoctor.isEmpty) {
                                            showAlertDialogselectdoctorfirst(
                                                context);
                                          } else if (docdata[0]['password'] ==
                                              null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PasswordSettingPage(
                                                          docname:
                                                              globallySelectedDoctor,
                                                        )));
                                          } else if (docdata[0]['password'] ==
                                              passwordController.text) {
                                            Navigator.pushReplacementNamed(
                                                context, '/controlpanel',
                                                arguments: {
                                                  'docname':
                                                      globallySelectedDoctor
                                                });

                                            print('successful login');
                                          } else if (docdata[0]['password'] !=
                                              passwordController.text) {
                                            showAlertDialogWrongPassword(
                                                context);
                                          }
                                        }),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          SizedBox(
                            width: 400,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      icon: const Icon(Icons.text_snippet),
                                      label: const Text('Change Password'),
                                      onPressed: () {
                                        setState(() {});
                                        if (globallySelectedDoctor.isEmpty) {
                                          showAlertDialogselectdoctorfirst(
                                              context);
                                        } else if (globallySelectedDoctor
                                            .isNotEmpty) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PasswordChangePage(
                                                        docname:
                                                            globallySelectedDoctor,
                                                      )));
                                        }
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 400,
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    icon: const Icon(Icons.network_check),
                                    label: const Text('Network Settings'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NetworkSettingsPage()));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        });
  }
}
