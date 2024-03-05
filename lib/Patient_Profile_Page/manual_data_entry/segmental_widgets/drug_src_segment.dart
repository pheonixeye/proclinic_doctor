import 'dart:math';

import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/drug_page_db.dart.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';

class DrugSearchSegment extends StatefulWidget {
  final TextEditingController drugsearchcontroller;

  const DrugSearchSegment({super.key, required this.drugsearchcontroller});
  @override
  _DrugSearchSegmentState createState() => _DrugSearchSegmentState();
}

class _DrugSearchSegmentState extends State<DrugSearchSegment> {
  Stream? drugstream;
  DrugsClass drugs = DrugsClass(docname: globallySelectedDoctor);

  @override
  Widget build(BuildContext context) {
    SearchDrugsClass srcdrugs = SearchDrugsClass(
        docname: globallySelectedDoctor,
        drug: widget.drugsearchcontroller.text);
    if (widget.drugsearchcontroller.text.isEmpty) {
      drugstream = drugs.doctordruglist;
    } else if (widget.drugsearchcontroller.text.isNotEmpty) {
      drugstream = srcdrugs.doctordrugsearchlist;
    } else {
      drugstream = null;
    }
    return ListTile(
      leading: const CircleAvatar(),
      title: Container(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //TODO: think of a way to get rid of -1 index error
            child: TextField(
              controller: widget.drugsearchcontroller,
              enableInteractiveSelection: true,
              enabled: true,
              decoration: const InputDecoration(
                isDense: true,
                icon: Icon(Icons.search),
                hintText: '...',
                labelText: 'Search Drugs...',
                alignLabelWithHint: true,
                fillColor: Colors.white,
              ),
              onChanged: (String value) async {
                setState(() {});
              },
              maxLines: 1,
            ),
          )),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 55),
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
              stream: drugstream,
              builder: (context, snapshot) {
                List drug_data = !snapshot.hasData ? [] : snapshot.data;
                return GridView.builder(
                  itemCount: !snapshot.hasData ? 0 : drug_data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(drug_data[index].toString().toUpperCase()),
                      onTap: () {
                        widget.drugsearchcontroller.text =
                            drug_data[index].toString().toUpperCase();
                        //TODO: editingcontroller = value;
                        //TODO: clear controller after save
                      },
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 5),
                );
              }),
        ),
      ),
    );
  }
}
