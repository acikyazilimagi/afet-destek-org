import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../../gen/assets.gen.dart';

class KvkkPage extends StatelessWidget {
  final String? kvkkText;
  // or webview
  const KvkkPage({super.key, this.kvkkText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar() => AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(Assets.logoSvg),
        ),
        leadingWidth: 52,
      );

  Column buildBody(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [buildBackIcon(context), Expanded(child: buildKvkkText())],
      );

  Text buildKvkkText() => Text(kvkkText ?? "KVKK metni" * 100000);

  Padding buildBackIcon(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      );
}
