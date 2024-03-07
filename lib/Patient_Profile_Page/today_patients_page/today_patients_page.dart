import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/visits_provider.dart';
import 'package:proclinic_doctor_windows/theme/theme.dart';
import 'package:proclinic_doctor_windows/widgets/visit_card.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class TodayPatients extends StatefulWidget {
  const TodayPatients({super.key});

  @override
  _TodayPatientsState createState() => _TodayPatientsState();
}

class _TodayPatientsState extends State<TodayPatients> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxVisits>().fetchVisits(
          docname: context.read<PxSelectedDoctor>().doctor!.docnameEN,
          type: QueryType.Today,
        );
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
              child: Container(
                decoration: ThemeConstants.cd,
                child: ListView.separated(
                  itemCount: v.visits.length,
                  itemBuilder: (context, index) {
                    return VisitCard(
                      visit: v.visits[index],
                      fromNew: true,
                      forSearch: false,
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
        );
      },
    );
  }
}
