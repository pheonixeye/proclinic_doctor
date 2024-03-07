import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:screenshot/screenshot.dart';

Future runprintimg() async {
  // await Process.runSync('powershell.exe',
  //     ['start-process c:\\users\\kelsier_2\\desktop\\pres.png -verb print'],
  //     runInShell: true);
  //TODO: find a printing package
}

class FinalPrescription extends StatefulWidget {
  final Map forwardedData;
  const FinalPrescription({super.key, required this.forwardedData});
  @override
  _FinalPrescriptionState createState() => _FinalPrescriptionState();
}

class _FinalPrescriptionState extends State<FinalPrescription> {
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.print),
        onPressed: () async {
          // await print('button pressed');
          await screenshotController
              .captureAndSave('c:/users/kareemzaher/desktop/pres.png');
          // await print('image generated');

          await Future.delayed(const Duration(seconds: 1));
          // await print('duration waited');
          await runprintimg();

          // await print('script ran');
        },
      ),
      body: Center(
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.99,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: ThemeConstants.cd,
            child: Column(
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
                                  'Date: ${widget.forwardedData['day']}-${widget.forwardedData['month']}-${widget.forwardedData['year']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  'Name: ${widget.forwardedData['ptname']}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  'Age: ${widget.forwardedData['age']} Years'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                  'Visit: ${widget.forwardedData['visit']}'),
                            ),
                          ],
                        ),
                      ),
                      //doctor titles
                      Expanded(
                        flex: 1,
                        child: StreamBuilder(
                          stream: null,
                          builder: (context, docsnap) {
                            final data =
                                !docsnap.hasData ? [] : docsnap.data as List;
                            return ListView.builder(
                              itemCount: !docsnap.hasData ? 0 : data.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 4, 7, 4),
                                    child: Text(
                                        data[index].toString().toUpperCase()),
                                  ),
                                );
                              },
                            );
                          },
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
                            final data =
                                !snapshot.hasData ? [] : snapshot.data as List;
                            return ListView.builder(
                              itemExtent: 45,
                              itemCount: !snapshot.hasData ? 0 : data.length,
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
                                      itemCount:
                                          !snapshot.hasData ? 0 : data.length,
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
                      final data =
                          !clinicsnap.hasData ? [] : clinicsnap.data as List;

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
            ),
          ),
        ),
      ),
    );
  }
}
