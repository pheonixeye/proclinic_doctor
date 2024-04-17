import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:minisound/minisound.dart';
import 'package:proclinic_doctor_windows/main_init.dart';
import 'package:proclinic_doctor_windows/providers/overlay_provider.dart';
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
          context.read<PxOverlay>().toggleOverlay(widget, context);
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36.0),
      child: Align(
        alignment: Alignment.topRight,
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
                trailing: FloatingActionButton.small(
                  heroTag: DateTime.now().toIso8601String(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    timer?.cancel();
                    context.read<PxOverlay>().toggleOverlay(widget, context);
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
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                    value: _progress,
                  ),
                ),
                children: [
                  SelectableText(
                    widget.notification.descriptionEn,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
