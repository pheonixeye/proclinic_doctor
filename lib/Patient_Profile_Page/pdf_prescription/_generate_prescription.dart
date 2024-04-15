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
  final Uint8List fontData = File('assets\\fonts\\cairo.ttf').readAsBytesSync();
  final ttf = pw.Font.ttf(fontData.buffer.asByteData());
  final _style = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1.5,
    fontSize: 10,
  );
  final _titleStyle = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1.5,
    fontSize: 18,
  );
  final _subtitleStyle = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1.5,
    fontSize: 14,
  );
  final _RxStyle = pw.TextStyle(
    color: PdfColor.fromInt(Colors.black.value),
    font: ttf,
    letterSpacing: 1.5,
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
            pw.Expanded(
              flex: 2,
              child: pw.Row(
                children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Builder(
                            builder: (context) {
                              final d_ = DateTime.parse(visit.visitDate);
                              return pw.Text(
                                '${isEnglish ? "Date : " : "التاريخ : "} ${d_.day}-${d_.month}-${d_.year}',
                                style: _style,
                              );
                            },
                          ),
                          pw.Text(
                            '${isEnglish ? "Name : " : "الاسم : "} ${visit.ptName}',
                            style: _style,
                            textDirection: pw.TextDirection.rtl,
                          ),
                          pw.Builder(
                            builder: (context) {
                              final d = DateTime.parse(visit.dob);
                              final t = DateTime.now();
                              final age = t.year - d.year;
                              return pw.Text(
                                '${isEnglish ? "Age : " : "السن : "} $age ${isEnglish ? "Years" : "سنة"}',
                                style: _style,
                              );
                            },
                          ),
                          pw.Text(
                            '${isEnglish ? "Visit : " : "الزيارة : "} ${visitTypeTranslated(visit.visitType, isEnglish)}',
                            style: _style,
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
                        children: [
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(
                                isEnglish ? "Dr. " : 'دكتور',
                                style: _style,
                                textAlign: pw.TextAlign.center,
                              ),
                              pw.SizedBox(width: 10),
                              pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    vertical: 4.0),
                                child: pw.Text(
                                  isEnglish
                                      ? doctor.docnameEN
                                      : doctor.docnameAR,
                                  textAlign: pw.TextAlign.center,
                                  style: _titleStyle,
                                ),
                              ),
                            ],
                          ),
                          ...doctor.titles.map((e) {
                            return pw.Text(
                              isEnglish ? e.titleEn : e.titleAr,
                              textAlign: pw.TextAlign.center,
                              style: _style,
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Divider(
              height: 2,
              thickness: 1,
              color: PdfColor.fromInt(Colors.black.value),
            ),
            pw.Expanded(
              flex: 8,
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
                                style: _RxStyle,
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
                                style: _titleStyle,
                              ),
                              pw.Text(
                                e.dose.formatArabic(),
                                style: _subtitleStyle,
                                textDirection: pw.TextDirection.rtl,
                              ),
                              pw.Text(
                                "- - -",
                                style: _style,
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
                                style: _RxStyle,
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
                            style: isEnglish ? _titleStyle : _subtitleStyle,
                          ),
                          pw.SizedBox(width: 30),
                          pw.Text(
                            isEnglish ? e.value : e.key,
                            style: isEnglish ? _subtitleStyle : _titleStyle,
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
                    style: _subtitleStyle,
                    textAlign: pw.TextAlign.center,
                  ),
                  pw.SizedBox(height: 10),
                  ...data.labs.map((e) {
                    return pw.Text(
                      "** $e",
                      style: _style,
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
                    style: _subtitleStyle,
                  ),
                  pw.SizedBox(height: 10),
                  ...data.rads.map((e) {
                    return pw.Text(
                      "** $e",
                      style: _style,
                    );
                  }).toList(),
                  pw.SizedBox(height: 10),
                  pw.Divider(
                    height: 2,
                    thickness: 1,
                    color: PdfColor.fromInt(Colors.black.value),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Spacer(),
                  pw.Divider(
                    height: 2,
                    thickness: 1,
                    color: PdfColor.fromInt(Colors.black.value),
                  ),
                  ...doctor.clinicDetails.map((e) {
                    return pw.Text(
                      isEnglish ? e.detailEn : e.detailAr,
                      style: _style,
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
