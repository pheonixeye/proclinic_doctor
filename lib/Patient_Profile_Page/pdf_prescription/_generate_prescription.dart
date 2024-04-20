import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:proclinic_doctor_windows/functions/visit_type_translate.dart';
import 'package:proclinic_models/proclinic_models.dart';

Future<Uint8List> generatePrescription({
  required PdfPageFormat pageFormat,
  required BuildContext context,
  required Doctor doctor,
  required Visit visit,
  required VisitData data,
  bool isEnglish = false,
  bool hasSheet = false,
}) async {
  //TODO: CHANGE AT BUILD TIME

  // final Uint8List fontData =
  //     File('c:\\ProClinic\\Release\\cairo.ttf').readAsBytesSync();
  final Uint8List fontData = File('assets\\fonts\\font.ttf').readAsBytesSync();
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());
  final style = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1,
    fontSize: 12,
  );
  final titleStyle = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1,
    fontSize: 24,
  );
  final drugStyle = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1,
    fontSize: 18,
  );
  final subtitleStyle = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1,
    fontSize: 14,
  );
  final rxStyle = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1,
    fontSize: 24,
  );

  final doc = pw.Document();
  doc.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        margin: const pw.EdgeInsets.all(24.0),
        textDirection: isEnglish ? pw.TextDirection.ltr : pw.TextDirection.rtl,
        pageFormat: pageFormat,
      ),
      build: (pw.Context pwcontext) {
        return pw.Column(
          children: [
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Builder(
                          builder: (context) {
                            final d_ = DateTime.parse(visit.visitDate);
                            return pw.Text(
                              '${isEnglish ? "Date : " : "التاريخ : "} ${d_.day}-${d_.month}-${d_.year}',
                              style: style,
                            );
                          },
                        ),
                        pw.Text(
                          '${isEnglish ? "Name : " : "الاسم : "} ${visit.ptName}',
                          style: style,
                          textDirection: pw.TextDirection.rtl,
                        ),
                        pw.Builder(
                          builder: (context) {
                            final d = DateTime.parse(visit.dob);
                            final t = DateTime.now();
                            final age = t.year - d.year;
                            return pw.Text(
                              '${isEnglish ? "Age : " : "السن : "} $age ${isEnglish ? "Years" : "سنة"}',
                              style: style,
                            );
                          },
                        ),
                        pw.Text(
                          '${isEnglish ? "Visit : " : "الزيارة : "} ${visitTypeTranslated(visit.visitType, isEnglish)}',
                          style: style,
                        ),
                      ],
                    ),
                  ),
                ),
                //doctor titles
                pw.Expanded(
                  flex: 3,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 8.0),
                    child: pw.Column(
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          children: [
                            pw.Text(
                              isEnglish ? "Dr. " : 'دكتور',
                              style: style,
                              textAlign: pw.TextAlign.center,
                            ),
                            pw.SizedBox(width: 10),
                            pw.Padding(
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 4.0),
                              child: pw.Text(
                                isEnglish ? doctor.docnameEN : doctor.docnameAR,
                                textAlign: pw.TextAlign.center,
                                style: titleStyle,
                              ),
                            ),
                          ],
                        ),
                        ...doctor.titles.map((e) {
                          return pw.Text(
                            isEnglish ? e.titleEn : e.titleAr,
                            textAlign: pw.TextAlign.center,
                            style: style,
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            pw.Divider(
              height: 5,
              thickness: 1,
              color: PdfColor.fromInt(Colors.black.value),
            ),
            pw.Expanded(
              // flex: 8,
              child: pw.Column(
                // crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 10),
                  if (!hasSheet)
                    ...data.drugs.map((e) {
                      return pw.Row(
                        mainAxisAlignment: isEnglish
                            ? pw.MainAxisAlignment.start
                            : pw.MainAxisAlignment.end,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 30),
                          if (isEnglish)
                            pw.Container(
                              width: 60,
                              height: 60,
                              decoration: pw.BoxDecoration(
                                shape: pw.BoxShape.circle,
                                border: pw.Border.all(),
                              ),
                              child: pw.Text(
                                'Rx',
                                style: rxStyle,
                                textAlign: pw.TextAlign.center,
                              ),
                              alignment: pw.Alignment.center,
                            ),
                          pw.SizedBox(width: 30),
                          pw.Column(
                            crossAxisAlignment: isEnglish
                                ? pw.CrossAxisAlignment.start
                                : pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text(
                                e.name,
                                style: drugStyle,
                              ),
                              pw.Text(
                                e.dose.formatArabic(),
                                style: subtitleStyle,
                                textDirection: pw.TextDirection.rtl,
                              ),
                              pw.Text(
                                "- - -",
                                style: style,
                              ),
                            ],
                          ),
                          pw.SizedBox(width: 30),
                          if (!isEnglish)
                            pw.Container(
                              width: 60,
                              height: 60,
                              decoration: pw.BoxDecoration(
                                shape: pw.BoxShape.circle,
                                border: pw.Border.all(),
                              ),
                              child: pw.Text(
                                'Rx',
                                style: rxStyle,
                                textAlign: pw.TextAlign.center,
                              ),
                              alignment: pw.Alignment.center,
                            ),
                          pw.SizedBox(width: 30),
                        ],
                      );
                    }).toList(),
                  if (hasSheet)
                    ...data.data.entries.map((e) {
                      return pw.Row(
                        mainAxisAlignment: isEnglish
                            ? pw.MainAxisAlignment.start
                            : pw.MainAxisAlignment.end,
                        children: [
                          pw.SizedBox(width: 30),
                          pw.Text(
                            isEnglish ? e.key : e.value,
                            style: isEnglish ? titleStyle : subtitleStyle,
                          ),
                          pw.SizedBox(width: 30),
                          pw.Text(
                            isEnglish ? e.value : e.key,
                            style: isEnglish ? subtitleStyle : titleStyle,
                          ),
                          pw.SizedBox(width: 30),
                        ],
                      );
                    }).toList(),
                  pw.SizedBox(height: 10),
                  pw.Divider(
                    height: 2,
                    thickness: 1,
                    color: PdfColor.fromInt(Colors.black.value),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "${isEnglish ? "Laboratory Request" : "التحاليل المطلوبة"}\n--------------------",
                    style: subtitleStyle,
                    textAlign: pw.TextAlign.center,
                  ),
                  ...data.labs.map((e) {
                    return pw.Text(
                      "** $e",
                      style: style,
                    );
                  }).toList(),
                  pw.SizedBox(height: 10),
                  pw.Divider(
                    height: 2,
                    thickness: 1,
                    color: PdfColor.fromInt(Colors.black.value),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "${isEnglish ? "Radiology Request" : "الاشاعات المطلوبة"}\n--------------------",
                    style: subtitleStyle,
                  ),
                  ...data.rads.map((e) {
                    return pw.Text(
                      "** $e",
                      style: style,
                    );
                  }).toList(),
                  pw.SizedBox(height: 10),
                  pw.Divider(
                    height: 2,
                    thickness: 1,
                    color: PdfColor.fromInt(Colors.black.value),
                  ),
                  pw.Spacer(),
                  pw.Divider(
                    height: 2,
                    thickness: 1,
                    color: PdfColor.fromInt(Colors.black.value),
                  ),
                  ...doctor.clinicDetails.map((e) {
                    return pw.Text(
                      isEnglish ? e.detailEn : e.detailAr,
                      style: style,
                      textAlign: pw.TextAlign.center,
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );

  return doc.save();
}
