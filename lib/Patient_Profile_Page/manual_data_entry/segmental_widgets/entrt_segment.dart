import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';

class EntrySegment extends StatefulWidget {
  const EntrySegment({
    super.key,
  });
  @override
  _EntrySegmentState createState() => _EntrySegmentState();
}

class _EntrySegmentState extends State<EntrySegment> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            heroTag: const Text('Save Button'),
            isExtended: true,
            elevation: 50,
            backgroundColor: Colors.purple[400],
            tooltip: 'Save Data',
            child: const Icon(Icons.save),
            onPressed: () async {},
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          body: Builder(
            builder: (context) {
              return StreamBuilder(
                stream: null,
                builder: (context, gridsnap) {
                  // bool grid_data = !gridsnap.hasData ? false : gridsnap.data;
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: ThemeConstants.cd,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: gridsnap.data == true
                              ? GridView.builder(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      tileColor: Colors.grey[200],
                                      contentPadding: const EdgeInsets.all(8.0),
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: const Text('text'),
                                      subtitle: const Card(
                                        color: Colors.white,
                                        child: TextField(
                                          maxLines: null,
                                          controller: null,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(
                                            Icons.clear_all_outlined),
                                        tooltip: 'Clear Field',
                                        onPressed: () {},
                                      ),
                                    );
                                  },
                                  itemCount: 0,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 6,
                                  ),
                                )

                              //TODO: make option for listview.separated vs gridview.builder

                              : ListView.separated(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      tileColor: Colors.grey[200],
                                      contentPadding: const EdgeInsets.all(8.0),
                                      leading: CircleAvatar(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      title: const Text('text'),
                                      subtitle: const Card(
                                          color: Colors.white,
                                          child: TextField(
                                            maxLines: null,
                                            controller: null,
                                          )),
                                      trailing: IconButton(
                                        icon: const Icon(
                                            Icons.clear_all_outlined),
                                        tooltip: 'Clear Field',
                                        onPressed: () {},
                                      ),
                                    );
                                  },
                                  itemCount: 0,
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      height: 15,
                                      thickness: 5,
                                      color: Theme.of(context).primaryColor,
                                    );
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
        );
      },
    );
  }
}
