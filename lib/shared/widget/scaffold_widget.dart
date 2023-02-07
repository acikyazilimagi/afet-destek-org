import 'package:deprem_destek/shared/config/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScaffoldWidget extends StatefulWidget {
  const ScaffoldWidget({
    super.key,
    this.endDrawer,
    this.body,
    this.scaffoldKey,
    this.title,
  });

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Widget? endDrawer;
  final Widget? body;
  final String? title;

  @override
  State<ScaffoldWidget> createState() => ScaffoldWidgetState();

  static ScaffoldWidgetState of(BuildContext context) {
    final result = context.findAncestorStateOfType<ScaffoldWidgetState>();
    if (result != null) return result;
    throw FlutterError('YardımAğıScaffold of() error !!! $context');
  }
}

class ScaffoldWidgetState extends State<ScaffoldWidget> {
  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: AppBar(
        title: widget.title != null
            ? Text(
                widget.title!,
                style: TextStyle(color: ColorPalette.primaryColor),
              )
            : null,
        backgroundColor: ColorPalette.backgroundColor,
        leading: SvgPicture.asset(
          'vector.svg',
          color: ColorPalette.primaryColor,
        ),
        actions: [
          if (widget.endDrawer != null)
            IconButton(
              onPressed: () {
                widget.scaffoldKey?.currentState?.openEndDrawer();
              },
              color: ColorPalette.primaryColor,
              icon: const Icon(Icons.menu),
            )
        ],
      ),
      endDrawer: widget.endDrawer,
      body: widget.body,
    );
  }
}
