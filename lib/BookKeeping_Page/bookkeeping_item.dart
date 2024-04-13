import 'package:flutter/material.dart';
import 'package:proclinic_models/proclinic_models.dart';

class BookKeepingListItem extends StatelessWidget {
  const BookKeepingListItem({super.key, required this.visit});
  final Visit visit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amber.shade400,
        ),
        title: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    child: Icon(Icons.person),
                  ),
                ),
                Expanded(
                  child: Text('Name :\n${visit.toJson()['ptname']}'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    child: Icon(Icons.local_hospital_sharp),
                  ),
                ),
                Expanded(
                  child: Text('Phone :\n${visit.toJson()['phone']}'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    child: Icon(Icons.monetization_on),
                  ),
                ),
                Expanded(
                  child: Text('Paid :\n${visit.toJson()['amount']} L.E.'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    child: Icon(Icons.money_off),
                  ),
                ),
                Expanded(
                  child:
                      Text('Remaining :\n${visit.toJson()['remaining']} L.E.'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    child: Icon(Icons.report_problem),
                  ),
                ),
                Expanded(
                  child: Text('Visit Type :\n${visit.toJson()['visittype']}'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    child: Icon(Icons.emoji_symbols),
                  ),
                ),
                Expanded(
                  child: Text(
                      'Procedure :\n${visit.toJson()['procedure'] ?? 'No Procedure'}'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 30,
                    child: Icon(Icons.calendar_today),
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final d = DateTime.parse(visit.visitDate);
                      return Text(
                          'Visit Date :\n${d.day}-${d.month}-${d.year}');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
