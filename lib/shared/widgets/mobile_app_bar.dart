import 'package:afet_destek/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MobileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileAppBar({
    super.key,
    this.tile,
    this.title,
    this.hasMobileLeading = false,
  });
  final bool hasMobileLeading;
  final String? title;
  final Widget? tile;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [if (tile != null) tile!],
      title: title != null ? Text(title!) : null,
      leading: hasMobileLeading
          ? Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SvgPicture.asset(Assets.logoSvg),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
