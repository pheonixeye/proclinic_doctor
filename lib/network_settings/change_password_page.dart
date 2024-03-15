import 'dart:async';

import 'package:proclinic_doctor_windows/Alert_dialogs_random/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class PasswordChangePage extends StatefulWidget {
  final String docname;

  const PasswordChangePage({Key? key, required this.docname}) : super(key: key);
  @override
  State<PasswordChangePage> createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  late TextEditingController passwordoldController;
  late TextEditingController passwordnewController;

  @override
  void initState() {
    passwordoldController = TextEditingController();
    passwordnewController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double horSize = MediaQuery.of(context).size.width / 5;
    double verSize = MediaQuery.of(context).size.height / 5;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.docname.toUpperCase(),
          textScaler: const TextScaler.linear(2.0),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
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
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 150.0,
                              child: Text('Old Password'),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            SizedBox(
                              width: 350.0,
                              child: TextFormField(
                                obscuringCharacter: '*',
                                controller: passwordoldController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Old Password',
                                ),
                                validator: (value) {
                                  if (passwordoldController.text !=
                                      d.doctor!.password) {
                                    return "Wrong Old Password.";
                                  }
                                  if (passwordoldController.text !=
                                      passwordnewController.text) {
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
                              child: Text('New Password'),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            SizedBox(
                              width: 350.0,
                              child: TextFormField(
                                controller: passwordnewController,
                                obscuringCharacter: '*',
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter New Password',
                                ),
                                validator: (value) {
                                  if (passwordoldController.text !=
                                      passwordnewController.text) {
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
                            if (formKey.currentState!.validate()) {
                              if (passwordoldController.text ==
                                  d.doctor!.password) {
                                await d.updateSelectedDoctor(
                                  docname: d.doctor!.docnameEN,
                                  attribute: 'password',
                                  value:
                                      passwordnewController.text.trim().isEmpty
                                          ? null
                                          : passwordnewController.text,
                                );
                                if (context.mounted) {
                                  showCustomSnackbar(
                                    context: context,
                                    message: 'Password Updated.',
                                  );
                                }

                                await Future.delayed(
                                    const Duration(seconds: 1));
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
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
