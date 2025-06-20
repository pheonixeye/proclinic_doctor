import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proclinic_doctor/providers/app_organizer_provider.dart';
import 'package:proclinic_doctor/providers/visits_provider.dart';
import 'package:proclinic_doctor/widgets/today_visit_card.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class TodayPatients extends StatefulWidget {
  const TodayPatients({super.key});

  @override
  State<TodayPatients> createState() => _TodayPatientsState();
}

class _TodayPatientsState extends State<TodayPatients> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxVisits>().fetchVisits(type: QueryType.Today);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxVisits>(
      builder: (context, v, c) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.80,
              child: Card(
                elevation: 6,
                child: Builder(
                  builder: (context) {
                    if (v.visits.isEmpty) {
                      return const Center(
                        child: Card.outlined(
                          elevation: 10,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('No Visits Found for Today.'),
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: v.visits.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider(
                          create:
                              (context) =>
                                  PxAppOrganizer(visitId: v.visits[index].id),
                          builder: (context, _) {
                            return TodayVisitCard(visit: v.visits[index]);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 5,
                          height: 15,
                          color: Colors.blueGrey,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
