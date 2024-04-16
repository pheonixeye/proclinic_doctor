import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/pdf_prescription/_generate_prescription.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class PdfPrescription extends StatefulWidget {
  const PdfPrescription({
    super.key,
    required this.visit,
    required this.data,
  });
  final Visit visit;
  final VisitData data;

  @override
  State<PdfPrescription> createState() => _PdfPrescriptionState();
}

class _PdfPrescriptionState extends State<PdfPrescription> {
  PdfPageFormat _format = PdfPageFormat.a4;
  bool _isEnglish = false;
  bool _hasSheet = false;

  static const Map<String, PdfPageFormat> _pageFormats = {
    "a4": PdfPageFormat.a4,
    "a5": PdfPageFormat.a5,
  };

  //todo: make pdf reciept
  Future<Uint8List> buildPdf(PdfPageFormat pageFormat) {
    return generatePrescription(
      pageFormat: pageFormat,
      context: context,
      doctor: context.read<PxSelectedDoctor>().doctor!,
      visit: widget.visit,
      data: widget.data,
      isEnglish: _isEnglish,
      hasSheet: _hasSheet,
    );
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FloatingActionButton(
              tooltip: 'Close',
              heroTag: 'pop',
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FloatingActionButton(
              tooltip: 'Language',
              heroTag: 'lang',
              onPressed: () {
                setState(() {
                  _isEnglish = !_isEnglish;
                });
              },
              child: const Icon(Icons.language),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FloatingActionButton(
              tooltip: 'Sheet',
              heroTag: 'sheet',
              onPressed: () {
                setState(() {
                  _hasSheet = !_hasSheet;
                });
              },
              child: const Icon(Icons.medical_information),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: PdfPreview(
            pageFormats: _pageFormats,
            maxPageWidth: 600,
            dpi: 72,
            build: (_) {
              return buildPdf(_format);
            },
            // actions: actions,
            onPrinted: _showPrintedToast,
            onPageFormatChanged: (value) {
              setState(() {
                _format = value;
              });
            },
            onShared: _showSharedToast,
          ),
        ),
      ),
    );
  }
}
