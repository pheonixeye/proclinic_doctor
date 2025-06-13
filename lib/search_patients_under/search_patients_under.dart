import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:proclinic_doctor/providers/visits_provider.dart';
// import 'package:proclinic_doctor/theme/theme.dart';
import 'package:proclinic_doctor/widgets/Visit_card.dart';
import 'package:provider/provider.dart';

class SearchPatientsUnder extends StatefulWidget {
  const SearchPatientsUnder({super.key});

  @override
  State<SearchPatientsUnder> createState() => _SearchPatientsUnderState();
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
                            padding: EdgeInsets.all(16.0),
                            child: Text('Search Patients : '),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 6,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 400,
                                  child: TextField(
                                    controller: _controller,
                                    enableInteractiveSelection: true,
                                    enabled: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      labelText: 'Search by Name / Phone',
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
        );
      },
    );
  }
}
