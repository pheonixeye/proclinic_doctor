import 'dart:math';

import 'package:proclinic_doctor_windows/Alert_dialogs_random/alert_dialogs.dart';
import 'package:proclinic_doctor_windows/Mongo_db_doctors/mongo_doctors_db.dart';
import 'package:flutter/material.dart';

class PasswordSettingPage extends StatefulWidget {
  final String docname;

  const PasswordSettingPage({Key? key, required this.docname})
      : super(key: key);
  @override
  _PasswordSettingPageState createState() => _PasswordSettingPageState();
}

class _PasswordSettingPageState extends State<PasswordSettingPage> {
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DoctorsMongoDatabase docmongo = DoctorsMongoDatabase();
    double horSize = MediaQuery.of(context).size.width / 5;
    double verSize = MediaQuery.of(context).size.height / 5;
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: Text(
          widget.docname.toUpperCase(),
          textScaler: const TextScaler.linear(2.0),
          style: const TextStyle(fontWeight: FontWeight.bold),
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
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      offset: const Offset(5, 5),
                      blurRadius: 5,
                      spreadRadius: 5),
                ]),
            child: Card(
              shadowColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              margin: EdgeInsets.fromLTRB(horSize, verSize, horSize, verSize),
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 150.0, child: Text('Password')),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextField(
                            obscuringCharacter: '*',
                            controller: password1Controller,
                            obscureText: false,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            width: 150.0, child: Text('ReEnter Password')),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextField(
                            controller: password2Controller,
                            obscuringCharacter: '*',
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Confirm Password',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                        onPressed: () async {
                          setState(() {});
                          if (password1Controller.text !=
                              password2Controller.text) {
                            showAlertDialogpasswordsnotmatching(context);
                          } else if (password1Controller.text ==
                              password2Controller.text) {
                            //update doctor password//
                            docmongo.updatepasswordintomongo(
                                docname: widget.docname,
                                password: password1Controller.text);
                            //then//
                            const snackbar = SnackBar(
                                duration: Duration(milliseconds: 50),
                                content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Password Updated.',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.thumb_up_alt_rounded,
                                        color: Colors.green,
                                      )
                                    ]));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                            await Future.delayed(const Duration(seconds: 1));
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
