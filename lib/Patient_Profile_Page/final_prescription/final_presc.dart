import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

Future runprintimg() async {
  // await Process.runSync('powershell.exe',
  //     ['start-process c:\\users\\kelsier_2\\desktop\\pres.png -verb print'],
  //     runInShell: true);
  //TODO: find a printing package
}

class FinalPrescription extends StatefulWidget {
  const FinalPrescription({super.key});
  @override
  State<FinalPrescription> createState() => _FinalPrescriptionState();
}

class _FinalPrescriptionState extends State<FinalPrescription> {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton(
              heroTag: 'back-btn',
              child: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            FloatingActionButton(
              heroTag: 'print-prescription',
              child: const Icon(Icons.print),
              onPressed: () async {
                await screenshotController
                    .captureAndSave('c:/users/kareemzaher/desktop/pres.png');
                await Future.delayed(const Duration(seconds: 1));
                await runprintimg();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.99,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: ThemeConstants.cd,
            child: Consumer2<PxSelectedDoctor, PxVisitData>(
              builder: (context, d, vd, _) {
                final _d = DateTime.parse(vd.visit!.visitDate);
                return Column(
                  children: [
                    //patient data, doctor titles ==>> (A)
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                      'Date: ${_d.day}-${_d.month}-${_d.year}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text('Name: ${vd.visit!.ptName}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Builder(
                                    builder: (context) {
                                      final _d = DateTime.parse(vd.visit!.dob);
                                      final _t = DateTime.now();
                                      final _age = _t.year - _d.year;
                                      return Text('Age: $_age Years');
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text('Visit: ${vd.visit!.visitType}'),
                                ),
                              ],
                            ),
                          ),
                          //doctor titles
                          Expanded(
                            flex: 1,
                            child: ListView(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'دكتور',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  d.doctor!.docnameAR,
                                  textAlign: TextAlign.center,
                                ),
                                ...d.doctor!.titlesAR.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                      height: 10,
                      thickness: 3,
                    ),
                    //------------------------------//
                    //drugs - labs - rads
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          //drugs
                          Expanded(
                            flex: 5,
                            child: StreamBuilder(
                              stream: null,
                              builder: (context, snapshot) {
                                final data = !snapshot.hasData
                                    ? []
                                    : snapshot.data as List;
                                return ListView.builder(
                                  itemExtent: 45,
                                  itemCount:
                                      !snapshot.hasData ? 0 : data.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: const CircleAvatar(
                                        child: Text(
                                          '℞',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      title: Text(
                                        data[index].toString().toUpperCase(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          //labs and rads
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                //labs
                                Expanded(
                                  flex: 1,
                                  child: StreamBuilder(
                                      stream: null,
                                      builder: (context, snapshot) {
                                        final data = !snapshot.hasData
                                            ? []
                                            : snapshot.data as List;

                                        return GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 6,
                                          ),
                                          itemCount: !snapshot.hasData
                                              ? 0
                                              : data.length,
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Text(
                                                  '• ${data[index].toString().toUpperCase()}'),
                                            );
                                          },
                                        );
                                      }),
                                ),
                                //rads
                                Expanded(
                                  flex: 1,
                                  child: StreamBuilder(
                                    stream: null,
                                    builder: (context, snapshot) {
                                      final data = !snapshot.hasData
                                          ? []
                                          : snapshot.data as List;

                                      return ListView.builder(
                                        itemCount:
                                            !snapshot.hasData ? 0 : data.length,
                                        itemBuilder: (context, index) {
                                          return Center(
                                            child: Text(
                                                '• ${data[index].toString().toUpperCase()}'),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.blueGrey,
                      height: 10,
                      thickness: 3,
                    ),
                    //clinic details
                    Expanded(
                      flex: 1,
                      child: StreamBuilder(
                        stream: null,
                        builder: (context, clinicsnap) {
                          final data = !clinicsnap.hasData
                              ? []
                              : clinicsnap.data as List;

                          return ListView.builder(
                            itemCount: !clinicsnap.hasData ? 0 : data.length,
                            itemBuilder: (context, index) {
                              return Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data[index].toString()),
                              ));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
