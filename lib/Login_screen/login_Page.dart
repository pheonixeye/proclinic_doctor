import 'package:proclinic_doctor_windows/network_settings/change_password_page.dart';
import 'package:proclinic_doctor_windows/Login_screen/set_password_page.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:proclinic_doctor_windows/network_settings/network_settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Alert_dialogs_random/alert_dialogs.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double horSize = MediaQuery.of(context).size.width / 5;
    final double verSize = MediaQuery.of(context).size.height / 6;

    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: const Text(
              'ProClinic Login Page',
              textScaler: TextScaler.linear(2.0),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: ThemeConstants.cd,
                child: Card(
                  margin:
                      EdgeInsets.fromLTRB(horSize, verSize, horSize, verSize),
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
                                child: Consumer<PxSelectedDoctor>(
                                  builder: (context, d, c) {
                                    return ElevatedButton.icon(
                                      icon: const Icon(Icons.person),
                                      label: const Text('Login'),
                                      onPressed: () async {
                                        setState(() {});
                                        if (d.doctor == null) {
                                          showAlertDialogselectdoctorfirst(
                                              context);
                                        } else if (d.doctor?.password == null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const PasswordSettingPage(),
                                            ),
                                          );
                                        } else if (d.doctor?.password ==
                                            passwordController.text) {
                                          Navigator.pushReplacementNamed(
                                              context, '/controlpanel',
                                              arguments: {
                                                'docname': d.doctor!.docnameEN
                                              });

                                          print('successful login');
                                        } else if (d.doctor?.password !=
                                            passwordController.text) {
                                          showAlertDialogWrongPassword(context);
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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
                                child: Consumer<PxSelectedDoctor>(
                                  builder: (context, d, c) {
                                    return ElevatedButton.icon(
                                      icon: const Icon(Icons.text_snippet),
                                      label: const Text('Change Password'),
                                      onPressed: () {
                                        setState(() {});
                                        if (d.doctor == null) {
                                          showAlertDialogselectdoctorfirst(
                                              context);
                                        } else if (d.doctor != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PasswordChangePage(
                                                docname: d.doctor!.docnameEN,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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
                                            const NetworkSettingsPage(),
                                      ),
                                    );
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
      },
    );
  }
}
