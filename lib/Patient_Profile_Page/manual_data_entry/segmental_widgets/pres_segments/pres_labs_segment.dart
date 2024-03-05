import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/add_drug_lab_rad_toptdb.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/get_drug_lab_rad_from_db.dart';
import 'package:flutter/material.dart';

class LabGetterSegment extends StatefulWidget {
  final Map forwardedData;
  final Function callback;

  const LabGetterSegment({
    Key? key,
    required this.forwardedData,
    required this.callback,
  }) : super(key: key);
  @override
  LabGetterSegmentState createState() => LabGetterSegmentState();
}

class LabGetterSegmentState extends State<LabGetterSegment> {
  DRLadder drl = DRLadder();
  @override
  Widget build(BuildContext context) {
    DrugGetterFromDb druggetter = DrugGetterFromDb(
        id: widget.forwardedData['id'],
        day: widget.forwardedData['day'],
        ptname: widget.forwardedData['ptname'],
        docname: widget.forwardedData['docname'],
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
        drl: 'labs');
    return StreamBuilder(
        stream: druggetter.druggetterstream,
        builder: (context, snapshot) {
          List data = !snapshot.hasData ? [] : snapshot.data;

          // return StreamBuilder<Object>(
          //     stream: updateprescstream.stream,
          //     builder: (context, intshot) {
          return ListView.builder(
            itemCount: !snapshot.hasData ? 0 : data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(child: Text('L')),
                title: Text(
                  data[index].toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    //TODO: delete drug entry
                    await drl.deleteDRL(
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
                        fieldname: 'labs',
                        fieldvalue: data[index].toString());
                    setState(() {});
                  },
                ),
              );
            },
          );
        });
    // });
  }
}
