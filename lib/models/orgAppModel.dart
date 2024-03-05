// ignore_for_file: constant_identifier_names, file_names

class OrgAppointement {
  final String ptname;
  final String phone;
  final String docname;
  final String clinic;
  final String dateTime;
  final int docid;

  const OrgAppointement({
    required this.ptname,
    required this.phone,
    required this.docname,
    required this.clinic,
    required this.dateTime,
    required this.docid,
  });
  factory OrgAppointement.fromJson(dynamic json) {
    return OrgAppointement(
      ptname: json[SxOrgApp.PTNAME],
      phone: json[SxOrgApp.PHONE],
      docname: json[SxOrgApp.DOCNAME],
      clinic: json[SxOrgApp.CLINIC],
      dateTime: json[SxOrgApp.DATETIME],
      docid: json[SxOrgApp.DOCID],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      SxOrgApp.PTNAME: ptname,
      SxOrgApp.PHONE: phone,
      SxOrgApp.DOCNAME: docname,
      SxOrgApp.CLINIC: clinic,
      SxOrgApp.DATETIME: dateTime,
      SxOrgApp.DOCID: docid,
    };
  }

  static List<OrgAppointement> makeList(List<dynamic> list) {
    List<OrgAppointement> li = list.map((json) {
      return OrgAppointement(
        ptname: json[SxOrgApp.PTNAME],
        phone: json[SxOrgApp.PHONE],
        docname: json[SxOrgApp.DOCNAME],
        clinic: json[SxOrgApp.CLINIC],
        dateTime: json[SxOrgApp.DATETIME],
        docid: json[SxOrgApp.DOCID],
      );
    }).toList();
    return li;
  }
}

class SxOrgApp {
  static const String PTNAME = 'ptname';
  static const String PHONE = 'phone';
  static const String DOCNAME = 'docname';
  static const String CLINIC = 'clinic';
  static const String DATETIME = 'datetime';
  static const String DOCID = 'docid';
}
