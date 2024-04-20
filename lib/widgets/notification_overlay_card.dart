import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:minisound/minisound.dart';
import 'package:proclinic_doctor_windows/functions/format_time.dart';
import 'package:proclinic_doctor_windows/functions/visit_requests.dart';
import 'package:proclinic_doctor_windows/main_init.dart';
import 'package:proclinic_doctor_windows/providers/overlay_provider.dart';
import 'package:proclinic_doctor_windows/widgets/central_loading.dart';
import 'package:proclinic_models/proclinic_models.dart';
import 'package:provider/provider.dart';

class NotificationOverlayCard extends StatefulWidget {
  const NotificationOverlayCard({super.key, required this.notification});
  final AppNotification notification;

  @override
  State<NotificationOverlayCard> createState() =>
      _NotificationOverlayCardState();
}

class _NotificationOverlayCardState extends State<NotificationOverlayCard>
    with AfterLayoutMixin {
  late final Timer? timer;
  static const _duration = Duration(milliseconds: 10);
  double _progress = 0.0;
  Sound? _sound;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(_duration, (timer) {
      setState(() {
        _progress += 0.001;
        if (_progress == 1.0) {
          context.read<PxOverlay>().toggleOverlay(
                id: widget.notification.id,
                child: widget,
                context: context,
              );
          timer.cancel();
        }
      });
    });
  }

  bool isEngineInit = false;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    try {
      if (!isEngineInit) {
        await engine.init();
      }
    } catch (e) {
      isEngineInit = true;
    }
    await playSound();
    // print(isEngineInit);
  }

  Future<void> playSound() async {
    _sound = await engine.loadSoundFile('assets\\sounds\\notification2.wav');
    if (_sound != null) {
      _sound?.volume = 10;
      await engine.start();
      _sound?.play();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    _sound?.unload();

    super.dispose();
  }

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<PxOverlay>(
      builder: (context, o, _) {
        final index = o.overlays.keys
            .toList()
            .indexWhere((e) => e == widget.notification.id);
        return Padding(
          padding: EdgeInsets.only(
            top: (index * 120.0) + 12,
            right: 12,
          ),
          child: Align(
            alignment: _isExpanded ? Alignment.topCenter : Alignment.topRight,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.3,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      setState(() {
                        _isExpanded = value;
                      });
                    },
                    trailing: FloatingActionButton.small(
                      heroTag: DateTime.now().toIso8601String(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        timer?.cancel();
                        o.toggleOverlay(
                          id: widget.notification.id,
                          child: widget,
                          context: context,
                        );
                      },
                      child: const Icon(Icons.check),
                    ),
                    leading: const CircleAvatar(
                      child: Icon(Icons.info),
                    ),
                    title: Text(
                      widget.notification.titleEn,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.cyanAccent,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.red),
                        value: _progress,
                      ),
                    ),
                    children: [
                      SelectableText(
                        widget.notification.descriptionEn,
                      ),
                      if (widget.notification.visitid != null)
                        GestureDetector(
                          onTap: () {
                            //TODO: complete
                            //TODO: extract into a separate widget
                          },
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder<Visit?>(
                                future: VisitRequests.fetchVisitById(
                                    widget.notification.visitid!),
                                builder: (context, snapshot) {
                                  while (snapshot.connectionState ==
                                      ConnectionState.active) {
                                    return const CentralLoading();
                                  }
                                  final visit =
                                      snapshot.hasData ? snapshot.data : null;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SelectableText(
                                          "Patient Name : ${visit?.ptName}"),
                                      SelectableText(
                                          "Patient Phone : ${visit?.phone}"),
                                      SelectableText(
                                          "Visit Date : ${formatDateWithoutTime(visit!.visitDate)}"),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                    ],
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
