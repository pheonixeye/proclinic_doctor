import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:proclinic_doctor_windows/network_settings/network_class.dart';
import 'package:flutter/material.dart';

class NetworkSettingsPage extends StatefulWidget {
  const NetworkSettingsPage({super.key});

  @override
  _NetworkSettingsPageState createState() => _NetworkSettingsPageState();
}

class _NetworkSettingsPageState extends State<NetworkSettingsPage> {
  TextEditingController ipController = TextEditingController();
  TextEditingController portController = TextEditingController();

  // NetworkHive networkHive = NetworkHive();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double hor_size = MediaQuery.of(context).size.width / 5;
    double ver_size = MediaQuery.of(context).size.height / 5;
    NetworkSettings netset = NetworkSettings();

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: const Text(
          'Network Settings',
          textScaleFactor: 2.0,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            // List data = snapshot.data;
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
                                width: 150.0, child: Text('IP Address')),
                            const SizedBox(
                              width: 20.0,
                            ),
                            SizedBox(
                              width: 350.0,
                              child: TextField(
                                onChanged: (String value) {
                                  setState(() {});
                                },
                                obscuringCharacter: '*',
                                controller: ipController,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter IP Address',
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
                                width: 150.0, child: Text('Port Number')),
                            const SizedBox(
                              width: 20.0,
                            ),
                            SizedBox(
                              width: 350.0,
                              child: TextField(
                                onChanged: (String value) {
                                  setState(() {});
                                },
                                controller: portController,
                                obscuringCharacter: '*',
                                obscureText: false,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Port Number',
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
                              StreamController<int> timercont =
                                  StreamController<int>();
                              int ii = 4;
                              Timer.periodic(const Duration(seconds: 1),
                                  (timer) {
                                setState(() {
                                  timercont.sink.add(ii);
                                  ii--;
                                  if (ii == 0) {
                                    timer.cancel();
                                    timercont.close();
                                  }
                                });
                              });

                              await netset.adddatatonetwork(
                                  ip: ipController.text.toString(),
                                  port: portController.text.toString());

                              final snackbar = SnackBar(
                                  onVisible: () {
                                    setState(() {});
                                  },
                                  duration: const Duration(seconds: 4),
                                  content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Network Settings Updated.',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Icon(
                                          Icons.thumb_up_alt_rounded,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        StreamBuilder<Object>(
                                            initialData: 5,
                                            stream: timercont.stream,
                                            builder: (context, snapshot) {
                                              return Text(
                                                'Exiting in ${snapshot.data} seconds.',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }),
                                      ]));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                              await Future.delayed(const Duration(seconds: 5));

                              // await Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => LoadingScreen()));
                              exit(0);
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
