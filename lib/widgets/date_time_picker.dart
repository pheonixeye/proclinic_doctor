import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/functions/format_time.dart';
import 'package:proclinic_doctor_windows/providers/app_organizer_provider.dart';
import 'package:proclinic_doctor_windows/widgets/time_picker.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class DateAndTimePickerDialog extends StatefulWidget {
  const DateAndTimePickerDialog({super.key, required this.visit});
  final Visit visit;

  @override
  State<DateAndTimePickerDialog> createState() =>
      _DateAndTimePickerDialogState();
}

class _DateAndTimePickerDialogState extends State<DateAndTimePickerDialog> {
  DateTime _currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Pick Date For Follow Up.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            child: const Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                    maxWidth: 500,
                  ),
                  child: Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 365),
                        ),
                        currentDate: _currentDate,
                        onDateChanged: (value) {
                          setState(() {
                            _currentDate = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  thickness: 5,
                  width: 3,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 300,
                    maxWidth: 500,
                  ),
                  child: Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TimePicker(
                        time: TimeOfDay.fromDateTime(_currentDate),
                        onTimeChanged: (value) {
                          final min = value.minute;
                          final hour = value.hour;
                          setState(() {
                            _currentDate = DateTime(
                              _currentDate.year,
                              _currentDate.month,
                              _currentDate.day,
                              hour,
                              min,
                            );
                          });
                        },
                        orientation: Orientation.landscape,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            child: const Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Picked Date : ${formatDate(_currentDate.toIso8601String())}"),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            child: const Divider(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChangeNotifierProvider.value(
                  value: PxAppOrganizer(
                    visitId: widget.visit.id,
                  ),
                  builder: (context, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          //todo: SET DATE OF FOLLOWUP in app organizer
                          //todo: fetch date from organizer (orgid = visitid)
                          final a = context.read<PxAppOrganizer>();
                          await EasyLoading.show(status: "Loading...");
                          a.setOrganizerAppointment(widget.visit, _currentDate);
                          await a.createFollowUpDate();
                          await EasyLoading.dismiss();
                          //TODO: notify reception by date
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text("Save"),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
