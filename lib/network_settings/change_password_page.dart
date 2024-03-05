import 'dart:async';
import 'dart:math';

import 'package:proclinic_doctor_windows/Alert_dialogs_random/alert_dialogs.dart';
import 'package:proclinic_doctor_windows/Mongo_db_doctors/mongo_doctors_db.dart';
import 'package:flutter/material.dart';

class PasswordChangePage extends StatefulWidget {
  final String docname;

  const PasswordChangePage({Key? key, required this.docname}) : super(key: key);
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  TextEditingController passwordoldController = TextEditingController();
  TextEditingController passwordnewController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hor_size = MediaQuery.of(context).size.width / 5;
    double ver_size = MediaQuery.of(context).size.height / 5;
    DoctorsMongoDatabase docmongo = DoctorsMongoDatabase();
    OneMongoDoctor oneMongoDoctor = OneMongoDoctor(docname: widget.docname);
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
          textScaleFactor: 2.0,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: oneMongoDoctor.oneDoctorfromMongo,
          builder: (context, snapshot) {
            List data = snapshot.data!;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                                width: 150.0, child: Text('Old Password')),
                            const SizedBox(
                              width: 20.0,
                            ),
                            SizedBox(
                              width: 350.0,
                              child: TextField(
                                obscuringCharacter: '*',
                                controller: passwordoldController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Old Password',
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
                                width: 150.0, child: Text('New Password')),
                            const SizedBox(
                              width: 20.0,
                            ),
                            SizedBox(
                              width: 350.0,
                              child: TextField(
                                controller: passwordnewController,
                                obscuringCharacter: '*',
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter New Password',
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
                              if (passwordoldController.text !=
                                  data[0]['password']) {
                                showAlertDialogpasswordsnotmatching(context);
                              } else if (passwordoldController.text ==
                                  data[0]['password']) {
                                await docmongo.updatepasswordintomongo(
                                    docname: widget.docname,
                                    password: passwordnewController.text == ''
                                        ? null
                                        : passwordnewController.text);
                                const snackbar = SnackBar(
                                    duration: Duration(milliseconds: 50),
                                    content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                await Future.delayed(
                                    const Duration(seconds: 1));
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
