import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  // Screen Dimensions
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  // Percentage based sizing
  // usage: context.h(0.1) -> 10% of screen height
  double h(double percent) => height * percent;

  // usage: context.w(0.1) -> 10% of screen width
  double w(double percent) => width * percent;
}
