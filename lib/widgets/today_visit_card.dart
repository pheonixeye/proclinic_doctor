import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:proclinic_doctor/Patient_Profile_Page/patient_profile_page_main.dart';
import 'package:proclinic_doctor/functions/format_time.dart';
import 'package:proclinic_doctor/providers/app_organizer_provider.dart';
import 'package:proclinic_doctor/providers/one_patient_visits.dart';
import 'package:proclinic_doctor/providers/scanned_documents.dart';
import 'package:proclinic_doctor/providers/selected_doctor.dart';
import 'package:proclinic_doctor/providers/socket_provider.dart';
import 'package:proclinic_doctor/providers/visit_data_provider.dart';
import 'package:proclinic_doctor/providers/visits_provider.dart';
import 'package:proclinic_doctor/widgets/central_loading.dart';
import 'package:proclinic_doctor/widgets/date_time_picker.dart';
import 'package:proclinic_doctor/widgets/qr_dialog.dart';
import 'package:proclinic_doctor/widgets/show_visit_form_data_dialog.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class _typeOfVisit extends Equatable {
  final String e;
  final String a;

  const _typeOfVisit({required this.e, required this.a});

  static const List<_typeOfVisit> list = [
    _typeOfVisit(e: "Consultation", a: "كشف"),
    _typeOfVisit(e: "Follow Up", a: "استشارة"),
    _typeOfVisit(e: "Procedure", a: 'اجراء طبي'),
  ];

  // factory _typeOfVisit.procedure() {
  //   return const _typeOfVisit(e: "Procedure", a: 'اجراء طبي');
  // }
  // factory _typeOfVisit.consultation() {
  //   return const _typeOfVisit(e: "Follow Up", a: "كشف");
  // }
  // factory _typeOfVisit.followUp() {
  //   return const _typeOfVisit(e: "Consultation", a: "استشارة");
  // }

  // factory _typeOfVisit.fromEnglishString(String value) {
  //   return switch (value) {
  //     "Consultation" => _typeOfVisit.consultation(),
  //     "Follow Up" => _typeOfVisit.followUp(),
  //     "Procedure" => _typeOfVisit.procedure(),
  //     _ => throw UnimplementedError(),
  //   };
  // }
  @override
  List<Object> get props => [e, a];
}

class TodayVisitCard extends StatefulWidget {
  const TodayVisitCard({super.key, required this.visit});
  final Visit visit;

  @override
  State<TodayVisitCard> createState() => _TodayVisitCardState();
}

class _TodayVisitCardState extends State<TodayVisitCard> {
  _typeOfVisit? _state;

