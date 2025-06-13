import 'package:proclinic_doctor/control_panel/drugs_prescription_settings_page/widgets/drug_input_form.dart';
import 'package:proclinic_doctor/control_panel/drugs_prescription_settings_page/widgets/drugs_view.dart';
import 'package:proclinic_doctor/control_panel/drugs_prescription_settings_page/widgets/procedure_input_form.dart';
import 'package:proclinic_doctor/control_panel/drugs_prescription_settings_page/widgets/procedures_view.dart';
import 'package:proclinic_doctor/control_panel/setting_nav_drawer.dart';
import 'package:flutter/material.dart';

class DrugsAndProceduresPage extends StatelessWidget {
  const DrugsAndProceduresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSettingsNavDrawer(),
      appBar: AppBar(
        title: const Text(
          'Drugs & Procedures',
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListView(
                children: const [
                  //row of add drugs field + button
                  DrugInputForm(),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Divider(
                      color: Colors.blueGrey,
                      thickness: 5,
                      height: 10,
                    ),
                  ),
                  //container list view of drugs from db
                  DrugsView(),
                  //end of drug list + field + button
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Divider(
                      color: Colors.blueGrey,
                      thickness: 5,
                      height: 10,
                    ),
                  ),

                  ProcedureInputForm(),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Divider(
                      color: Colors.blueGrey,
                      thickness: 5,
                      height: 10,
                    ),
                  ),
                  ProceduresView(),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Divider(
                      color: Colors.blueGrey,
                      thickness: 5,
                      height: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
