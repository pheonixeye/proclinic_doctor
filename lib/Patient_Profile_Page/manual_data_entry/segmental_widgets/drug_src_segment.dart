import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';

class DrugSearchSegment extends StatefulWidget {
  final TextEditingController drugsearchcontroller;

  const DrugSearchSegment({super.key, required this.drugsearchcontroller});
  @override
  _DrugSearchSegmentState createState() => _DrugSearchSegmentState();
}

class _DrugSearchSegmentState extends State<DrugSearchSegment> {
  Stream? drugstream;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: Container(
          decoration: ThemeConstants.cd,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //TODO: think of a way to get rid of -1 index error
            child: TextField(
              controller: widget.drugsearchcontroller,
              enableInteractiveSelection: true,
              enabled: true,
              decoration: const InputDecoration(
                isDense: true,
                icon: Icon(Icons.search),
                hintText: '...',
                labelText: 'Search Drugs...',
                alignLabelWithHint: true,
                fillColor: Colors.white,
              ),
              maxLines: 1,
            ),
          )),
      subtitle: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 55),
        child: Container(
          decoration: ThemeConstants.cd,
          child: StreamBuilder(
            stream: drugstream,
            builder: (context, snapshot) {
              List drug_data = !snapshot.hasData ? [] : snapshot.data;
              return GridView.builder(
                itemCount: !snapshot.hasData ? 0 : drug_data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    title: Text(drug_data[index].toString().toUpperCase()),
                    onTap: () {
                      widget.drugsearchcontroller.text =
                          drug_data[index].toString().toUpperCase();
                      //TODO: editingcontroller = value;
                      //TODO: clear controller after save
                    },
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 5,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
