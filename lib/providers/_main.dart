import 'package:proclinic_doctor_windows/providers/doctorListProvider.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => PxDoctorListProvider()),
  ChangeNotifierProvider(create: (context) => PxSelectedDoctor()),
  ChangeNotifierProvider(create: (context) => PxVisits()),
  ChangeNotifierProvider(create: (context) => PxVisitData()),
];
