import 'package:pretty_qr_code/pretty_qr_code.dart';

// ignore: constant_identifier_names
const String UUID = '4C4C4544-0039-4610-804A-B9C04F445331';

//TODO: haytham badee3 clinic
// const String UUID = "6DC5F280-B5B7-11E5-9D87-5065F33EC3C6";

final qrCodeUUID = QrCode.fromData(
  data: UUID,
  errorCorrectLevel: QrErrorCorrectLevel.H,
);
