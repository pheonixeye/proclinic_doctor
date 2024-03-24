import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/paperwork_page/scanned_documents/scanned_documents_page.dart';
import 'package:proclinic_doctor_windows/models/visit_data/visit_data.dart';
import 'package:proclinic_doctor_windows/providers/scanned_documents.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

List<Icon> iconlist = [
  const Icon(
    Icons.contact_page,
    size: 100,
  ),
  const Icon(
    Icons.format_list_numbered,
    size: 100,
  ),
  const Icon(
    Icons.radio,
    size: 100,
  ),
  const Icon(
    Icons.description,
    size: 100,
  ),
  const Icon(
    Icons.comment_bank,
    size: 100,
  ),
];

class PaperWorkPage extends StatefulWidget {
  const PaperWorkPage({Key? key}) : super(key: key);
  @override
  State<PaperWorkPage> createState() => _PaperWorkPageState();
}

class _PaperWorkPageState extends State<PaperWorkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scanned Documents',
          textScaler: TextScaler.linear(1.4),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: VisitData.paperData.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  await EasyLoading.show(status: "Loading...");
                  if (context.mounted) {
                    await context
                        .read<PxScannedDocuments>()
                        .fetchDocumentsOfType(VisitAttribute.fromString(
                            VisitData.paperData.values.toList()[index]))
                        .whenComplete(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScannedDocumentsPage(
                            data: VisitData.paperData.entries.toList()[index],
                          ),
                        ),
                      );
                    });
                  }
                  await EasyLoading.dismiss();
                },
                child: Container(
                  decoration: ThemeConstants.cd,
                  child: GridTile(
                    footer: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        VisitData.paperData.keys.toList()[index],
                        textAlign: TextAlign.center,
                        textScaler: const TextScaler.linear(2),
                      ),
                    ),
                    child: iconlist[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
