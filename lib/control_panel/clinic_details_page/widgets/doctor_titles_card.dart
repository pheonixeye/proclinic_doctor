import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/widgets/central_loading.dart';
import 'package:provider/provider.dart';
import 'package:proclinic_models/proclinic_models.dart' as models;

class DoctorTitlesCard extends StatefulWidget {
  const DoctorTitlesCard({super.key});
  @override
  State<DoctorTitlesCard> createState() => _DoctorTitlesCardState();
}

class _DoctorTitlesCardState extends State<DoctorTitlesCard> {
  //todo: needs to be readjusted for the new doctor model
  late final TextEditingController _enController;
  late final TextEditingController _arController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _enController = TextEditingController();
    _arController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _enController.dispose();
    _arController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxSelectedDoctor>(
      builder: (context, d, _) {
        return ListTile(
          title: Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(),
                const Spacer(),
                const Text('Doctor Titles'),
                const Spacer(),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: TextFormField(
                            controller: _enController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'English Title',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Empty Inputs Are Not Allowed";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: TextFormField(
                            controller: _arController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelText: 'Arabic Title',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Empty Inputs Are Not Allowed";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Save'),
                  onPressed: () async {
                    //todo: request change
                    if (formKey.currentState!.validate()) {
                      await EasyLoading.show(status: "Loading...");
                      final title = models.Title.create(
                        titleEn: _enController.text,
                        titleAr: _arController.text,
                      );
                      await d.updateSelectedDoctor(
                        updateType: UpdateType.addToList,
                        id: d.doctor!.id,
                        attribute: 'titles',
                        value: title.toJson(),
                      );
                      _enController.clear();
                      _arController.clear();
                      await EasyLoading.showSuccess('Updated.');
                    }
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
          subtitle: ConstrainedBox(
            constraints: const BoxConstraints.tightForFinite(
              height: 300,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Builder(
                  builder: (context) {
                    while (d.doctor == null) {
                      return const CentralLoading();
                    }

                    return ListView.builder(
                      itemCount: d.doctor?.titles.length,
                      itemBuilder: (context, index) {
                        final title = d.doctor!.titles[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: SelectableText(title.titleEn),
                                subtitle: SelectableText(title.titleAr),
                                leading: const CircleAvatar(),
                                trailing: IconButton.filled(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await EasyLoading.show(
                                        status: "Loading...");
                                    //todo: delete item
                                    await d.updateSelectedDoctor(
                                      updateType: UpdateType.removeFromList,
                                      id: d.doctor!.id,
                                      attribute: 'titles',
                                      value: title.toJson(),
                                    );

                                    await EasyLoading.showSuccess('Updated.');
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
