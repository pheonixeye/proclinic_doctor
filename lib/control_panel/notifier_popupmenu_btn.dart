import 'package:flutter/material.dart';
import 'package:proclinic_doctor_windows/providers/selected_doctor.dart';
import 'package:proclinic_doctor_windows/providers/socket_provider.dart';
import 'package:proclinic_doctor_windows/widgets/central_loading.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class NotifierPopupMenuBtn extends StatelessWidget {
  const NotifierPopupMenuBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxSelectedDoctor, PxSocketProvider>(
      builder: (context, d, s, _) {
        while (d.doctor == null) {
          return const CentralLoading();
        }
        final doc = d.doctor!;
        final docid = doc.id;
        final tr = Tr(
          e: doc.docnameEN,
          a: doc.docnameAR,
        );
        return CircleAvatar(
          child: PopupMenuButton(
            elevation: 8,
            tooltip: "Clinic Calls.",
            position: PopupMenuPosition.under,
            child: const Icon(Icons.menu),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    final msg = SocketNotificationMessage.pauseClinic(
                      docid,
                      tr,
                    );
                    s.sendSocketMessage(msg);
                  },
                  child: const Row(
                    children: [
                      Text("Pause Clinic"),
                      Spacer(),
                      Icon(Icons.pause_circle),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    final msg = SocketNotificationMessage.resumeClinic(
                      docid,
                      tr,
                    );
                    s.sendSocketMessage(msg);
                  },
                  child: const Row(
                    children: [
                      Text("Resume Clinic"),
                      Spacer(),
                      Icon(Icons.play_circle_outline_rounded),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    final msg = SocketNotificationMessage.callSecretary(
                      docid,
                      tr,
                    );
                    s.sendSocketMessage(msg);
                  },
                  child: const Row(
                    children: [
                      Text("Call Assisstant"),
                      Spacer(),
                      Icon(Icons.person_add_alt_1),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    final msg = SocketNotificationMessage.callNextVisit(
                      docid,
                      tr,
                    );
                    s.sendSocketMessage(msg);
                  },
                  child: const Row(
                    children: [
                      Text("Call Next Visit"),
                      Spacer(),
                      Icon(Icons.next_plan_outlined),
                    ],
                  ),
                ),
              ];
            },
          ),
        );
      },
    );
  }
}
