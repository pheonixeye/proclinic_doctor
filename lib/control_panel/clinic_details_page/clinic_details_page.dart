import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/constants/attribute_language.dart';
import 'package:proclinic_doctor_windows/control_panel/clinic_details_page/widgets/doctor_titles_card.dart';
import 'package:proclinic_doctor_windows/control_panel/setting_nav_drawer.dart';
import 'package:proclinic_doctor_windows/models/doctorModel.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:provider/provider.dart';

class ClinicDetailsPage extends StatefulWidget {
  const ClinicDetailsPage({super.key});

  @override
  State<ClinicDetailsPage> createState() => _ClinicDetailsPageState();
}

class _ClinicDetailsPageState extends State<ClinicDetailsPage> {
  late final TextEditingController _clinicDetailsController;
  late final TextEditingController _englishTitlesController;
  late final ScrollController _controller;

  @override
  void initState() {
    _clinicDetailsController = TextEditingController();
    _englishTitlesController = TextEditingController();
    _controller = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    _clinicDetailsController.dispose();
    _englishTitlesController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomSettingsNavDrawer(),
      appBar: AppBar(
        title: const Text(
          "Clinic Details",
          textScaler: TextScaler.linear(2.0),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: ThemeConstants.cd,
          child: Scrollbar(
            controller: _controller,
            thickness: 10,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //clinic details
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(),
                        const SizedBox(width: 20),
                        const SizedBox(
                          width: 150,
                          child: Text('Clinic Details :'),
                        ),
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
                              controller: _clinicDetailsController,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Consumer<PxSelectedDoctor>(
                          builder: (context, d, c) {
                            return ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('Add Clinic Detail'),
                              onPressed: () async {
                                await EasyLoading.show(status: "Loading...");

                                await d.updateSelectedDoctor(
                                  docname: d.doctor!.docnameEN,
                                  attribute: SxDoctor.CLINICDETAILS,
                                  value: [
                                    ...d.doctor!.clinicDetails,
                                    _clinicDetailsController.text
                                  ],
                                );

                                await EasyLoading.dismiss();

                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                _clinicDetailsController.clear();
                                await EasyLoading.showSuccess('Updated.');
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // container to show clinic details
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: ThemeConstants.cd,
                    child: Consumer<PxSelectedDoctor>(
                      builder: (context, d, c) {
                        return Center(
                          child: ListView.builder(
                            itemCount: d.doctor!.clinicDetails.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text('${index + 1}'),
                                ),
                                title: Text(d.doctor!.clinicDetails[index]),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    await EasyLoading.show(
                                        status: 'Loading...');
                                    await d.updateSelectedDoctor(
                                      docname: d.doctor!.docnameEN,
                                      attribute: SxDoctor.CLINICDETAILS,
                                      value: [...d.doctor!.clinicDetails]
                                        ..removeAt(index),
                                    );
                                    await EasyLoading.dismiss();
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

                  const DoctorTitlesCard(al: AttributeLanguage.en),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Divider(
                      color: Colors.blueGrey,
                      thickness: 5,
                      height: 10,
                    ),
                  ),
                  const DoctorTitlesCard(al: AttributeLanguage.ar),
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
    );
  }
}
