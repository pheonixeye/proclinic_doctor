import 'dart:math';

import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/add_drug_lab_rad_toptdb.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/custom_dropdowns_widgets/lab_rad_dropdown.dart';
import 'package:proclinic_doctor_windows/control_panel/labs_rads_settings_page/labs_db.dart';
import 'package:proclinic_doctor_windows/control_panel/labs_rads_settings_page/rads_db.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';

class LabRadSegment extends StatefulWidget {
  Function(int) callback;
  int labrad;
  Map forwardedData;
  Function callstateback;
  LabRadSegment({
    super.key,
    required this.callback,
    required this.labrad,
    required this.forwardedData,
    required this.callstateback,
  });
  @override
  _LabRadSegmentState createState() => _LabRadSegmentState();
}

class _LabRadSegmentState extends State<LabRadSegment> {
  LabsClass labs = LabsClass(docname: globallySelectedDoctor);
  RadsClass rads = RadsClass(docname: globallySelectedDoctor);
  DRLadder adder = DRLadder();
  late Stream? labradstream;
  late String fieldname;

  @override
  Widget build(BuildContext context) {
    if (widget.labrad == 0) {
      labradstream = labs.doctorlablist;
      fieldname = 'labs';
    } else if (widget.labrad == 1) {
      labradstream = rads.doctorradlist;
      fieldname = 'rads';
    } else {
      labradstream = null;
    }
    return ListTile(
      leading: const CircleAvatar(),
      title: LabRadDropdown(
        callback: widget.callback,
        labrad: widget.labrad,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 55),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white54.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    offset: const Offset(5, 5),
                    blurRadius: 5,
                    spreadRadius: 5),
              ]),
          child: StreamBuilder(
              stream: labradstream,
              builder: (context, snapshot) {
                List grid_data = !snapshot.hasData ? [] : snapshot.data;
                // print(grid_data);
                // print(labrad);
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8,
                    crossAxisCount: 2,
                  ),
                  itemCount: !snapshot.hasData ? 0 : grid_data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(grid_data[index].toString().toUpperCase()),
                      trailing: IconButton(
                        splashColor: Colors.red,
                        splashRadius: 20.0,
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          //TODO: add data to pts prescription
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
                              fieldname: fieldname,
                              fieldvalue:
                                  grid_data[index].toString().toLowerCase());
                          setState(() {});
                          widget.callstateback();
                        },
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
