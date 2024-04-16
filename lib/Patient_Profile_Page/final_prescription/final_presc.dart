import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/pdf_prescription/pdf_prescription.dart';
import 'package:proclinic_doctor_windows/functions/print_logic.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class FinalPrescription extends StatefulWidget {
  const FinalPrescription({
    super.key,
    required this.visit,
    required this.data,
  });
  final Visit visit;
  final VisitData data;
  @override
  State<FinalPrescription> createState() => _FinalPrescriptionState();
}

class _FinalPrescriptionState extends State<FinalPrescription> {
  //todo: NOT-DRY - find what to print - no need to rewrite page
  //todo: need to refactor this page to accept enum value and fetch the result automatically
  //todo: rebuild in pdf
  bool _showSheet = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PxSelectedDoctor>(
      builder: (context, d, _) {
        final d_ = DateTime.parse(widget.visit.visitDate);
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    tooltip: "Close",
                    heroTag: 'back-btn',
                    child: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    tooltip: "toogle Sheet / Drugs",
                    heroTag: 'swap-sheet-drug',
                    child: const Icon(Icons.medical_information),
                    onPressed: () {
                      setState(() {
                        _showSheet = !_showSheet;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<PdfPrinter>(
                    builder: (context, p, _) {
                      return FloatingActionButton(
                        tooltip: 'Print Prescription',
                        heroTag: 'print-prescription',
                        child: const Icon(Icons.print),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PdfPrescription(
                                visit: widget.visit,
                                data: widget.data,
                              ),
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
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.99,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Card.outlined(
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
                                  ...d.doctor!.titles.map((e) {
                                    return Text(
                                      e.titleAr,
                                      textAlign: TextAlign.center,
                                    );
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
                                ListTile(
                                  leading: const CircleAvatar(),
                                  title: Text(_showSheet ? 'Sheet' : 'Drugs'),
                                  subtitle: const Divider(),
                                ),
                                if (!_showSheet)
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
                                  }).toList()
                                else
                                  ...widget.data.data.entries.map((e) {
                                    return ListTile(
                                      title: Row(
                                        children: [
                                          const Text(
                                            '**',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            e.key,
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        //todo:
                                        child: Text(e.value.toString()),
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
              ),
            ),
          ),
        );
      },
    );
  }
}
