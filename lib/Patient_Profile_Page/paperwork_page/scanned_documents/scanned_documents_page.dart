import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:proclinic_doctor_windows/providers/scanned_documents.dart';
import 'package:provider/provider.dart';
import 'package:open_filex/open_filex.dart';

class ScannedDocumentsPage extends StatefulWidget {
  const ScannedDocumentsPage({super.key, required this.data});
  final MapEntry<String, String> data;

  @override
  State<ScannedDocumentsPage> createState() => _ScannedDocumentsPageState();
}

class _ScannedDocumentsPageState extends State<ScannedDocumentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scanned ${widget.data.key}',
          textScaler: const TextScaler.linear(1.4),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6,
          child: Consumer<PxScannedDocuments>(
            builder: (context, d, _) {
              while (d.docs.isEmpty) {
                return Center(
                  child: Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("No '${widget.data.key}' Found."),
                    ),
                  ),
                );
              }
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: d.docs.length,
                    itemBuilder: (context, index) {
                      final controller = PdfViewerController();

                      return Stack(
                        children: [
                          Card.filled(
                            elevation: 20,
                            child: PdfViewer(
                              PdfDocumentRefFile(d.docs[index].path),
                              controller: controller,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: FloatingActionButton(
                                heroTag: index,
                                onPressed: () async {
                                  //todo: open file
                                  await OpenFilex.open(d.docs[index].path);
                                },
                                child: const Icon(Icons.print),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
