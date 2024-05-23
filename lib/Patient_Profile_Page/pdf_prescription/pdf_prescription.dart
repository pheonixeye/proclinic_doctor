import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/pdf_prescription/_gen_pres_printed.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/pdf_prescription/_gen_pres_scratch.dart';
import 'package:proclinic_doctor_windows/providers/prescription_settings_provider.dart';
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
  //TODO: SPLIT INTO PAGES ACCORDING TO DRUGS LENGTH OR DECREASE FONT SIZE
  //TODO: ADD MEDICAL REPORT
  //TODO: ALLOW SHEET WITH DRUGS
  PdfPageFormat _format = PdfPageFormat.a5;
  bool _isEnglish = false;
  bool _hasSheet = false;
  bool _showImage = true;
  bool _showLabs = true;
  bool _showRads = true;

  static const Map<String, PdfPageFormat> _pageFormats = {
    "a5": PdfPageFormat.a5,
  };

  //todo: make pdf reciept
  Future<Uint8List> buildPdfFromScratch(PdfPageFormat pageFormat) {
    return generatePrescriptionFromScratch(
      pageFormat: pageFormat,
      context: context,
      doctor: context.read<PxSelectedDoctor>().doctor!,
      visit: widget.visit,
      data: widget.data,
      isEnglish: _isEnglish,
      hasSheet: _hasSheet,
    );
  }

  Future<Uint8List> buildPdfOnPrinted(
    PdfPageFormat pageFormat,
    PrescriptionSettings settings,
  ) {
    return generatePrescritionOnAlreadyPrintedPrescription(
      pageFormat: pageFormat,
      context: context,
      doctor: context.read<PxSelectedDoctor>().doctor!,
      visit: widget.visit,
      data: widget.data,
      settings: settings,
      showImage: _showImage,
      showSheet: _hasSheet,
      showLabs: _showLabs,
      showRads: _showRads,
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
              tooltip: 'Toogle Sheet / Drugs',
              heroTag: 'sheet-drugs',
              onPressed: () {
                setState(() {
                  _hasSheet = !_hasSheet;
                });
              },
              child: Icon(
                  _hasSheet ? Icons.medication : Icons.medical_information),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FloatingActionButton(
              tooltip: 'Toogle Labs',
              heroTag: 'show-hide-labs',
              onPressed: () {
                setState(() {
                  _showLabs = !_showLabs;
                });
              },
              child: Icon(_showLabs ? Icons.label_off : Icons.label),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FloatingActionButton(
              tooltip: 'Toogle Rads',
              heroTag: 'show-hide-rads',
              onPressed: () {
                setState(() {
                  _showRads = !_showRads;
                });
              },
              child: Icon(_showRads ? Icons.raw_off_rounded : Icons.raw_on),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: FloatingActionButton(
              tooltip: 'Toogle Presc. Image',
              heroTag: 'show-hide-img',
              onPressed: () {
                setState(() {
                  _showImage = !_showImage;
                });
              },
              child: Icon(_showImage ? Icons.hide_image : Icons.image),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PxPrescriptionSettings>(
          builder: (context, p, _) {
            return Card.outlined(
              elevation: 6,
              child: PdfPreview(
                pageFormats: _pageFormats,
                maxPageWidth: 600,
                build: (_) {
                  return (p.settings != null && p.settings!.usePrinted)
                      ? buildPdfOnPrinted(_format, p.settings!)
                      : buildPdfFromScratch(_format);
                },
                // actions: actions,
                onPrinted: _showPrintedToast,
                onPageFormatChanged: (value) {
                  setState(() {
                    _format = value;
                  });
                },
                onShared: _showSharedToast,
                canChangePageFormat: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