  void _notifyReception() {
    if (context.mounted) {
      final msg = SocketNotificationMessage.visitUpdatedDoctor(
        widget.visit.docid!,
        Tr(e: widget.visit.docNameEN, a: widget.visit.docNameAR),
        widget.visit.id.oid,
      );
      context.read<PxSocketProvider>().sendSocketMessage(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card.outlined(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            leading: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              heroTag: widget.visit.id,
              onPressed: () async {
                await EasyLoading.show(status: "Loading...");
                if (context.mounted) {
                  context.read<PxVisitData>().selectVisit(widget.visit);
                  await context.read<PxVisitData>().fetchVisitData();
                }
                if (context.mounted) {
                  await context.read<PxScannedDocuments>().fetchVisitData(
                    widget.visit.id,
                  );
                }
                if (context.mounted) {
                  await context
                      .read<PxOnePatientVisits>()
                      .fetchOnePatientVisits(visit: widget.visit);
                }
                await EasyLoading.dismiss();
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const PatientProfilePage(fromnew: true),
                    ),
                  );
                }
              },
              child: const Icon(Icons.info),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton.small(
                      heroTag: widget.visit.id,
                      onPressed: null,
                      child: Text('${widget.visit.entryNumber}'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(width: 30, child: Icon(Icons.person)),
                  ),
                  Text('Name :\n${widget.visit.ptName}'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(width: 30, child: Icon(Icons.phone)),
                  ),
                  Text('Phone :\n${widget.visit.phone}'),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.support_agent),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final d = DateTime.parse(widget.visit.dob);
                      final today = DateTime.now();
                      final age = today.year - d.year;
                      return Text('Age :\n$age Years');
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 30,
                      child: Icon(Icons.report_problem),
                    ),
                  ),
                  Text('Visit Type :\n${widget.visit.visitType}'),
                  //todo: ADD QR BTN
                  const SizedBox(width: 30),
                  IconButton.outlined(
                    tooltip: "Visit QR Code",
                    icon: const Icon(Icons.qr_code_2),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder:
                            (context) => QrDialog(
                              code: QrCode.fromData(
                                data: widget.visit.id.oid,
                                errorCorrectLevel: QrErrorCorrectLevel.H,
                              ),
                            ),
                      );
                    },
                  ),
                  const SizedBox(width: 30),
                  IconButton.outlined(
                    tooltip: "View Attached Form",
                    onPressed:
                        widget.visit.formId == null
                            ? null
                            : () async {
                              await showGeneralDialog(
                                context: context,
                                pageBuilder: (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                ) {
                                  return Align(
                                    alignment: Alignment.bottomLeft,
                                    child: VisitFormDataDialog(
                                      visit: widget.visit,
                                    ),
                                  );
                                },
                              );
                            },
                    icon: const Icon(Icons.insert_drive_file_outlined),
                  ),
                ],
              ),
            ),
            children: [
              //modify visit type
              const Divider(),
              Row(
                children: [
                  const SizedBox(width: 50),
                  const CircleAvatar(),
                  const SizedBox(width: 50),
                  const Text("Visit Type"),
                  const Spacer(),
                  Expanded(
                    child: Card(
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<_typeOfVisit>(
                          isExpanded: true,
                          items:
                              _typeOfVisit.list.map((e) {
                                return DropdownMenuItem<_typeOfVisit>(
                                  alignment: Alignment.center,
                                  value: e,
                                  child: Text(e.e),
                                );
                              }).toList(),
                          hint: const Text(
                            "Select Visit Type...",
                            textAlign: TextAlign.center,
                          ),
                          value: _state,
                          alignment: Alignment.center,
                          onChanged: (value) async {
                            await EasyLoading.show(status: "Loading...");
                            if (context.mounted) {
                              if (value != null) {
                                await context
                                    .read<PxVisits>()
                                    .updateVisitDetails(
                                      widget.visit.id,
                                      SxVisit.VISITTYPE,
                                      value.e,
                                    );
                                //todo: notify reception
                                _notifyReception();
                              }
                            }
                            setState(() {
                              _state = value;
                            });
                            await EasyLoading.dismiss();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const SizedBox(width: 50),
                  const CircleAvatar(),
                  const SizedBox(width: 50),
                  const Text("Procedures"),
                  Expanded(
                    child: Consumer<PxSelectedDoctor>(
                      builder: (context, d, _) {
                        while (d.doctor == null) {
                          return const CentralLoading();
                        }
                        return Card(
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              runAlignment: WrapAlignment.start,
                              runSpacing: 8,
                              spacing: 8,
                              children: [
                                ...d.doctor!.procedures.map((e) {
                                  return FilterChip(
                                    label: Text(e.nameEn),
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    selected: widget.visit.procedures.contains(
                                      e,
                                    ),
                                    onSelected: (value) async {
                                      if (widget.visit.procedures.contains(e)) {
                                        return;
                                      } else {
                                        await EasyLoading.show(
                                          status: "Loading...",
                                        );
                                        if (context.mounted) {
                                          await context
                                              .read<PxVisits>()
                                              .updateVisitDetails(
                                                widget.visit.id,
                                                SxVisit.PROCEDURES,
                                                [...widget.visit.procedures, e]
                                                    .map((e) => e.toJson())
                                                    .toList(),
                                              );
                                          //todo: notify reception
                                          _notifyReception();
                                        }
                                        await EasyLoading.dismiss();
                                      }
                                    },
                                    onDeleted: () async {
                                      await EasyLoading.show(
                                        status: "Loading...",
                                      );
                                      if (context.mounted) {
                                        final original = [
                                          ...widget.visit.procedures,
                                        ];
                                        original.removeWhere(
                                          (x) => x.id == e.id,
                                        );
                                        final update =
                                            original
                                                .map((e) => e.toJson())
                                                .toList();
                                        await context
                                            .read<PxVisits>()
                                            .updateVisitDetails(
                                              widget.visit.id,
                                              SxVisit.PROCEDURES,
                                              update,
                                            );
                                        //todo: notify reception
                                        _notifyReception();
                                      }
                                      await EasyLoading.dismiss();
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const SizedBox(width: 50),
                  const CircleAvatar(),
                  const SizedBox(width: 50),
                  const Text("Set Follow Up Date"),
                  const Spacer(),
                  PickedDateText(visit: widget.visit),
                  const Spacer(),
                  FloatingActionButton(
                    heroTag: "${widget.visit.id}+followup",
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder:
                            (context) =>
                                DateAndTimePickerDialog(visit: widget.visit),
                      );
                      setState(() {});
                    },
                    child: const Icon(Icons.calendar_month),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class PickedDateText extends StatelessWidget {
  const PickedDateText({super.key, required this.visit});
  final Visit visit;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OrgAppointement?>(
      future: PxAppOrganizer.fetctAppointmentById(visit.id),
      builder: (context, snapshot) {
        while (!snapshot.hasData || snapshot.data == null) {
          return const Text("Follow Up Appointment Not Set.");
        }
        return Text(
          formatDateForVisitCard(snapshot.data!.dateTime),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
