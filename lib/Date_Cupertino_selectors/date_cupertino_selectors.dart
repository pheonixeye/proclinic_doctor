import 'package:flutter/material.dart';
import 'package:proclinic_doctor/providers/visits_provider.dart';
// import 'package:proclinic_doctor/theme/theme.dart';
import 'package:provider/provider.dart';

class YearClinicPicker extends StatefulWidget {
  const YearClinicPicker({super.key, this.forRange = false});
  final bool forRange;

  @override
  YearClinicPickerState createState() => YearClinicPickerState();
}

class YearClinicPickerState extends State<YearClinicPicker> {
  final List<int> _years =
      List.generate(10, (i) => (DateTime.now().year - 5) + i);
  @override
  Widget build(BuildContext context) {
    return Consumer<PxVisits>(
      builder: (context, v, _) {
        return Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<int>(
              hint: const Text('Select Year.'),
              isExpanded: true,
              alignment: Alignment.center,
              items: _years.map((e) {
                return DropdownMenuItem<int>(
                  alignment: Alignment.center,
                  value: e,
                  child: Text('$e'),
                );
              }).toList(),
              value: widget.forRange ? v.secondDate.year : v.date.year,
              onChanged: (val) {
                widget.forRange
                    ? context.read<PxVisits>().setSecondDate(
                          year: val,
                        )
                    : context.read<PxVisits>().setDate(
                          year: val,
                        );
              },
            ),
          ),
        );
      },
    );
  }
}

//monthpicker
List<String> months = [
  '01 - January',
  '02 - February',
  '03 - March',
  '04 - April',
  '05 - May',
  '06 - June',
  '07 - July',
  '08 - August',
  '09 - September',
  '10 - October',
  '11 - November',
  '12 - December'
];

class MonthClinicPicker extends StatefulWidget {
  const MonthClinicPicker({super.key, this.forRange = false});
  final bool forRange;

  @override
  MonthClinicPickerState createState() => MonthClinicPickerState();
}

class MonthClinicPickerState extends State<MonthClinicPicker> {
  static const _months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  @override
  Widget build(BuildContext context) {
    return Consumer<PxVisits>(
      builder: (context, v, _) {
        return Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<int>(
              hint: const Text('Select Month.'),
              isExpanded: true,
              alignment: Alignment.center,
              items: _months.map((e) {
                return DropdownMenuItem<int>(
                  alignment: Alignment.center,
                  value: e,
                  child: Text(months[e - 1]),
                );
              }).toList(),
              value: widget.forRange ? v.secondDate.month : v.date.month,
              onChanged: (val) {
                widget.forRange
                    ? v.setSecondDate(
                        month: val,
                      )
                    : v.setDate(
                        month: val,
                      );
              },
            ),
          ),
        );
      },
    );
  }
}

//daypicker

List<String> days = [
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23',
  '24',
  '25',
  '26',
  '27',
  '28',
  '29',
  '30',
  '31'
];

class DayClinicPicker extends StatefulWidget {
  const DayClinicPicker({super.key, this.forRange = false});
  final bool forRange;
  @override
  State<DayClinicPicker> createState() => _DayClinicPickerState();
}

class _DayClinicPickerState extends State<DayClinicPicker> {
  final _days = List.generate(31, (index) => index + 1);
  @override
  Widget build(BuildContext context) {
    return Consumer<PxVisits>(
      builder: (context, v, _) {
        return Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<int>(
              hint: const Text('Select Day.'),
              isExpanded: true,
              alignment: Alignment.center,
              items: _days.map((e) {
                return DropdownMenuItem<int>(
                  alignment: Alignment.center,
                  value: e,
                  child: Text(days[e - 1]),
                );
              }).toList(),
              value: widget.forRange ? v.secondDate.day : v.date.day,
              onChanged: (val) {
                widget.forRange
                    ? v.setSecondDate(
                        day: val,
                      )
                    : v.setDate(
                        day: val,
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
