import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proclinic_doctor_windows/models/visitModel.dart';
import 'package:proclinic_doctor_windows/models/visit_data/visit_data.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class SheetPrescription extends StatefulWidget {
  const SheetPrescription({
    super.key,
    required this.visit,
    required this.data,
  });
  final Visit visit;
  final VisitData data;

  @override
  State<SheetPrescription> createState() => _SheetPrescriptionState();
}

class _SheetPrescriptionState extends State<SheetPrescription> {
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
                // await runprintimg();
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
            child: Consumer<PxSelectedDoctor>(
              builder: (context, d, _) {
                final d_ = DateTime.parse(widget.visit.visitDate);
                return Column(
                  children: [
                    //patient data, doctor titles ==>> (A)
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                spacing: 10,
                                direction: Axis.vertical,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: [
                                  Text(
                                      'Date: ${d_.day}-${d_.month}-${d_.year}'),
                                  Text('Name: ${widget.visit.ptName}'),
                                  Builder(
                                    builder: (context) {
                                      final d =
                                          DateTime.parse(widget.visit.dob);
                                      final t = DateTime.now();
                                      final age = t.year - d.year;
                                      return Text('Age: $age Years');
                                    },
                                  ),
                                  Text('Type: ${widget.visit.visitType}'),
                                ],
                              ),
                            ),
                          ),
                          //doctor titles
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ListView(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0),
                                        child: Text(
                                          d.doctor!.docnameAR,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'دكتور',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  ...d.doctor!.titlesAR.map((e) {
                                    return Text(e, textAlign: TextAlign.center);
                                  }).toList(),
                                ],
                              ),
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
                      child: CustomScrollView(
                        slivers: [
                          const SliverToBoxAdapter(
                            child: ListTile(
                              leading: CircleAvatar(),
                              title: Text('Sheet'),
                              subtitle: Divider(),
                            ),
                          ),
                          SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3,
                            ),
                            delegate: SliverChildListDelegate(
                              [
                                ...widget.data.data.entries.map((e) {
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        const Text(
                                          '℞',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(e.key),
                                      ],
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(e.value),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: ListTile(
                              leading: CircleAvatar(),
                              title: Text('Labs'),
                              subtitle: Divider(),
                            ),
                          ),
                          SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 5,
                            ),
                            delegate: SliverChildListDelegate(
                              [
                                ...widget.data.labs.map((e) {
                                  return ListTile(
                                    leading: const Text(
                                      '℞',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    title: Text(e),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: ListTile(
                              leading: CircleAvatar(),
                              title: Text('Rads'),
                              subtitle: Divider(),
                            ),
                          ),
                          SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 5,
                            ),
                            delegate: SliverChildListDelegate(
                              [
                                ...widget.data.rads.map((e) {
                                  return ListTile(
                                    leading: const Text(
                                      '℞',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    title: Text(e),
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 30,
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
                      child: Builder(
                        builder: (context) {
                          return ListView.builder(
                            itemCount: d.doctor!.clinicDetails.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Text(d.doctor!.clinicDetails[index]),
                              );
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
