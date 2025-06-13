import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:proclinic_doctor/Date_Cupertino_selectors/date_cupertino_selectors.dart';
import 'package:proclinic_doctor/providers/visits_provider.dart';
import 'package:provider/provider.dart';

class BookKeepingSelector extends StatelessWidget {
  const BookKeepingSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          child: Consumer<PxVisits>(
            builder: (context, v, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: RadioListTile(
                      title: const Text('Range'),
                      value: true,
                      groupValue: v.forRange,
                      onChanged: (val) {
                        v.setForRange(val!);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: RadioListTile(
                      title: const Text('Date'),
                      value: false,
                      groupValue: v.forRange,
                      onChanged: (val) {
                        v.setForRange(val!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: v.forRange
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              // decoration: ThemeConstants.cd,
                              child: Text(v.forRange
                                  ? "Select Start Date"
                                  : 'Select Date : '),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const SizedBox(
                            width: 150,
                            child: YearClinicPicker(),
                          ),
                          const SizedBox(width: 20),
                          const SizedBox(
                            width: 150,
                            child: MonthClinicPicker(),
                          ),
                          const SizedBox(width: 20),
                          const SizedBox(
                            width: 150,
                            child: DayClinicPicker(),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      if (v.forRange)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                // decoration: ThemeConstants.cd,
                                child: const Text('Select End Date : '),
                              ),
                            ),
                            const SizedBox(width: 20),
                            const SizedBox(
                              width: 150,
                              child: YearClinicPicker(
                                forRange: true,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const SizedBox(
                              width: 150,
                              child: MonthClinicPicker(
                                forRange: true,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const SizedBox(
                              width: 150,
                              child: DayClinicPicker(
                                forRange: true,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.search),
                      label: const Text('Search'),
                      onPressed: () async {
                        await EasyLoading.show(status: 'Loading...');
                        if (context.mounted) {
                          v.forRange
                              ? await v.fetchVisits(
                                  type: QueryType.Range,
                                )
                              : await v.fetchVisits(
                                  type: QueryType.Date,
                                );
                        }
                        await EasyLoading.dismiss();
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
