import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//yearpicker
int globalYear = DateTime.now().year;
String globalMonth = '01';
String globalDay = '01';
bool globalVisibility = true;
List<int> years = List.generate(21, (i) => i + 2010);

class YearClinicPicker extends StatefulWidget {
  const YearClinicPicker({super.key});

  @override
  YearClinicPickerState createState() => YearClinicPickerState();
}

class YearClinicPickerState extends State<YearClinicPicker> {
  @override
  Widget build(BuildContext context) {
    int selectedyear;

    return Visibility(
      visible: globalVisibility,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(4.0, 4.0),
              blurRadius: 4.0,
            ),
          ],
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
              initialItem: years.indexOf(DateTime.now().year)),
          looping: true,
          itemExtent: 32,
          onSelectedItemChanged: (value) {
            setState(() {
              selectedyear = value;
              globalYear = years[value];
              print(globalYear);
            });
          },
          children: years.map((e) {
            return Text('$e');
          }).toList(),
        ),
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
  const MonthClinicPicker({super.key});

  @override
  MonthClinicPickerState createState() => MonthClinicPickerState();
}

class MonthClinicPickerState extends State<MonthClinicPicker> {
  @override
  Widget build(BuildContext context) {
    int selectedMonthValue = 0;
    String selectedMonth = months[selectedMonthValue];

    return Visibility(
      visible: globalVisibility,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(4.0, 4.0),
              blurRadius: 4.0,
            ),
          ],
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: CupertinoPicker(
          useMagnifier: true,
          looping: true,
          itemExtent: 32,
          onSelectedItemChanged: (value) {
            setState(() {
              selectedMonthValue = value;
              globalMonth = months[value].substring(0, 2);
              print(globalMonth);
            });
          },
          children: months.map((e) {
            return Text(e);
          }).toList(),
        ),
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
  const DayClinicPicker({super.key});

  @override
  _DayClinicPickerState createState() => _DayClinicPickerState();
}

class _DayClinicPickerState extends State<DayClinicPicker> {
  @override
  Widget build(BuildContext context) {
    int selectedday = 1;
    return Visibility(
      visible: globalVisibility,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(4.0, 4.0),
              blurRadius: 4.0,
            ),
          ],
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: CupertinoPicker(
          // magnification: 1.5,
          useMagnifier: true,
          looping: true,
          itemExtent: 32,
          onSelectedItemChanged: (value) {
            setState(() {
              selectedday = value;
              globalDay = days[value];
              print(globalDay);
            });
          },
          children: days.map((e) {
            return Text(e);
          }).toList(),
        ),
      ),
    );
  }
}
