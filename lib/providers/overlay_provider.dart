import 'package:flutter/material.dart';

class PxOverlay extends ChangeNotifier {
  Map<String, OverlayEntry> _overlays = {};
  Map<String, OverlayEntry> get overlays => _overlays;

  void toggleOverlay({
    required String id,
    required Widget child,
    required BuildContext context,
  }) {
    _overlays[id] != null
        ? removeOverlay(id)
        : _insertOverlay(
            id: id,
            child: child,
            context: context,
          );
  }

  void removeOverlay(String id) {
    _overlays[id]?.remove();
    _overlays.remove(id);
  }

  void _insertOverlay({
    required String id,
    required Widget child,
    required BuildContext context,
  }) {
    _overlays[id] = OverlayEntry(
      builder: (context) {
        return child;
      },
    );

    Overlay.of(context).insert(_overlays[id]!);
  }
}
