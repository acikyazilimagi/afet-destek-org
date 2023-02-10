import 'package:flutter/material.dart';

class ListViewResponsive extends StatelessWidget {
  const ListViewResponsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    required this.largeDesktop,
  });
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  final Widget largeDesktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 2000) {
          return largeDesktop;
        } else if (constraints.maxWidth < 2000 && constraints.maxWidth > 1400) {
          return desktop;
        } else if (constraints.maxWidth <= 1400 &&
            constraints.maxWidth >= 1000) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
