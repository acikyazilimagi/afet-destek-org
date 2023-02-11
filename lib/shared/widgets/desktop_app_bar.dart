import 'package:afet_destek/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DesktopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DesktopAppBar({super.key, this.tile});
  final Widget? tile;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Material(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SvgPicture.asset(Assets.appbarLogo),
              ),
              if (tile != null) tile!,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
