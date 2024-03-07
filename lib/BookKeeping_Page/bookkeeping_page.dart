import 'package:proclinic_doctor_windows/BookKeeping_Page/bookKeeping_item.dart';
import 'package:proclinic_doctor_windows/BookKeeping_Page/bookkeeping_selector.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:provider/provider.dart';

class BookKeepingPage extends StatefulWidget {
  const BookKeepingPage({super.key});

  @override
  State<BookKeepingPage> createState() => _BookKeepingPageState();
}

class _BookKeepingPageState extends State<BookKeepingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PxVisits>(
      builder: (context, v, c) {
        return Scaffold(
          body: Column(
            children: [
              //date selection card
              const BookKeepingSelector(),
              //list view of findings
              Expanded(
                flex: 6,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      itemCount: v.visits.length,
                      itemBuilder: (context, index) {
                        return BookKeepingListItem(
                          visit: v.visits[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 5,
                          height: 15,
                          color: Colors.blueGrey,
                        );
                      },
                    ),
                  ),
                ),
              ),
              //amount calculator
              Expanded(
                flex: 2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      trailing: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 1,
                          ),
                        ],
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Total Number of Patients of Dr. ${context.read<PxSelectedDoctor>().doctor!.docnameEN} in year ${v.date.year} - month ${v.date.month} - till day ${v.date.day}'),
                          const SizedBox(width: 20),
                          CircleAvatar(
                            child: Text(
                              '${v.visits.length}'.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'Total income in searched duration in L.E.'),
                          const SizedBox(
                            width: 20,
                          ),
                          Builder(
                            builder: (context) {
                              final List<int> amounts =
                                  v.visits.map((e) => e.amount).toList();
                              final money =
                                  amounts.fold<int>(0, (a, b) => a + b);
                              return CircleAvatar(
                                child: Text('$money'),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
