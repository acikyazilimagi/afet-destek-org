import 'package:deprem_destek/gen/assets.gen.dart';
import 'package:deprem_destek/pages/auth_page/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KVKKPage extends StatefulWidget {
  const KVKKPage({super.key});
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(builder: (context) => const KVKKPage()),
    );
  }

  @override
  State<KVKKPage> createState() => _KVKKPageState();
}

class _KVKKPageState extends State<KVKKPage> {
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'KVKK Açık Rıza Metni',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                kvkkPageString1,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                kvkkPageString2,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
