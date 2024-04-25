import 'package:flutter/material.dart';

class RDColorSchemes{
  static ColorScheme white = ColorScheme.fromSeed(
    seedColor: const Color(0xFF740000),

    background: const Color(0xFFd9d9d9),
    surface: const Color(0xFFFFFFFF),
    // primary: idk
    primaryContainer: const Color(0xFF740000),
    onPrimaryContainer: const Color(0xFFFFFFFF),

  );

  static ColorScheme scarlet = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFFFFF),

    surface: const Color(0xFF740000),
    onSurface: const Color(0xFFFFFFFF),
    // primary: idk
    primaryContainer: const Color(0xFFFFFFFF),
    onPrimaryContainer: const Color(0xFF000000),

  );
}