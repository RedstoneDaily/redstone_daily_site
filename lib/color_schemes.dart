import 'package:flutter/material.dart';

class RDColors{

  // 白色主题
  static ColorScheme white = ColorScheme.fromSeed(
    seedColor: const Color(0xFF740000),

    background: const Color(0xFFd9d9d9),
    surface: const Color(0xFFFFFFFF),
    // primary: idk
    primaryContainer: const Color(0xFF740000),
    onPrimaryContainer: const Color(0xFFFFFFFF),

  );

  // 深红主题
  static ColorScheme scarlet = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFFFFF),

    surface: const Color(0xFF740000),
    onSurface: const Color(0xFFFFFFFF),
    // primary: idk
    primaryContainer: const Color(0xFFFFFFFF),
    onPrimaryContainer: const Color(0xFF000000),

  );

  // 玻璃（图片背景）主题
  // 容器全部透明 文字主色为白 红 深红
  // 鬼知道为什么m3主题没有focus/decoration的颜色（恼
  static ColorScheme glass = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFFFFF),

    surface: const Color(0x00000000),
    onSurface: const Color(0xFFFFFFFF),
    primary: const Color(0x00000000),
    onPrimary: const Color(0xFFFFFFFF),
    primaryContainer: const Color(0x22000000),
    onPrimaryContainer: const Color(0xFFFFFFFF),
    secondary: const Color(0x00000000),
    onSecondary: const Color(0xFFF00000),
    tertiary: const Color(0x00000000),
    onTertiary: const Color(0xFF740000),

  );
}