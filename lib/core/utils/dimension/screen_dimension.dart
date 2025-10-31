import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ScreenDimension {
  static List<Breakpoint> breakpoint = [
    const Breakpoint(start: 0, end: 575, name: MOBILE),
    const Breakpoint(start: 576, end: 991, name: TABLET),
    const Breakpoint(start: 992, end: 1920, name: DESKTOP),
    const Breakpoint(start: 1921, end: double.infinity, name: '4K')
  ];

  static List<Breakpoint> breakpointsLandscape = [
    Breakpoint(start: 576, end: 767, name: MOBILE),
    Breakpoint(start: 768, end: 991, name: TABLET),
    Breakpoint(start: 992, end: 1400, name: DESKTOP),
    Breakpoint(start: 1401, end: double.infinity, name: '4K'),
  ];

  static bool isMobile(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isMobile;
  static bool isTablet(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isTablet;
  static bool isDesktop(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isDesktop;
}
