import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:proclinic_doctor_windows/widgets/visit_card.dart';
import 'package:provider/provider.dart';

class AllPatientsUnder extends StatefulWidget {
  const AllPatientsUnder({super.key});

  @override
  _AllPatientsUnderState createState() => _AllPatientsUnderState();
}

class _AllPatientsUnderState extends State<AllPatientsUnder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PxVisits>(
      builder: (context, v, c) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: ThemeConstants.cd,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
            ),
          ),
        );
      },
    );
  }
}
