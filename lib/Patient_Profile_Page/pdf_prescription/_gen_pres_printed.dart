import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:proclinic_doctor_windows/functions/format_time.dart';
import 'package:proclinic_models/proclinic_models.dart';

Future<Uint8List> generatePrescritionOnAlreadyPrintedPrescription({
  required PdfPageFormat pageFormat,
  required BuildContext context,
  required Doctor doctor,
  required Visit visit,
  required VisitData data,
  required PrescriptionSettings settings,
  required bool showImage,
  required bool showSheet,
  required bool showLabs,
  required bool showRads,
}) async {
  //TODO: change at Build Time
  final Uint8List fontData = File('assets\\fonts\\font.ttf').readAsBytesSync();

  final ttf = pw.Font.ttf(fontData.buffer.asByteData());

  final style = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    // letterSpacing: 1,
    fontSize: 10,
  );

  final doc = pw.Document();

  final image = pw.MemoryImage(
    File(settings.path!).readAsBytesSync(),
  );
  doc.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        margin: pw.EdgeInsets.zero,
        pageFormat: pageFormat,
        theme: pw.ThemeData(
          defaultTextStyle: style,
          textAlign: pw.TextAlign.center,
        ),
        textDirection: pw.TextDirection.ltr,
      ),
      build: (context) {
        return pw.Stack(
          fit: pw.StackFit.expand,
          alignment: pw.Alignment.center,
          children: [
            if (showImage) pw.Image(image),
            ...PosDataType.values.map((e) {
              final isDataShown = settings.data[e.toString()]!.isShown;
              final x = settings.data[e.toString()]?.x;
              final y = settings.data[e.toString()]?.y;
              return switch (e) {
                PosDataType.name => pw.Positioned(
                    child: isDataShown
                        ? pw.Text(
                            visit.ptName,
                            textDirection: pw.TextDirection.rtl,
                          )
                        : pw.SizedBox(),
                    left: x,
                    top: y,
                  ),
                PosDataType.date => pw.Positioned(
                    child: isDataShown
                        ? pw.Text(formatDateWithoutTime(visit.visitDate))
                        : pw.SizedBox(),
                    left: x,
                    top: y,
                  ),
                PosDataType.age => pw.Positioned(
                    child: isDataShown
                        ? pw.Builder(
                            builder: (context) {
                              final age = DateTime.now().year -
                                  (DateTime.parse(visit.dob).year);
                              return pw.Text(
                                age.toString(),
                                textAlign: pw.TextAlign.center,
                                style: style,
                              );
                            },
                          )
                        : pw.SizedBox(),
                    left: x,
                    top: y,
                  ),
                PosDataType.visit => pw.Positioned(
                    child:
                        isDataShown ? pw.Text(visit.visitType) : pw.SizedBox(),
                    left: x,
                    top: y,
                  ),
                PosDataType.drugs => pw.Positioned(
                    child: !showSheet
                        ? pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              ...data.drugs.map((e) {
                                return pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.SizedBox(width: 10),
                                    pw.Container(
                                      width: 30,
                                      height: 30,
                                      decoration: pw.BoxDecoration(
                                        shape: pw.BoxShape.circle,
                                        border: pw.Border.all(),
                                      ),
                                      child: pw.Text(
                                        'Rx',
                                        style: style,
                                        textAlign: pw.TextAlign.center,
                                      ),
                                      alignment: pw.Alignment.center,
                                    ),
                                    pw.SizedBox(width: 10),
                                    pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          e.name,
                                          style: style,
                                          textDirection: pw.TextDirection.ltr,
                                        ),
                                        pw.Text(
                                          e.dose.formatArabic(),
                                          style: style,
                                          textDirection: pw.TextDirection.rtl,
                                        ),
                                        pw.Text(
                                          "- - -",
                                          style: style,
                                        ),
                                      ],
                                    ),
                                    pw.SizedBox(width: 10),
                                  ],
                                );
                              }).toList(),
                            ],
                          )
                        : pw.SizedBox(),
                    left: x,
                    top: y,
                  ),
                PosDataType.labs => pw.Positioned(
                    child: showLabs
                        ? pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Labs :",
                                style: style.copyWith(
                                  decoration: pw.TextDecoration.underline,
                                ),
                                textDirection: pw.TextDirection.ltr,
                              ),
                              ...data.labs.map((e) {
                                return pw.Text(
                                  "* $e",
                                  style: style,
                                  textDirection: pw.TextDirection.ltr,
                                );
                              }).toList(),
                            ],
                          )
                        : pw.SizedBox(),
                    left: x,
                    top: y,
                  ),
                PosDataType.rads => pw.Positioned(
                    child: showRads
                        ? pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Rads :",
                                style: style.copyWith(
                                  decoration: pw.TextDecoration.underline,
                                ),
                                textDirection: pw.TextDirection.ltr,
                              ),
                              ...data.rads.map((e) {
                                return pw.Text(
                                  "* $e",
                                  style: style,
                                  textDirection: pw.TextDirection.ltr,
                                );
                              }).toList(),
                            ],
                          )
                        : pw.SizedBox(),
                    left: x,
                    top: y,
                  ),
                PosDataType.sheet => pw.Positioned(
                    child: showSheet
                        ? pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              ...data.data.entries.map((e) {
                                return pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      "* ${e.key}",
                                      style: style.copyWith(
                                        decoration: pw.TextDecoration.underline,
                                      ),
                                      textAlign: pw.TextAlign.start,
                                    ),
                                    pw.SizedBox(
                                      width: 200,
                                      child: pw.Text(
                                        e.value,
                                        textAlign: pw.TextAlign.start,
                                      ),
                                    ),
                                    pw.SizedBox(height: 5),
                                  ],
                                );
                              }).toList(),
                            ],
                          )
                        : pw.SizedBox(),
                    left: x,
                    top: y,
                  ),
                PosDataType.report => pw.Positioned(
                    child: pw.SizedBox(),
                    left: x,
                    top: y,
                  ),
              };
            }).toList(),
          ],
        );
      },
    ),
  );

  return doc.save();
}
