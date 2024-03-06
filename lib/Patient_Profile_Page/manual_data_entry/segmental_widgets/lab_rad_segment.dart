import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';

class LabRadSegment extends StatefulWidget {
  const LabRadSegment({
    super.key,
  });
  @override
  _LabRadSegmentState createState() => _LabRadSegmentState();
}

class _LabRadSegmentState extends State<LabRadSegment> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: SizedBox(),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 55),
        child: Container(
          decoration: ThemeConstants.cd,
          child: StreamBuilder(
              stream: null,
              builder: (context, snapshot) {
                final grid_data =
                    !snapshot.hasData ? [] : snapshot.data as List;
                // print(grid_data);
                // print(labrad);
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 8,
                    crossAxisCount: 2,
                  ),
                  itemCount: !snapshot.hasData ? 0 : grid_data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(grid_data[index].toString().toUpperCase()),
                      trailing: IconButton(
                        splashColor: Colors.red,
                        splashRadius: 20.0,
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          //TODO: add data to pts prescription
                        },
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
