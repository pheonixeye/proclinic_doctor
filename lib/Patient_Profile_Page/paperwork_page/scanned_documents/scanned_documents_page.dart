import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:proclinic_doctor_windows/providers/scanned_documents.dart';
import 'package:provider/provider.dart';

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
        child: Consumer<PxScannedDocuments>(
          builder: (context, d, _) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: d.docs.length,
                  itemBuilder: (context, index) {
                    final controller = PdfController(
                        document: PdfDocument.openFile(d.docs[index].path));

                    return Stack(
                      children: [
                        Card.filled(
                          elevation: 20,
                          child: PdfView(
                            controller: controller,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              heroTag: index,
                              onPressed: () {
                                //TODO:
                                Process.run(
                                    "cmd.exe " +
                                        'start "${d.docs[index].path}"',
                                    []);
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
    );
  }
}