import 'dart:async';

import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/add_drug_lab_rad_toptdb.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/custom_dropdowns_widgets/counter_dropdown.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/custom_dropdowns_widgets/dose_dropdown.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/custom_dropdowns_widgets/hr_dy_wk_dropdow.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/custom_dropdowns_widgets/misc_dropdown.dart';
import 'package:flutter/material.dart';

// StreamController updateprescstream = StreamController.broadcast();

class DosageSegment extends StatefulWidget {
  final TextEditingController drugcont;
  final Map forwardedData;
  final Function callback;

  const DosageSegment({
    super.key,
    required this.drugcont,
    required this.forwardedData,
    required this.callback,
  });
  @override
  _DosageSegmentState createState() => _DosageSegmentState();
}

class _DosageSegmentState extends State<DosageSegment> {
  DRLadder adder = DRLadder();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //Units list tile
          ListTile(
            leading: const CircleAvatar(),
            title: const Tooltip(
                message: 'عدد وحدات الدواء - مثلا: 2 قرص',
                child: Text('Units :')),
            subtitle: CounterNumbersDropdown(
              type: 'units',
            ),
          ),

          //dose list tile
          ListTile(
            leading: const CircleAvatar(),
            title: const Tooltip(
                message: 'نوع جرعة الدواء - مثلا: قرص او كبسولة',
                child: Text('Dose Form :')),
            subtitle: DosesDropdown(),
          ),

          //freq list tile
          ListTile(
            leading: const CircleAvatar(),
            title: const Tooltip(
                message: 'تكرارية الدواء - مثلا : كل 12 ساعة',
                child: Text('Frequency :')),
            subtitle: Row(children: [
              SizedBox(
                  width: 100,
                  child: CounterNumbersDropdown(
                    type: 'freq',
                  )),
              SizedBox(
                  width: 160,
                  child: HourDayWeekDropdown(
                    type: 'freq',
                  )),
            ]),
          ),
          //duration list tile
          ListTile(
            leading: const CircleAvatar(),
            title: const Tooltip(
                message: 'مدة الدواء - مثلا : لمدة 10 ايام',
                child: Text('Duration :')),
            subtitle: Row(children: [
              SizedBox(
                  width: 100,
                  child: CounterNumbersDropdown(
                    type: 'dur',
                  )),
              SizedBox(
                  width: 160,
                  child: HourDayWeekDropdown(
                    type: 'dur',
                  )),
            ]),
          ),

          //misc list tile
          ListTile(
            leading: const CircleAvatar(),
            title: const Tooltip(
                message: 'خاص / متنوع - مثلا : قبل الاكل او عند النوم',
                child: Text('Misc :')),
            subtitle: MiscDropdown(),
          ),

          //button for adding drug data
          ListTile(
            leading: const CircleAvatar(),
            title: ElevatedButton.icon(
              icon: const Icon(Icons.add_box_sharp),
              label: const Text('Add to Prescription'),
              onPressed: () async {
                await adder.addDRL(
                    id: widget.forwardedData['id'],
                    day: widget.forwardedData['day'],
                    ptName: widget.forwardedData['ptname'],
                    docName: widget.forwardedData['docname'],
                    month: widget.forwardedData['month'],
                    year: widget.forwardedData['year'],
                    phone: widget.forwardedData['phone'],
                    procedure: widget.forwardedData['procedure'],
                    age: widget.forwardedData['age'],
                    amount: widget.forwardedData['amount'],
                    visit: widget.forwardedData['visit'],
                    remaining: widget.forwardedData['remaining'],
                    cashtype: widget.forwardedData['cashtype'],
                    clinic: widget.forwardedData['clinic'],
                    dob: widget.forwardedData['dob'],
                    fieldname: 'drugs',
                    fieldvalue: '${widget.drugcont.text.toUpperCase()} \n'
                        ' (${notablets}) ${dosage} كل ${frequencytablet} ${freq_hrwkdy} لمدة ${durationtablet} ${dur_hrwkdy} ${misc_}');
                await Future.delayed(const Duration(milliseconds: 50));
                widget.drugcont.clear();
                setState(() {});
                widget.callback();
                // drugGetterSegmentState.setState(() {});
                // updateprescstream.sink.add(0);
                //TODO: add drug to db(done)
                //TODO: fix units before drug dose
              },
            ),
          )
        ],
      ),
    );
  }
}
