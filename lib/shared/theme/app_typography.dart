import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static const display = TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.8,
    height: 1.0,
  );

  static const heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static const title = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  static const body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const caption = TextStyle(fontSize: 13, fontWeight: FontWeight.w400);
}
