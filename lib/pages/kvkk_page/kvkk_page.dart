import 'package:afet_destek/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TermsPage extends StatefulWidget {
  const TermsPage._({required this.title, required this.body});
  final String title;
  final String body;
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String body,
  }) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => TermsPage._(body: body, title: title),
      ),
    );
  }

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SvgPicture.asset(Assets.logoSvg),
          ),
        ],
        leadingWidth: 52,
      ),
      body: Center(
        child: SizedBox(
          width: 700,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.body,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
