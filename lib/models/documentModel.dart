// ignore_for_file: constant_identifier_names, file_names

class Document {
  final String scanTime;
  final String visitDate;
  final int docid;
  final String? sheets;
  final String? labs;
  final String? rads;
  final String? prescriptions;
  final String? comments;

  Document({
    required this.scanTime,
    required this.visitDate,
    required this.docid,
    this.sheets,
    this.labs,
    this.rads,
    this.prescriptions,
    this.comments,
  });

  factory Document.fromJson(dynamic json) {
    return Document(
      scanTime: json[SxDocument.SCANTIME],
      visitDate: json[SxDocument.VISITDATE],
      docid: json[SxDocument.DOCID],
      sheets: json[SxDocument.SHEETS],
      labs: json[SxDocument.LABS],
      rads: json[SxDocument.RADS],
      prescriptions: json[SxDocument.PRESCRIPTIONS],
      comments: json[SxDocument.COMMENTS],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      SxDocument.SCANTIME: scanTime,
      SxDocument.VISITDATE: visitDate,
      SxDocument.DOCID: docid,
      SxDocument.SHEETS: sheets,
      SxDocument.LABS: labs,
      SxDocument.RADS: rads,
      SxDocument.PRESCRIPTIONS: prescriptions,
      SxDocument.COMMENTS: comments,
    };
  }

  static List<Document> docsList(List<dynamic> list) {
    List<Document> l = list.map((json) {
      return Document(
        scanTime: json[SxDocument.SCANTIME],
        visitDate: json[SxDocument.VISITDATE],
        docid: json[SxDocument.DOCID],
        sheets: json[SxDocument.SHEETS],
        labs: json[SxDocument.LABS],
        rads: json[SxDocument.RADS],
        prescriptions: json[SxDocument.PRESCRIPTIONS],
        comments: json[SxDocument.COMMENTS],
      );
    }).toList();
    return l;
  }
}

class SxDocument {
  static const String SCANTIME = 'scantime';
  static const String VISITDATE = 'visitdate';
  static const String DOCID = 'docid';
  static const String SHEETS = 'sheets';
  static const String LABS = 'labs';
  static const String RADS = 'rads';
  static const String PRESCRIPTIONS = 'prescriptions';
  static const String COMMENTS = 'comments';
}
