import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor_windows/providers/supplies_provider.dart';
import 'package:proclinic_doctor_windows/providers/visit_data_provider.dart';
import 'package:provider/provider.dart';

class SuppliesPrescription extends StatelessWidget {
  const SuppliesPrescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                        while (d.visit == null || d.visit!.supplies.isEmpty) {
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
                          itemCount: d.visit!.supplies.length,
                          itemBuilder: (context, index) {
                            final item = d.visit!.supplies[index];
                            return Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text("${index + 1}"),
                                  ),
                                  title: Text(item.nameEn),
                                  subtitle: Text(
                                    "Amount: ${item.amount}\nPrice: ${item.price} L.E.",
                                  ),
                                  trailing: FloatingActionButton.small(
                                    heroTag: item.nameEn,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).cardTheme.shadowColor?.withOpacity(0.7),
                                    child: const Icon(Icons.remove),
                                    onPressed: () async {
                                      await EasyLoading.show(
                                        status: "Loading...",
                                      );
                                      await d.removeSuppliesFromVisit(item);
                                      await EasyLoading.dismiss();
                                      if (context.mounted) {
                                        await context
                                            .read<PxSupplies>()
                                            .fetchAllDoctorSupplies()
                                            .whenComplete(() {
                                              if (context.mounted) {
                                                context
                                                    .read<PxSupplies>()
                                                    .filterSupplies('');
                                              }
                                            });
                                      }
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
