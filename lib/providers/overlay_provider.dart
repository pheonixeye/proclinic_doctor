import 'package:flutter/material.dart';

class PxOverlay extends ChangeNotifier {
  OverlayEntry? _overlayEntry;
  OverlayEntry? get overlayEntry => _overlayEntry;

  //TODO: make notifications stack in a column with downward replacement animation

  bool get isOverlayShown => _overlayEntry != null;

  void toggleOverlay(Widget child, BuildContext context) {
    isOverlayShown ? _removeOverlay() : _insertOverlay(child, context);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _insertOverlay(Widget child, BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return child;
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }
}
