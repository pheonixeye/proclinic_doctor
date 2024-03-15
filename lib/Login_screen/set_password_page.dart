import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class PasswordSettingPage extends StatefulWidget {
  const PasswordSettingPage({Key? key}) : super(key: key);
  @override
  State<PasswordSettingPage> createState() => _PasswordSettingPageState();
}

class _PasswordSettingPageState extends State<PasswordSettingPage> {
  late final TextEditingController password1Controller;
  late final TextEditingController password2Controller;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    password1Controller = TextEditingController();
    password2Controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    password1Controller.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double horSize = MediaQuery.of(context).size.width / 5;
    double verSize = MediaQuery.of(context).size.height / 5;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Set Password',
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<PxSelectedDoctor>(
        builder: (context, d, c) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: ThemeConstants.cd,
              child: Card(
                margin: EdgeInsets.fromLTRB(horSize, verSize, horSize, verSize),
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 150.0,
                              child: Text('Password'),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            SizedBox(
                              width: 350.0,
                              child: TextFormField(
                                controller: password1Controller,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Password',
                                ),
                                validator: (value) {
                                  if (password1Controller.text !=
                                      password2Controller.text) {
                                    return "Passwords Not Matching.";
                                  }
                                  return null;
                                },
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
                              width: 150.0,
                              child: Text('Confirm Password'),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            SizedBox(
                              width: 350.0,
                              child: TextFormField(
                                controller: password2Controller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Confirm Password',
                                ),
                                validator: (value) {
                                  if (password2Controller.text !=
                                      password1Controller.text) {
                                    return "Passwords Not Matching.";
                                  }
                                  return null;
                                },
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
                            if (_formKey.currentState!.validate()) {
                              await EasyLoading.show(status: "Loading...");
                              await d.updateSelectedDoctor(
                                docname: d.doctor!.docnameEN,
                                attribute: SxDoctor.PASSWORD,
                                value: password2Controller.text,
                              );
                              await EasyLoading.showSuccess(
                                  "Password Updated.");

                              await EasyLoading.dismiss();
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
