// ignore_for_file: constant_identifier_names, file_names

class Doctor {
  final int id;
  final String docnameEN;
  final String docnameAR;
  final String clinicEN;
  final String clinicAR;
  final String phonePER;
  final String phoneASS;
  final String? password;
  final String? avatar;
  final bool grid;
  final List<String> proceduersAR;
  final List<String> proceduersEN;
  final List<String> titlesAR;
  final List<String> titlesEN;
  final List<String> affiliatesAR;
  final List<String> affiliatesEN;
  final List<String> fields;
  final List<String> labs;
  final List<String> rads;
  final List<String> drugs;
  final bool published;
  final List<String> clinicDetails;

  const Doctor({
    required this.id,
    required this.docnameEN,
    required this.docnameAR,
    required this.clinicEN,
    required this.clinicAR,
    required this.phonePER,
    required this.phoneASS,
    required this.password,
    required this.avatar,
    required this.grid,
    required this.proceduersAR,
    required this.proceduersEN,
    required this.titlesAR,
    required this.titlesEN,
    required this.affiliatesAR,
    required this.affiliatesEN,
    required this.fields,
    required this.published,
    required this.labs,
    required this.rads,
    required this.drugs,
    required this.clinicDetails,
  });

  factory Doctor.fromJson(dynamic json) {
    return Doctor(
      id: json[SxDoctor.ID],
      docnameEN: json[SxDoctor.DOCNAME_E],
      docnameAR: json[SxDoctor.DOCNAME_A],
      clinicEN: json[SxDoctor.CLINIC_E],
      clinicAR: json[SxDoctor.CLINIC_A],
      phonePER: json[SxDoctor.PHONEPERSONAL],
      phoneASS: json[SxDoctor.PHONEASSISTANT],
      password: json[SxDoctor.PASSWORD],
      avatar: json[SxDoctor.AVATAR],
      grid: json[SxDoctor.GRID],
      proceduersAR: _stringifyList(json[SxDoctor.PROCEDURES_A]),
      proceduersEN: _stringifyList(json[SxDoctor.PROCEDURES_E]),
      titlesAR: _stringifyList(json[SxDoctor.TITLES_A]),
      titlesEN: _stringifyList(json[SxDoctor.TITLES_E]),
      affiliatesAR: _stringifyList(json[SxDoctor.AFFILIATES_A]),
      affiliatesEN: _stringifyList(json[SxDoctor.AFFILIATES_E]),
      fields: _stringifyList(json[SxDoctor.FIELDS]),
      published: json[SxDoctor.PUBLISHED],
      labs: _stringifyList(json[SxDoctor.LABS]),
      rads: _stringifyList(json[SxDoctor.RADS]),
      drugs: _stringifyList(json[SxDoctor.DRUGS]),
      clinicDetails: _stringifyList(json[SxDoctor.CLINICDETAILS]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      SxDoctor.ID: id,
      SxDoctor.DOCNAME_E: docnameEN,
      SxDoctor.DOCNAME_A: docnameAR,
      SxDoctor.CLINIC_E: clinicEN,
      SxDoctor.CLINIC_A: clinicAR,
      SxDoctor.PHONEPERSONAL: phonePER,
      SxDoctor.PHONEASSISTANT: phoneASS,
      SxDoctor.PASSWORD: password,
      SxDoctor.AVATAR: avatar,
      SxDoctor.PROCEDURES_E: proceduersEN,
      SxDoctor.TITLES_E: titlesEN,
      SxDoctor.AFFILIATES_E: affiliatesEN,
      SxDoctor.AFFILIATES_A: affiliatesAR,
      SxDoctor.TITLES_A: titlesAR,
      SxDoctor.PROCEDURES_A: proceduersAR,
      SxDoctor.FIELDS: fields,
      SxDoctor.GRID: grid,
      SxDoctor.PUBLISHED: published,
      SxDoctor.LABS: labs,
      SxDoctor.RADS: rads,
      SxDoctor.DRUGS: drugs,
      SxDoctor.CLINICDETAILS: clinicDetails,
    };
  }

  static List<Doctor> doctorList(List<dynamic> dynlist) {
    List<Doctor> dl = dynlist.map((json) {
      return Doctor.fromJson(json);
    }).toList();
    return dl;
  }

  static List<String> _stringifyList(List<dynamic> ld) {
    return ld.map((dynamic e) => e.toString()).toList();
  }
}

class SxDoctor {
  static const String ID = '_id';
  static const String DOCNAME_E = 'docname';
  static const String DOCNAME_A = 'docname_a';
  static const String CLINIC_E = 'clinic';
  static const String CLINIC_A = 'clinic_a';
  static const String PHONEPERSONAL = 'phone_per';
  static const String PHONEASSISTANT = 'phone_ass';
  static const String PASSWORD = 'password';
  static const String AVATAR = 'avatar';
  static const String PROCEDURES_E = 'procedures';
  static const String TITLES_E = 'titles';
  static const String AFFILIATES_E = 'affiliates';
  static const String AFFILIATES_A = 'affiliates_a';
  static const String TITLES_A = 'titles_a';
  static const String PROCEDURES_A = 'procedures_a';
  static const String FIELDS = 'fields';
  static const String GRID = 'grid';
  static const String PUBLISHED = 'published';
  static const String LABS = 'labs';
  static const String RADS = 'rads';
  static const String DRUGS = 'drugs';
  static const String CLINICDETAILS = 'clinicdetails';
}
