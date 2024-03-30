import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/Patient_Profile_Page/manual_data_entry/widgets/supplies_store.dart';
import 'package:proclinic_doctor_windows/providers/supplies_provider.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:provider/provider.dart';

class SuppliesPage extends StatefulWidget {
  const SuppliesPage({super.key});

  @override
  State<SuppliesPage> createState() => _SuppliesPageState();
}

class _SuppliesPageState extends State<SuppliesPage> with AfterLayoutMixin {
  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxSupplies>().fetchAllDoctorSupplies();
    if (context.mounted) {
      context.read<PxSupplies>().filterSupplies('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // doctor supplies list
            const SuppliesStore(),
            // supplies list view + remove or alter item
            Expanded(
              flex: 2,
              child: Card.outlined(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<PxVisitData>(
                    builder: (context, d, _) {
                      return Column(
                        children: [
                          const Text(
                            "Prescription Supplies.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const Divider(),
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                while (
                                    d.supplies == null || d.supplies!.isEmpty) {
                                  return const Center(
                                    child: Card(
                                      child: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text("No Supplies Found."),
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: d.supplies?.length,
                                  itemBuilder: (context, index) {
                                    final item = d.supplies?.toList()[index];
                                    return Card(
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            child: Text("${index + 1}"),
                                          ),
                                          title: Text(item!.nameEn),
                                          subtitle: Text(
                                              "Amount: ${item.amount}\nPrice: ${item.price} L.E."),
                                          trailing: FloatingActionButton.small(
                                            heroTag: item.nameEn,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .cardTheme
                                                .shadowColor
                                                ?.withOpacity(0.7),
                                            child: const Icon(Icons.remove),
                                            onPressed: () {
                                              d.removeSupplies(item);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const Divider(),
                          ElevatedButton.icon(
                            onPressed: () async {
                              await EasyLoading.show(status: "Loading...");
                              if (context.mounted) {
                                await context
                                    .read<PxVisitData>()
                                    .updateSelectedVisit(
                                        "supplies",
                                        context
                                            .read<PxVisitData>()
                                            .supplies
                                            ?.map((e) => e.toMap())
                                            .toList());
                              }
                              if (context.mounted) {
                                await context
                                    .read<PxSupplies>()
                                    .deductSupplyItemsFromStore(
                                        context.read<PxVisitData>().supplies);
                              }
                              await EasyLoading.dismiss();
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Save"),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
