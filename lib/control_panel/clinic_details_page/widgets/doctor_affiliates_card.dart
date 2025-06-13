import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor/providers/selected_doctor.dart';
import 'package:proclinic_doctor/widgets/central_loading.dart';
import 'package:provider/provider.dart';
import 'package:proclinic_models/proclinic_models.dart' as models;

class DoctorAffiliatesCard extends StatefulWidget {
  const DoctorAffiliatesCard({super.key});
  @override
  State<DoctorAffiliatesCard> createState() => _DoctorTitlesCardState();
}

class _DoctorTitlesCardState extends State<DoctorAffiliatesCard> {
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
                const Text('Doctor Affiliates'),
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
                              labelText: 'English Affiliate',
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
                              labelText: 'Arabic Affiliate',
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
                      final affiliate = models.Affiliate.create(
                        affiliateEn: _enController.text,
                        affiliateAr: _arController.text,
                      );
                      await d.updateSelectedDoctor(
                        updateType: UpdateType.addToList,
                        id: d.doctor!.id,
                        attribute: 'affiliates',
                        value: affiliate.toJson(),
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
                      itemCount: d.doctor?.affiliates.length,
                      itemBuilder: (context, index) {
                        final item = d.doctor!.affiliates[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: SelectableText(item.affiliateEn),
                                subtitle: SelectableText(item.affiliateAr),
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
                                      attribute: 'affiliates',
                                      value: item.toJson(),
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
