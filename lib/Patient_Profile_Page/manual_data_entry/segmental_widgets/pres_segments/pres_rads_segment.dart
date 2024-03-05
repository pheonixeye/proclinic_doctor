import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/add_drug_lab_rad_toptdb.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/get_drug_lab_rad_from_db.dart';
import 'package:flutter/material.dart';

class RadGetterSegment extends StatefulWidget {
  final Map forwardedData;
  final Function callback;

  const RadGetterSegment(
      {Key? key, required this.forwardedData, required this.callback})
      : super(key: key);
  @override
  RadGetterSegmentState createState() => RadGetterSegmentState();
}

class RadGetterSegmentState extends State<RadGetterSegment> {
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
        drl: 'rads');
    return StreamBuilder(
        stream: druggetter.druggetterstream,
        builder: (context, snapshot) {
          List data = !snapshot.hasData ? [] : snapshot.data;

          return ListView.builder(
            itemCount: !snapshot.hasData ? 0 : data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text('R')),
                title: Text(
                  data[index].toString(),
                  style: TextStyle(fontSize: 14),
                ),
                trailing: IconButton(
                  icon: Icon(
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
                        fieldname: 'rads',
                        fieldvalue: data[index].toString());
                    setState(() {});
                  },
                ),
              );
            },
          );
        });
  }
}
