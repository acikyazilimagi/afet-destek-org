import 'package:afet_destek/shared/widgets/desktop_app_bar.dart';
import 'package:afet_destek/shared/widgets/mobile_app_bar.dart';
import 'package:flutter/material.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveAppBar({
    super.key,
    this.mobileTile,
    this.desktopTile,
    this.title,
    this.hasMobileLeading = false,
  });
  final Widget? mobileTile;
  final bool hasMobileLeading;
  final Widget? desktopTile;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 1000) {
      return MobileAppBar(
        tile: mobileTile,
        hasMobileLeading: hasMobileLeading,
        title: title,
      );
    }
    return DesktopAppBar(tile: desktopTile);
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
