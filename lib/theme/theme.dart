import 'dart:math' show Random;

import 'package:flutter/material.dart';

class ThemeConstants {
  const ThemeConstants();
  static final _containerDecoration = BoxDecoration(
    // color: Colors.white54.withOpacity(0.8),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        offset: const Offset(2, 2),
        blurRadius: 5,
        spreadRadius: 5,
      ),
    ],
  );
  static BoxDecoration get cd => _containerDecoration;
}
