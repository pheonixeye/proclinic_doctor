// ignore_for_file: constant_identifier_names, file_names, avoid_print

import 'package:mongo_dart/mongo_dart.dart';

class Visit {
  final ObjectId id;
  final int? docid;
  final String ptName;
  final String docNameEN;
  final String docNameAR;
  final String clinicEN;
  final String clinicAR;
  final String phone;
  final String visitType;
  final String? procedureEN;
  final String? procedureAR;
  final String visitDate;
  final String dob;
  final String cashType;
  final String affiliationEN;
  final String affiliationAR;
  final int amount;
  final int remaining;

  Visit({
    ObjectId? id,
    required this.docid,
    required this.ptName,
    required this.docNameEN,
    required this.docNameAR,
    required this.clinicEN,
    required this.clinicAR,
    required this.phone,
    required this.visitType,
    required this.procedureEN,
    required this.procedureAR,
    required this.visitDate,
    required this.dob,
    required this.cashType,
    required this.affiliationEN,
    required this.affiliationAR,
    required this.amount,
    required this.remaining,
  }) : id = id ?? ObjectId();

  factory Visit.fromJson(dynamic json) {
    return Visit(
      id: json["_id"],
      ptName: json[SxVisit.PTNAME],
      docNameEN: json[SxVisit.DOCNAME_E],
      docNameAR: json[SxVisit.DOCNAME_A],
      clinicEN: json[SxVisit.CLINIC_E],
      clinicAR: json[SxVisit.CLINIC_A],
      phone: json[SxVisit.PHONE],
      visitType: json[SxVisit.VISITTYPE],
      procedureEN: json[SxVisit.PROCEDURE_E],
      procedureAR: json[SxVisit.PROCEDURE_A],
      visitDate: json[SxVisit.VISITDATE],
      dob: json[SxVisit.DOB],
      cashType: json[SxVisit.CASHTYPE],
      affiliationEN: json[SxVisit.AFFILIATION_E],
      affiliationAR: json[SxVisit.AFFILIATION_A],
      amount: json[SxVisit.AMOUNT],
      remaining: json[SxVisit.REMAINING],
      docid: json[SxVisit.DOCID],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      SxVisit.PTNAME: ptName,
      SxVisit.DOCNAME_E: docNameEN,
      SxVisit.DOCNAME_A: docNameAR,
      SxVisit.CLINIC_E: clinicEN,
      SxVisit.CLINIC_A: clinicAR,
      SxVisit.PHONE: phone,
      SxVisit.VISITTYPE: visitType,
      SxVisit.PROCEDURE_E: procedureEN,
      SxVisit.PROCEDURE_A: procedureAR,
      SxVisit.VISITDATE: visitDate,
      SxVisit.DOB: dob,
      SxVisit.CASHTYPE: cashType,
      SxVisit.AFFILIATION_E: affiliationEN,
      SxVisit.AFFILIATION_A: affiliationAR,
      SxVisit.AMOUNT: amount,
      SxVisit.REMAINING: remaining,
      SxVisit.DOCID: docid,
    };
  }

  static List<Visit> visitList(List<dynamic> json) {
    return json.map((e) => Visit.fromJson(e)).toList();
  }

  @override
  String toString() {
    print(toJson().toString());
    return super.toString();
  }
}

class SxVisit {
  static const String DOCID = "docid";
  static const String PTNAME = 'ptname';
  static const String DOCNAME_E = "docname";
  static const String DOCNAME_A = "docname_a";
  static const String CLINIC_E = "clinic";
  static const String CLINIC_A = "clinic_a";
  static const String PHONE = "phone";
  static const String VISITTYPE = "visittype";
  static const String PROCEDURE_E = "procedure";
  static const String PROCEDURE_A = "procedure_a";
  static const String AMOUNT = "amount";
  static const String VISITDATE = "visitdate";
  static const String DOB = "dob";
  static const String REMAINING = "remaining";
  static const String CASHTYPE = "cashtype";
  static const String AFFILIATION_E = "affiliation";
  static const String AFFILIATION_A = "affiliation_a";
}
