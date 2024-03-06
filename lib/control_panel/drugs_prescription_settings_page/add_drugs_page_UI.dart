import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/clinic_details_db.dart';
import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/doc_titles_db.dart';
import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/doses_db.dart';
import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/drug_page_db.dart.dart';
import 'package:proclinic_doctor_windows/control_panel/drugs_prescription_settings_page/misc_db.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';

class AddDrugsPage extends StatefulWidget {
  const AddDrugsPage({super.key});

  @override
  _AddDrugsPageState createState() => _AddDrugsPageState();
}

class _AddDrugsPageState extends State<AddDrugsPage> {
  TextEditingController drugController = TextEditingController();
  TextEditingController doctitleController = TextEditingController();
  TextEditingController clinicdetailController = TextEditingController();
  TextEditingController doseController = TextEditingController();
  TextEditingController miscController = TextEditingController();

  DrugsClass drugs = DrugsClass(docname: globallySelectedDoctor);
  TitlesClass titles = TitlesClass(docname: globallySelectedDoctor);
  ClinicDetailsClass clinicdetails =
      ClinicDetailsClass(docname: globallySelectedDoctor);
  DosesClass doses = DosesClass(docname: globallySelectedDoctor);
  MiscClass misc = MiscClass(docname: globallySelectedDoctor);
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSettingsNavDrawer(),
      appBar: AppBar(
        title: const Text(
          'Drugs & Prescriptions',
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: ThemeConstants.cd,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: CupertinoScrollbar(
                controller: _controller,
                thickness: 10,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      //row of add drugs field + button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(),
                            const SizedBox(width: 20),
                            const SizedBox(
                                width: 150,
                                child: Text('Prescription Drugs :')),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 350,
                              child: Card(
                                color: Colors.purple[100],
                                child: TextField(
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    icon: Icon(Icons.add_to_queue),
                                    hintText: '...',
                                    labelText: 'Add Drugs',
                                    alignLabelWithHint: true,
                                    fillColor: Colors.white,
                                  ),
                                  maxLines: null,
                                  controller: drugController,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add to Drug List'),
                              onPressed: () async {
                                await drugs.updateDoctorDrugstoMongo(
                                    docname: globallySelectedDoctor,
                                    drug: drugController.text.toLowerCase());
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                drugController.clear();
                              },
                            )
                          ],
                        ),
                      ),
                      //container list view of drugs from db
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: ThemeConstants.cd,
                        child: StreamBuilder(
                          stream: drugs.doctordruglist,
                          builder: (context, snapshot) {
                            List drugdata =
                                !snapshot.hasData ? [] : snapshot.data;
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 6,
                              ),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(drugdata[index]
                                        .toString()
                                        .toUpperCase()),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await drugs.deleteDoctorDrugsFromMongo(
                                          docname: globallySelectedDoctor,
                                          drug: drugdata[index]);
                                      setState(() {});
                                    },
                                  ),
                                );
                              },
                              itemCount:
                                  !snapshot.hasData ? 0 : drugdata.length,
                            );
                          },
                        ),
                      ),
                      //end of drug list + field + button
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Divider(
                          color: Colors.blueGrey,
                          thickness: 5,
                          height: 10,
                        ),
                      ),
                      //doses
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(),
                            const SizedBox(width: 20),
                            const SizedBox(width: 150, child: Text('Doses :')),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 350,
                              child: Card(
                                child: TextField(
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    icon: Icon(Icons.add_to_queue),
                                    hintText: '...',
                                    labelText: 'Add Doses',
                                    alignLabelWithHint: true,
                                    fillColor: Colors.white,
                                  ),
                                  maxLines: null,
                                  controller: doseController,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add Dose'),
                              onPressed: () async {
                                await doses.updateDoctorDosestoMongo(
                                    docname: globallySelectedDoctor,
                                    dose: doseController.text.toLowerCase());
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                doseController.clear();
                                setState(() {});

                                //TODO: add dose to dr named db
                              },
                            )
                          ],
                        ),
                      ),
                      // container to show doses of doctor
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: ThemeConstants.cd,
                        child: StreamBuilder(
                          stream: doses.doctordoselist,
                          builder: (context, snapshot) {
                            List dosedata =
                                !snapshot.hasData ? [] : snapshot.data;
                            return Center(
                              child: ListView.builder(
                                itemCount:
                                    !snapshot.hasData ? 0 : dosedata.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Text(dosedata[index]
                                        .toString()
                                        .toUpperCase()),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await doses.deleteDoctorDosesFromMongo(
                                            docname: globallySelectedDoctor,
                                            dose: dosedata[index]);
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Divider(
                          color: Colors.blueGrey,
                          thickness: 5,
                          height: 10,
                        ),
                      ),
                      //doctor title
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(),
                            const SizedBox(width: 20),
                            const SizedBox(
                                width: 150, child: Text('Doctor Title :')),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 350,
                              child: Card(
                                child: TextField(
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    icon: Icon(Icons.add_to_queue),
                                    hintText: '...',
                                    labelText: 'Add Doctor Titles',
                                    alignLabelWithHint: true,
                                    fillColor: Colors.white,
                                  ),
                                  maxLines: null,
                                  controller: doctitleController,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add Doctor Title'),
                              onPressed: () async {
                                await titles.updateDoctorTitlestoMongo(
                                    docname: globallySelectedDoctor,
                                    title:
                                        doctitleController.text.toLowerCase());
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                doctitleController.clear();
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                      // container to show titles of doctor
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: ThemeConstants.cd,
                        child: StreamBuilder(
                          stream: titles.doctortitlelist,
                          builder: (context, snapshot) {
                            List titledata =
                                !snapshot.hasData ? [] : snapshot.data;
                            return Center(
                              child: ListView.builder(
                                itemCount:
                                    !snapshot.hasData ? 0 : titledata.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text('${index + 1}'),
                                    ),
                                    title: Text(titledata[index]
                                        .toString()
                                        .toUpperCase()),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await titles
                                            .deleteDoctorTitlesFromMongo(
                                                docname: globallySelectedDoctor,
                                                title: titledata[index]);
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Divider(
                          color: Colors.blueGrey,
                          thickness: 5,
                          height: 10,
                        ),
                      ),
                      //clinic location
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(),
                            const SizedBox(width: 20),
                            const SizedBox(
                                width: 150, child: Text('Clinic Details :')),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 350,
                              child: Card(
                                child: TextField(
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    icon: Icon(Icons.add_to_queue),
                                    hintText: '...',
                                    labelText: 'Add Clinic Details',
                                    alignLabelWithHint: true,
                                    fillColor: Colors.white,
                                  ),
                                  maxLines: null,
                                  controller: clinicdetailController,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add Clinic Detail'),
                              onPressed: () async {
                                await clinicdetails
                                    .updateDoctorClinicDetailstoMongo(
                                        docname: globallySelectedDoctor,
                                        clinicDetails: clinicdetailController
                                            .text
                                            .toLowerCase());
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                clinicdetailController.clear();
                                setState(() {});
                                //TODO: add clinic details to dr named db
                              },
                            )
                          ],
                        ),
                      ),
                      // container to show titles of doctor
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: ThemeConstants.cd,
                        child: StreamBuilder(
                            stream: clinicdetails.doctorClinicDetailslist,
                            builder: (context, snapshot) {
                              List clinicdetailsdata =
                                  !snapshot.hasData ? [] : snapshot.data;
                              return Center(
                                child: ListView.builder(
                                  itemCount: !snapshot.hasData
                                      ? 0
                                      : clinicdetailsdata.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        child: Text('${index + 1}'),
                                      ),
                                      title: Text(clinicdetailsdata[index]
                                          .toString()
                                          .toUpperCase()),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          await clinicdetails
                                              .deleteDoctorClinicDetailsFromMongo(
                                                  docname:
                                                      globallySelectedDoctor,
                                                  clinicDetails:
                                                      clinicdetailsdata[index]);
                                          setState(() {});
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Divider(
                          color: Colors.blueGrey,
                          thickness: 5,
                          height: 10,
                        ),
                      ),
                      //misc options for prescriptions :
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(),
                            const SizedBox(width: 20),
                            const SizedBox(width: 150, child: Text('Misc. :')),
                            const SizedBox(
                              width: 50,
                            ),
                            SizedBox(
                              width: 350,
                              child: Card(
                                child: TextField(
                                  enableInteractiveSelection: true,
                                  enabled: true,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    icon: Icon(Icons.add_to_queue),
                                    hintText: '...',
                                    labelText: 'Add Misc.',
                                    alignLabelWithHint: true,
                                    fillColor: Colors.white,
                                  ),
                                  maxLines: null,
                                  controller: miscController,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add Misc.'),
                              onPressed: () async {
                                await misc.updateDoctorMisctoMongo(
                                    docname: globallySelectedDoctor,
                                    misc: miscController.text.toLowerCase());
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                miscController.clear();
                                setState(() {});
                                //TODO: add  misc to dr named db
                              },
                            )
                          ],
                        ),
                      ),
                      // container to show misc of doctor
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: ThemeConstants.cd,
                        child: StreamBuilder(
                            stream: misc.doctormisclist,
                            builder: (context, snapshot) {
                              List miscdata =
                                  !snapshot.hasData ? [] : snapshot.data;
                              return Center(
                                child: ListView.builder(
                                  itemCount:
                                      !snapshot.hasData ? 0 : miscdata.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        child: Text('${index + 1}'),
                                      ),
                                      title: Text(miscdata[index]
                                          .toString()
                                          .toUpperCase()),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          await misc.deleteDoctorMiscFromMongo(
                                              docname: globallySelectedDoctor,
                                              misc: miscdata[index]);
                                          setState(() {});
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      ),
                      const Padding(
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
        ),
      ),
    );
  }
}
