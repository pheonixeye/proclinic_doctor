import 'package:after_layout/after_layout.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor/network_settings/change_password_page.dart';
import 'package:proclinic_doctor/Login_screen/set_password_page.dart';
import 'package:proclinic_doctor/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
// import 'package:proclinic_doctor/network_settings/network_settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor/Alert_dialogs_random/alert_dialogs.dart';
import 'package:proclinic_doctor/providers/selected_doctor.dart';
import 'package:proclinic_doctor/providers/socket_provider.dart';
import 'package:proclinic_doctor/providers/supplies_provider.dart';
// import 'package:proclinic_doctor/theme/theme.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin {
  TextEditingController passwordController = TextEditingController();
  @override
  void afterFirstLayout(BuildContext context) {
    context.read<PxSelectedDoctor>().selectDoctor(null);
  }

  @override
  Widget build(BuildContext context) {
    final double horSize = MediaQuery.of(context).size.width / 5;
    final double verSize = MediaQuery.of(context).size.height / 7;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ProClinic Login Page',
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Builder(
        builder: (context) {
          return Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                margin: EdgeInsets.fromLTRB(horSize, verSize, horSize, verSize),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 150.0, child: Text('Clinic')),
                          SizedBox(width: 20.0),
                          SizedBox(
                            width: 350.0,
                            child: NewlyFormatedDoctorsDropDownButton(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 150.0, child: Text('Password')),
                          const SizedBox(width: 20.0),
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
                      const SizedBox(height: 40.0),
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
                                          context,
                                        );
                                      } else if (d.doctor?.password == null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    const PasswordSettingPage(),
                                          ),
                                        );
                                      } else if (d.doctor?.password ==
                                          passwordController.text) {
                                        await EasyLoading.show(
                                          status: "Loading...",
                                        );
                                        if (context.mounted) {
                                          await context
                                              .read<PxSupplies>()
                                              .fetchAllDoctorSupplies()
                                              .whenComplete(() async {
                                                //todo: notify reception
                                                //TODO: find a better configuration
                                                if (context.mounted) {
                                                  await context
                                                      .read<PxSocketProvider>()
                                                      .initSocketConnection(
                                                        context,
                                                      );
                                                }

                                                await EasyLoading.dismiss();
                                              });
                                        }
                                        if (context.mounted) {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            '/controlpanel',
                                          );
                                        }

                                        // print('successful login');
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
                      const SizedBox(height: 40.0),
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
                                          context,
                                        );
                                      } else if (d.doctor != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => PasswordChangePage(
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
                      const SizedBox(height: 40),
                      // SizedBox(
                      //   width: 400,
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: ElevatedButton.icon(
                      //           icon: const Icon(Icons.network_check),
                      //           label: const Text('Network Settings'),
                      //           onPressed: () {
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) =>
                      //                     const NetworkSettingsPage(),
                      //               ),
                      //             );
                      //           },
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
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
