import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:proclinic_doctor_windows/widgets/Visit_card.dart';
import 'package:provider/provider.dart';

class SearchPatientsUnder extends StatefulWidget {
  const SearchPatientsUnder({super.key});

  @override
  _SearchPatientsUnderState createState() => _SearchPatientsUnderState();
}

class _SearchPatientsUnderState extends State<SearchPatientsUnder> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxVisits>(
      builder: (context, v, c) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: ThemeConstants.cd,
              child: Column(
                children: [
                  //search bar
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('Search Patients : '),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: SizedBox(
                                  width: 400,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 3, 50, 3),
                                    child: TextField(
                                      controller: _controller,
                                      enableInteractiveSelection: true,
                                      enabled: true,
                                      decoration: const InputDecoration(
                                        isDense: true,
                                        icon: Icon(Icons.search),
                                        hintText: '...',
                                        labelText: 'Search by Name / Phone',
                                        alignLabelWithHint: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await EasyLoading.show(status: "Loading...");
                                  if (context.mounted) {
                                    await v.fetchVisits(
                                      docname: context
                                          .read<PxSelectedDoctor>()
                                          .doctor!
                                          .docnameEN,
                                      type: QueryType.Search,
                                      query: _controller.text,
                                    );
                                  }
                                  await EasyLoading.dismiss();
                                },
                                icon: const Icon(Icons.search),
                                label: const Text('Find'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //search results
                  Expanded(
                    flex: 8,
                    child: Card(
                      child: ListView.separated(
                        itemCount: v.visits.length,
                        itemBuilder: (context, index) {
                          return VisitCard(visit: v.visits[index]);
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}