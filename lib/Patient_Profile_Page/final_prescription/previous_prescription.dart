import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/functions/print_logic.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class PreviousPrescription extends StatefulWidget {
  const PreviousPrescription({
    super.key,
    required this.data,
    required this.visit,
  });
  final VisitData data;
  final Visit visit;

  @override
  State<PreviousPrescription> createState() => _PreviousPrescriptionState();
}

class _PreviousPrescriptionState extends State<PreviousPrescription> {
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
            Consumer<PdfPrinter>(
              builder: (context, p, _) {
                return FloatingActionButton(
                  heroTag: 'print-prescription',
                  child: const Icon(Icons.print),
                  onPressed: () async {
                    await EasyLoading.show(status: "Loading...");
                    final image = await screenshotController.captureAndSave(
                      '${p.path}',
                      fileName: "${widget.data.visitid.oid}.png",
                    );
                    if (image != null) {
                      await p.generatePdfFile(image);
                      await EasyLoading.showInfo("Pdf File Generated.");
                      if (context.mounted) {
                        await p.printPdfFile(context).whenComplete(() async {
                          await EasyLoading.showSuccess('Printing Complete.');
                        });
                      }
                    } else {
                      await EasyLoading.showError('Image Generation Failed.');
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Screenshot(
          controller: screenshotController,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.99,
            width: MediaQuery.of(context).size.width * 0.4,
            child: Consumer<PxSelectedDoctor>(
              builder: (context, d, _) {
                final d_ = DateTime.parse(widget.visit.visitDate);
                return Card.outlined(
                  child: Column(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    ...d.doctor!.titles.map((e) {
                                      //TODO: Localization
                                      return Text(e.titleAr,
                                          textAlign: TextAlign.center);
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
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  const ListTile(
                                    leading: CircleAvatar(),
                                    title: Text('Drugs'),
                                    subtitle: Divider(),
                                  ),
                                  ...widget.data.drugs.map((e) {
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
                                          Text(e.name),
                                        ],
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        //todo:
                                        child: Text(e.dose.formatArabic()),
                                      ),
                                    );
                                  }).toList(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const ListTile(
                                    leading: CircleAvatar(),
                                    title: Text('Labs'),
                                    subtitle: Divider(),
                                  ),
                                ],
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
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  const ListTile(
                                    leading: CircleAvatar(),
                                    title: Text('Rads'),
                                    subtitle: Divider(),
                                  ),
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
                                  //TODO: LOCALIZATION
                                  child: Text(
                                      d.doctor!.clinicDetails[index].detailAr),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
