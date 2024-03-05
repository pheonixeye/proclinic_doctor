import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/doses_db.dart';
import 'package:proclinic_doctor_windows/doctorsdropdownmenubuttonwidget/doctors_dropdownmenubutton.dart';
import 'package:flutter/material.dart';

String? dosage;

class DosesDropdown extends StatefulWidget {
  const DosesDropdown({super.key});

  @override
  _DosesDropdownState createState() => _DosesDropdownState();
}

class _DosesDropdownState extends State<DosesDropdown> {
  DosesClass dose = DosesClass(docname: globallySelectedDoctor);
  String? selectedvalue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
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
        child: StreamBuilder(
            stream: dose.doctordoselist,
            builder: (context, snapshot) {
              List data = !snapshot.hasData ? [] : snapshot.data;
              List<String> datastring = data.map((e) {
                return e.toString();
              }).toList();
              return DropdownButton<String>(
                isExpanded: true,
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.blue,
                ),
                items: datastring.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(e.toString())],
                    ),
                  );
                }).toList(),
                value: selectedvalue,
                onChanged: (value) {
                  setState(() {
                    selectedvalue = value;
                    dosage = value.toString();
                  });
                },
              );
            }),
      ),
    );
  }
}
