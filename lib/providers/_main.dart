import 'package:proclinic_doctor_windows/functions/print_logic.dart';
import 'package:proclinic_doctor_windows/providers/doctorListProvider.dart';
import 'package:proclinic_doctor_windows/providers/font_file_provider.dart';
import 'package:proclinic_doctor_windows/providers/form_loader.dart';
import 'package:proclinic_doctor_windows/providers/notification_provider.dart';
import 'package:proclinic_doctor_windows/providers/one_patient_visits.dart';
import 'package:proclinic_doctor_windows/providers/overlay_provider.dart';
import 'package:proclinic_doctor_windows/providers/prescription_settings_provider.dart';
import 'package:proclinic_doctor_windows/providers/scanned_documents.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/socket_provider.dart';
import 'package:proclinic_doctor_windows/providers/supplies_provider.dart';
import 'package:proclinic_doctor_windows/providers/theme_changer.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:provider/provider.dart'
    show ChangeNotifierProvider, ReadContext;
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxOverlay()),
  ChangeNotifierProvider(create: (context) => ThemeChanger()),
  ChangeNotifierProvider(create: (context) => PxAppNotifications()),
  ChangeNotifierProvider(create: (context) => PxDoctorListProvider()),
  ChangeNotifierProvider(create: (context) => PxSelectedDoctor()),
  ChangeNotifierProvider(
    create: (context) =>
        PxSocketProvider(docid: context.read<PxSelectedDoctor>().doctor!.id)
          ..listenToSocket(context),
  ),
  ChangeNotifierProvider(
    create: (context) =>
        PxVisits(docid: context.read<PxSelectedDoctor>().doctor!.id),
  ),
  ChangeNotifierProvider(create: (context) => PxVisitData()),
  ChangeNotifierProvider(create: (context) => PxOnePatientVisits()),
  ChangeNotifierProvider(create: (context) => PdfPrinter()),
  ChangeNotifierProvider(create: (context) => PxScannedDocuments()),
  ChangeNotifierProvider(create: (context) => FontFileProvider()),
  ChangeNotifierProvider(
    create: (context) => PxPrescriptionSettings(
      docId: context.read<PxSelectedDoctor>().doctor!.id,
    ),
  ),
  ChangeNotifierProvider(
    create: (context) =>
        PxSupplies(docid: context.read<PxSelectedDoctor>().doctor!.id),
  ),
  ChangeNotifierProvider(create: (context) => PxFormLoader()),
];
