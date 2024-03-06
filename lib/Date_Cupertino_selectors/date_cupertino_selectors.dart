import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
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
    return Container(
      height: 50,
      decoration: ThemeConstants.cd,
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
    return Container(
      height: 50,
      decoration: ThemeConstants.cd,
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
        onChanged: (val) {
          widget.forRange
              ? context.read<PxVisits>().setSecondDate(
                    month: val,
                  )
              : context.read<PxVisits>().setDate(
                    month: val,
                  );
        },
      ),
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
  _DayClinicPickerState createState() => _DayClinicPickerState();
}

class _DayClinicPickerState extends State<DayClinicPicker> {
  final _days = List.generate(31, (index) => index + 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: ThemeConstants.cd,
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
        onChanged: (val) {
          widget.forRange
              ? context.read<PxVisits>().setSecondDate(
                    day: val,
                  )
              : context.read<PxVisits>().setDate(
                    day: val,
                  );
        },
      ),
    );
  }
}
