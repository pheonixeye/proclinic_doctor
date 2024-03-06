import 'package:flutter/material.dart';

class LabGetterSegment extends StatefulWidget {
  const LabGetterSegment({
    Key? key,
  }) : super(key: key);
  @override
  LabGetterSegmentState createState() => LabGetterSegmentState();
}

class LabGetterSegmentState extends State<LabGetterSegment> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          final data = !snapshot.hasData ? [] : snapshot.data as List;

          return ListView.builder(
            itemCount: !snapshot.hasData ? 0 : data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(child: Text('L')),
                title: Text(
                  data[index].toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                  ),
                  onPressed: () async {},
                ),
              );
            },
          );
        });
    // });
  }
}
