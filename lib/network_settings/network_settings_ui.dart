import 'dart:async';
import 'dart:io' show exit;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor/network_settings/network_class.dart';
import 'package:flutter/material.dart';
// import 'package:proclinic_doctor/theme/theme.dart';

class NetworkSettingsPage extends StatefulWidget {
  const NetworkSettingsPage({super.key});

  @override
  State<NetworkSettingsPage> createState() => _NetworkSettingsPageState();
}

class _NetworkSettingsPageState extends State<NetworkSettingsPage> {
  TextEditingController ipController = TextEditingController();
  TextEditingController portController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final duration = const Duration(seconds: 5);
  double horSize(context) => MediaQuery.of(context).size.width / 5;
  double verSize(context) => MediaQuery.of(context).size.height / 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Network Settings',
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          child: Card(
            elevation: 6,
            margin: EdgeInsets.fromLTRB(
              horSize(context),
              verSize(context),
              horSize(context),
              verSize(context),
            ),
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
                          child: Text('IP Address'),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            controller: ipController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter IP Address',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Invalid Ip Address.";
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
                          child: Text('Port Number'),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        SizedBox(
                          width: 350.0,
                          child: TextFormField(
                            controller: portController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Port Number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Invalid Port Number.";
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
                          await NetworkSettings.instance.adddatatonetwork(
                              ip: ipController.text.toString(),
                              port: portController.text.toString());

                          await EasyLoading.showSuccess(
                            'Network Settings Updated, Exiting in 5 Seconds.',
                            duration: duration,
                          );
                          await Future.delayed(duration);
                          await EasyLoading.dismiss();

                          exit(0);
                        }
                      },
                    ),
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
